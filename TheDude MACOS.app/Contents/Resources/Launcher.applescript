property profileNumber : "PROFILE_NUMBER"

on run
	set userHome to POSIX path of (path to home folder)
	set winePrefix to userHome & "Library/Application Support/TheDude-" & profileNumber
	set dudeExecutable to winePrefix & "/drive_c/Program Files (x86)/Dude/dude.exe"
	set logFile to winePrefix & "/TheDude-launcher.log"
	set wineBinary to "/opt/homebrew/bin/wine"
	if not my fileExists(wineBinary) then set wineBinary to "/usr/local/bin/wine"
	set wineServer to "/opt/homebrew/bin/wineserver"
	if not my fileExists(wineServer) then set wineServer to "/usr/local/bin/wineserver"
	
	if not my fileExists(dudeExecutable) then
		display dialog "O perfil The Dude " & profileNumber & " ainda não está instalado. Execute o kit de instalação novamente." buttons {"OK"} default button "OK" with icon caution
		return
	end if
	
	try
		set runCommand to "/usr/bin/env WINEPREFIX=" & quoted form of winePrefix & " WINEDEBUG=-all " & quoted form of wineBinary & " " & quoted form of dudeExecutable & " >> " & quoted form of logFile & " 2>&1; launch_status=$?; /usr/bin/env WINEPREFIX=" & quoted form of winePrefix & " " & quoted form of wineServer & " -w >> " & quoted form of logFile & " 2>&1; exit $launch_status"
		do shell script "/bin/sh -c " & quoted form of runCommand
	on error errorMessage number errorNumber
		if errorNumber is not -128 then
			display dialog "Não foi possível abrir o The Dude " & profileNumber & "." & return & return & errorMessage buttons {"OK"} default button "OK" with icon stop
		end if
	end try
end run

on fileExists(posixFile)
	try
		do shell script "/bin/test -e " & quoted form of posixFile
		return true
	on error
		return false
	end try
end fileExists
