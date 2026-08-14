#!/bin/bash
set -euo pipefail

resources_dir="$(cd "$(dirname "$0")" && pwd)"
installer_exe="$resources_dir/dude-install-7.23.3.exe"
launcher_template="$resources_dir/Launcher.applescript"
icon_file="$resources_dir/Icon.icns"
user_apps="$HOME/Applications"
log_dir="$HOME/Library/Logs/TheDudeInstaller"
log_file="$log_dir/install.log"

mkdir -p "$user_apps" "$log_dir"
exec 3>>"$log_file"
log() {
  echo "$*" >&3
}

log "Instalação iniciada em $(date)"

if [[ "$(uname -m)" != "arm64" ]]; then
  log "AVISO: este kit foi preparado e testado para Macs Apple Silicon."
fi

brew_bin=""
for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [[ -x "$candidate" ]]; then
    brew_bin="$candidate"
    break
  fi
done

if [[ -z "$brew_bin" ]]; then
  echo "ERRO_HOMEBREW: O Homebrew não está instalado. Acesse https://brew.sh/ e instale-o antes de executar este kit novamente." >&2
  log "Homebrew não encontrado."
  exit 20
fi

if [[ ! -x /opt/homebrew/bin/wine && ! -x /usr/local/bin/wine ]]; then
  log "Instalando Wine Stable..."
  "$brew_bin" install --cask wine-stable >>"$log_file" 2>&1
fi

wine_bin=""
for candidate in /opt/homebrew/bin/wine /usr/local/bin/wine; do
  if [[ -x "$candidate" ]]; then
    wine_bin="$candidate"
    break
  fi
done

if [[ -z "$wine_bin" ]]; then
  echo "ERRO_WINE: O Wine não foi encontrado após a instalação." >&2
  log "Wine não encontrado após a instalação."
  exit 21
fi

profile_number=1
while [[ -e "$HOME/Library/Application Support/TheDude-$profile_number" || -e "$user_apps/The Dude $profile_number.app" ]]; do
  profile_number=$((profile_number + 1))
done

profile_name="${1:-Perfil $profile_number}"
display_name="The Dude - $profile_name"
xml_display_name="$(printf '%s' "$display_name" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')"
launcher_target="$user_apps/$display_name.app"

if [[ -e "$launcher_target" ]]; then
  echo "ERRO_NOME: Já existe um atalho chamado $display_name. Escolha outro nome para identificar este Dude." >&2
  log "Já existe um atalho com o nome $display_name."
  exit 22
fi

prefix="$HOME/Library/Application Support/TheDude-$profile_number"
dude_exe="$prefix/drive_c/Program Files (x86)/Dude/dude.exe"
log "Instalando The Dude $profile_number..."

WINEPREFIX="$prefix" WINEDEBUG=-all "$wine_bin" "$installer_exe" /S >>"$log_file" 2>&1
if [[ ! -f "$dude_exe" ]]; then
  echo "ERRO_PERFIL: Não foi possível criar o perfil $profile_number." >&2
  log "Falha ao criar o perfil $profile_number."
  exit 30
fi

printf '%s\n' "$profile_name" > "$prefix/profile-name.txt"

temporary_dir="$(mktemp -d '/tmp/thedude-launcher.XXXXXX')"
trap 'rm -rf "$temporary_dir"' EXIT
launcher_source="$temporary_dir/Launcher.applescript"
launcher_app="$temporary_dir/The Dude $profile_number.app"

sed "s/PROFILE_NUMBER/$profile_number/g" "$launcher_template" >"$launcher_source"
osacompile -o "$launcher_app" "$launcher_source"
cp "$icon_file" "$launcher_app/Contents/Resources/WindowsAppIcon.icns"
# O osacompile adiciona um catálogo e um nome de ícone próprios do AppleScript.
# Em versões recentes do macOS, esses metadados têm prioridade sobre
# CFBundleIconFile e fazem o Dock mostrar o pergaminho branco. Removê-los deixa
# somente o ícone Windows no Mac fornecido pelo TheDude MACOS.
plutil -remove CFBundleIconName "$launcher_app/Contents/Info.plist" 2>/dev/null || true
[[ ! -e "$launcher_app/Contents/Resources/Assets.car" ]] || \
  mv "$launcher_app/Contents/Resources/Assets.car" "$temporary_dir/Assets.car.inativo"
[[ ! -e "$launcher_app/Contents/Resources/applet.icns" ]] || \
  mv "$launcher_app/Contents/Resources/applet.icns" "$temporary_dir/applet.icns.inativo"
plutil -replace CFBundleIdentifier -string "com.thalissonveloso.thedude.profile$profile_number" "$launcher_app/Contents/Info.plist"
plutil -replace CFBundleName -string "$display_name" "$launcher_app/Contents/Info.plist"
plutil -replace CFBundleDisplayName -string "$display_name" "$launcher_app/Contents/Info.plist"
plutil -replace CFBundleIconFile -string "WindowsAppIcon" "$launcher_app/Contents/Info.plist"
plutil -replace CFBundleVersion -string "$(date +%s)" "$launcher_app/Contents/Info.plist"
xattr -cr "$launcher_app"
codesign --force --deep --sign - "$launcher_app" >>"$log_file" 2>&1
ditto "$launcher_app" "$launcher_target"
touch "$launcher_target"

launch_services="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister"
if [[ -x "$launch_services" ]]; then
  "$launch_services" -u "$launcher_target" >/dev/null 2>&1 || true
  "$launch_services" -f "$launcher_target" >/dev/null 2>&1 || true
fi

# Remove qualquer entrada antiga que tenha reutilizado o mesmo número antes de
# registrar o novo atalho. Isso evita que o Dock recupere o ícone AppleScript.
dock_file="$(mktemp '/tmp/thedude-dock.XXXXXX')"
defaults export com.apple.dock "$dock_file" >/dev/null 2>&1 || true
dock_count="$(/usr/libexec/PlistBuddy -c 'Print :persistent-apps' "$dock_file" 2>/dev/null | grep -c '^    Dict {' || true)"
dock_index=$((dock_count - 1))
while [[ "$dock_index" -ge 0 ]]; do
  dock_bundle="$(plutil -extract "persistent-apps.$dock_index.tile-data.bundle-identifier" raw -o - "$dock_file" 2>/dev/null || true)"
  if [[ "$dock_bundle" == "com.thalissonveloso.thedude.profile$profile_number" ]]; then
    plutil -remove "persistent-apps.$dock_index" "$dock_file"
  fi
  dock_index=$((dock_index - 1))
done
defaults import com.apple.dock "$dock_file" >/dev/null 2>&1 || true
rm -f "$dock_file"

dock_url="$(LAUNCHER_PATH="$launcher_target" /usr/bin/osascript -l JavaScript -e 'ObjC.import("Foundation"); ObjC.unwrap($.NSURL.fileURLWithPath($.NSProcessInfo.processInfo.environment.objectForKey("LAUNCHER_PATH")).absoluteString)')"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$dock_url</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-label</key><string>$xml_display_name</string><key>bundle-identifier</key><string>com.thalissonveloso.thedude.profile$profile_number</string></dict><key>tile-type</key><string>file-tile</string></dict>"

killall iconservicesagent 2>/dev/null || true
/usr/bin/osascript -l JavaScript -e 'ObjC.import("AppKit"); $.NSDistributedNotificationCenter.defaultCenter.postNotificationNameObjectUserInfoDeliverImmediately("com.apple.dock.prefchanged", null, null, true)' >/dev/null 2>&1 || true
log "$display_name instalado em $(date)"
echo "PERFIL_CRIADO=$profile_number"
