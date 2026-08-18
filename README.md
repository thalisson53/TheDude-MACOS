# 🖥️ TheDude MACOS

## 📥 Download do TheDude MACOS

O download do **TheDude MACOS** agora é disponibilizado através do Gumroad.

### 💙 Contribuição para manutenção do projeto

Para ajudar a manter o projeto ativo, corrigir problemas, testar novas versões do macOS e continuar desenvolvendo melhorias, foi definida uma **contribuição mínima de US$ 2** para realizar o download.

> **Importante:** esse valor é destinado ao desenvolvimento e à manutenção do projeto **TheDude MACOS**. O projeto é independente e não representa uma venda ou licença oficial do MikroTik The Dude ou WinBox.

### 👉 [Baixar TheDude MACOS por US$ 2](https://thalisson5.gumroad.com/l/thedude-macos-apple-silicon)

O pagamento é realizado pelo Gumroad e, após a conclusão, o download do pacote é liberado automaticamente.

---

### O que sua contribuição ajuda a manter

* Compatibilidade com novas versões do macOS
* Testes em Apple Silicon
* Atualizações do Wine
* Correções de bugs
* Melhorias na interface
* Backup e restauração
* Integração com WinBox
* Documentação e suporte ao projeto

Obrigado por apoiar o desenvolvimento do **TheDude MACOS**. 💙


> O jeito prático de instalar e gerenciar o MikroTik The Dude no macOS com Apple Silicon.

**Apple Silicon** • **The Dude 7.23.3** • **WinBox incluído** • **Perfis isolados** • **Backup e restauração**

<p align="center">
  <img src="docs/thedude-macos-interface.png" alt="Painel principal do TheDude MACOS" width="900">
</p>

O **TheDude MACOS** instala e gerencia o MikroTik The Dude em Macs com processador Apple Silicon. Cada instalação recebe um ambiente Wine independente, um nome próprio e um atalho no Dock — tudo controlado por uma interface simples, sem precisar abrir o Terminal no uso diário.

## ✨ Destaques

| Recurso | O que ele faz |
|---|---|
| 🧩 Perfis independentes | Crie Matriz, Filial, Cliente A e quantos ambientes precisar. |
| 🪟 WinBox incluído | Envia o `winbox.exe` diretamente para o disco C: de cada perfil. |
| 🚀 Atalhos no Dock | Abra cada Dude pelo nome escolhido, sem janela de Terminal. |
| ✨ Retina por perfil | Ative ou desative a renderização Retina separadamente em cada ambiente. |
| 💾 Backup e restauração | Proteja conexões, preferências e todo o disco C: do perfil. |
| 🛠️ Manutenção integrada | Repare atalhos, atualize o Wine, abra logs e encerre processos travados. |
| 🍎 Feito para Apple Silicon | Preparado para Macs M1, M2, M3, M4 ou posteriores. |

## 🧭 Navegação rápida

- [Requisitos](#-requisitos)
- [Primeira abertura](#-primeira-abertura)
- [Instalar perfis](#-instalar-o-primeiro-the-dude)
- [Instalar e configurar o WinBox](#-instalar-o-winbox-em-um-perfil)
- [Backup e restauração](#-backup)
- [Solução de problemas](#-solução-de-problemas)
- [Apoie o projeto](#-ajude-o-projeto-a-crescer)

O projeto é dedicado exclusivamente a duas ferramentas:

- MikroTik The Dude 7.23.3.
- MikroTik WinBox para Windows, incluído no aplicativo.
- Atalho de cada The Dude com ícone azul “Windows no Mac”, sem o ícone branco do AppleScript.
- O nome escolhido também é o nome físico do aplicativo, por isso permanece visível no Dock enquanto o Dude está aberto.
- Instalar, reparar, renomear ou desinstalar um perfil atualiza o Dock sem reiniciá-lo, mantendo as janelas minimizadas fechadas.

Você pode criar quantos perfis do The Dude precisar. Por exemplo: Matriz, Filial, Cliente A e Cliente B. Os dados, conexões e preferências de um perfil não são misturados com os demais.

## ✅ Requisitos

- Mac com processador Apple M1, M2, M3, M4 ou posterior.
- macOS 13 ou posterior.
- Conexão com a internet durante a preparação inicial.
- Conta com permissão administrativa para instalar Homebrew e Wine.
- Espaço livre para os ambientes do The Dude.

## 📦 Conteúdo do pacote

- `TheDude MACOS.app`: painel principal.
- Instalador do The Dude 7.23.3 incluído no aplicativo.
- `winbox.exe` incluído no aplicativo.
- Criador de atalhos para o Dock.
- Ferramentas de backup, restauração, reparo e desinstalação.
- `README.md`: documentação em português.
- `README-EN.md`: documentation in English.
- Pasta `docs` com os prints e o QR Code do projeto.

O Wine não fica dentro do ZIP porque é compartilhado por todos os perfis e ocupa mais espaço. Ele é preparado somente uma vez no Mac.

## 🚀 Primeira abertura

1. Extraia o ZIP.
2. Abra `TheDude MACOS.app`.
3. Na seção **Preparação do sistema**, verifique o Homebrew.
4. Se o Homebrew estiver vermelho, clique em **Instalar**.
5. Conclua a instalação no Terminal. Quando o macOS pedir a senha, digite-a e pressione Enter. A senha não aparece na tela enquanto é digitada.
6. Volte ao TheDude MACOS.
7. Quando o Homebrew estiver verde, clique para instalar o Wine Stable.
8. Clique em **Verificar** para confirmar que o Wine está autorizado.

Depois dessa preparação, novos perfis podem ser instalados sem repetir essas etapas.

> **Atenção em um Mac novo:** durante a primeira instalação, o Wine pode precisar instalar o `gstreamer-runtime`. Esse componente solicita a senha de administrador e, em algumas versões, não consegue fazer isso diretamente pela janela do TheDude MACOS. Se aparecer a mensagem `sudo: a terminal is required to read the password`, siga as instruções da seção de solução de problemas abaixo.

## 🔐 Se o macOS bloquear o Wine

Se aparecer a mensagem informando que a Apple não conseguiu verificar o Wine:

1. Não escolha **Mover para o Lixo**.
2. Clique em **OK**.
3. Abra **Ajustes do Sistema > Privacidade e Segurança**.
4. Localize o aviso referente ao Wine Stable.
5. Clique em **Abrir Mesmo Assim**.
6. Confirme com sua senha ou Touch ID.
7. Volte ao TheDude MACOS e clique em **Verificar**.

O botão **Abrir Privacidade e Segurança** leva diretamente a essa área dos Ajustes do Sistema.

## ➕ Instalar o primeiro The Dude

1. Localize a seção **Instalar novo The Dude**.
2. Digite um nome para identificar o perfil, como `Matriz`.
3. Clique em **Instalar The Dude**.
4. Aguarde a confirmação.

O aplicativo criará:

- Um ambiente Wine independente.
- Um disco C: exclusivo.
- Um atalho no Dock.
- Um nome visível, como `The Dude - Matriz`.

Os dados internos ficam em:

`~/Library/Application Support/TheDude-1`

## 🧩 Instalar outros perfis

Para adicionar outro Dude, repita o mesmo procedimento:

1. Digite outro nome, como `Filial Centro`.
2. Clique em **Instalar The Dude**.
3. Aguarde a conclusão.

O próximo perfil será armazenado como `TheDude-2`, depois `TheDude-3` e assim sucessivamente. Não existe um limite definido pelo gerenciador; o limite prático é o espaço disponível no Mac.

## 🪟 Instalar o WinBox em um perfil

O WinBox já está incluído no TheDude MACOS. Não é necessário procurar ou selecionar o arquivo manualmente.

1. Localize o cartão do Dude desejado.
2. Clique em **Instalar WinBox**.
3. Aguarde a confirmação.

O arquivo será enviado automaticamente para o disco C: daquele perfil com o caminho:

`C:\winbox.exe`

Cada Dude possui seu próprio disco C:. Portanto, clique em **Instalar WinBox** em todos os perfis que precisarem dessa ferramenta.

Se já existir um `winbox.exe` nesse caminho, a versão anterior será movida para a Lixeira e substituída pela versão incluída no TheDude MACOS.

## 🔧 Configurar o WinBox no menu Tools do The Dude

No The Dude, abra a configuração de **Tools**, crie ou edite o item WinBox e utilize:

`"C:\winbox.exe" "[Device.FirstAddress]" "[Device.UserName]" "[Device.Password]"`

Assim, ao clicar com o botão direito em um dispositivo e escolher **Tools > WinBox**, o endereço, o usuário e a senha cadastrados no Dude serão enviados ao WinBox.

Se desejar abrir apenas o endereço, use:

`"C:\winbox.exe" "[Device.FirstAddress]"`

## 🎛️ Botões de cada perfil

- **Abrir**: inicia o The Dude sem abrir o Terminal.
- **Abrir disco C:**: mostra no Finder o disco virtual daquele perfil.
- **Instalar WinBox**: envia automaticamente o WinBox incluído para `C:\winbox.exe`, diretamente na raiz do disco C:.
- **Ativar Retina / Desativar Retina**: alterna a renderização em alta resolução somente naquele perfil. Feche o Dude antes de usar e abra-o novamente depois da alteração.
- **Reparar atalho**: recria o aplicativo do Dock sem apagar o ambiente.
- **Renomear**: altera o nome apresentado no painel e no Dock.
- **Backup**: cria um ZIP contendo todo o ambiente do perfil.
- **Desinstalar**: move o ambiente e seu atalho para a Lixeira.

## 🔄 Atualização automática do The Dude

Durante uma atualização, o The Dude pode fechar a janela antiga e iniciar outra. O atalho criado pelo TheDude MACOS aguarda o Wine concluir essa sequência para permitir que o programa reabra normalmente.

Se uma atualização travar, use **Encerrar processos Wine** e depois abra novamente o perfil.

## 💾 Backup

1. Feche o perfil do The Dude.
2. Clique em **Backup** no cartão correspondente.
3. Escolha onde salvar o ZIP.
4. Aguarde a confirmação.

O backup inclui o disco C:, o WinBox instalado, as preferências, conexões e demais arquivos daquele ambiente.

## ♻️ Restaurar backup

1. Clique em **Restaurar backup**.
2. Selecione um ZIP criado pelo TheDude MACOS.
3. Aguarde a restauração.

O perfil restaurado recebe o próximo número interno disponível e não substitui os perfis existentes.

## ✏️ Renomear um perfil

1. Clique em **Renomear**.
2. Informe o novo nome.
3. Clique em **Salvar**.

O nome do aplicativo e a entrada do Dock serão atualizados. Conexões e preferências não são alteradas.

Regras para nomes:

- O nome é obrigatório.
- Use no máximo 50 caracteres.
- Não use `&`, `<`, `>`, `/`, `\` ou `:`.

## 🗑️ Desinstalar um perfil

1. Feche o The Dude correspondente.
2. Clique em **Desinstalar**.
3. Confirme a operação.

O ambiente completo e o atalho serão movidos para a Lixeira. Os outros perfis não serão afetados. Enquanto a Lixeira não for esvaziada, os arquivos poderão ser recuperados.

## 🧰 Ferramentas do Wine

- **Atualizar Wine**: procura uma versão mais recente pelo Homebrew.
- **Encerrar processos Wine**: fecha processos travados dos ambientes gerenciados.
- **Configurar ambiente**: permite escolher um perfil e abrir o `winecfg`.
- **Abrir logs**: abre os registros usados para diagnóstico.

## 🧳 Levar para outro Mac

O ZIP do TheDude MACOS pode ser copiado para outro Mac Apple Silicon. No outro equipamento:

1. Extraia o pacote.
2. Abra `TheDude MACOS.app`.
3. Prepare Homebrew e Wine na primeira abertura.
4. Instale novos perfis ou restaure os backups desejados.

Homebrew e Wine precisam ser preparados separadamente em cada Mac. Os instaladores do Dude e do WinBox já acompanham o aplicativo.

## 🩺 Solução de problemas

### O Wine foi bloqueado

Use **Ajustes do Sistema > Privacidade e Segurança > Abrir Mesmo Assim** e depois clique em **Verificar**.

### Erro do GStreamer ao instalar o Wine em um Mac novo

Se a instalação mostrar mensagens como:

```text
sudo: a terminal is required to read the password
sudo: a password is required
Error: Failure while executing gstreamer-runtime
```

isso significa que o Wine tentou instalar o **GStreamer Runtime**, mas o instalador precisa da senha de administrador e não encontrou uma janela de Terminal para solicitá-la. O problema não é a senha nem o The Dude; é apenas a ausência de um Terminal interativo durante essa etapa do Homebrew.

Para concluir:

1. Abra o aplicativo **Terminal** do macOS.
2. Execute:

   ```bash
   /opt/homebrew/bin/brew install --cask wine-stable
   ```

3. Quando solicitado, digite a senha do usuário administrador e pressione Enter. A senha não aparece na tela enquanto é digitada.
4. Aguarde o Homebrew finalizar a instalação do GStreamer e do Wine.
5. Volte ao **TheDude MACOS** e clique em **Verificar**.

O aviso informando que o `gstreamer-runtime` não passou na verificação do Gatekeeper não é, por si só, a causa dessa falha. A mensagem determinante é `a terminal is required to read the password`.

### O The Dude não abre

1. Clique em **Encerrar processos Wine**.
2. Clique em **Reparar atalho**.
3. Tente abrir novamente.
4. Consulte **Abrir logs** se o problema continuar.

### O WinBox não aparece no Tools

Confirme que o comando utiliza exatamente `C:\winbox.exe` e que o botão **Instalar WinBox** foi executado naquele perfil específico.

### O WinBox não está no disco C:

Clique novamente em **Instalar WinBox** no cartão correto. O gerenciador substituirá automaticamente o arquivo.

### O nome ou ícone antigo continua no Dock

Clique em **Reparar atalho**. O TheDude MACOS atualizará o Launch Services, o cache de ícones e a entrada do Dock.

## 🛡️ Segurança

- Não desative o Gatekeeper globalmente.
- Mantenha macOS, Homebrew e Wine atualizados.
- Proteja os backups, pois eles podem conter endereços, usuários e senhas salvas.
- Use somente o pacote do TheDude MACOS recebido de uma fonte confiável.

## 💙 Ajude o projeto a crescer

Se o **TheDude MACOS** facilitou seu trabalho, considere apoiar o projeto com uma doação de qualquer valor. Sua contribuição ajuda a manter o aplicativo, corrigir problemas, criar melhorias e tornar o The Dude cada vez mais fácil de usar no Mac. 🚀

### Chave Pix

```text
65e1147b-43b4-4b5f-9272-419f0ac8c526
```

Escaneie o QR Code abaixo pelo aplicativo do seu banco:

<p align="center">
  <img src="docs/pix-qrcode.png" alt="QR Code Pix para apoiar o TheDude MACOS" width="320">
</p>

> Cada contribuição faz diferença. Muito obrigado por apoiar o projeto! 🙏💙

## 👨‍💻 Desenvolvedor

Desenvolvido por [Thalisson de Souza](https://www.linkedin.com/in/thalisson-de-souza/).
