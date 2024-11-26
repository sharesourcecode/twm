Copyright (c) 2019-2024 Ueliton Alves Dos Santos
Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
# TWM(Titans War Macro)
Macro scripts for titanswar.net on all servers


**Level 16+ and 50 training points required to enter some battles**

***Instructions for iPhone and Android 7, or higher***

[![asciicast](https://asciinema.org/a/5tjdRTdLSgCu1ciDKeBBVgUu0.svg)](https://tube.tchncs.de/w/5i2ELTdjbnhgAV2zMVACgM?start=13s&stop=17m10s&autoplay=1)

1. > - On your iPhone, open the iSH app(https://ish.app/).
> Then type, or copy and paste to update the package lists

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16"/> iSH
```bash
apk update
```
> - On Android, open the Termux app(https://f-droid.org/repo/com.termux_1020.apk) and type or paste the commands below to update the packages.
* Questions may arise.

* For two options (Y/n) answer Y

* For multiple options (Y/I/N/O/D/Z) just press ENTER to proceed.

<img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux
```bash
pkg update -y ; pkg upgrade
```
>2 - Type or copy and paste this command to download the required packages

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16"/> iSH
```bash
apk add curl ; apk add w3m ; apk add procps ; apk add coreutils ; apk add --no-cache tzdata
```
<img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux
```bash
pkg install w3m termux-api procps coreutils ncurses-utils 
```
>3 - Copy and paste this command to download the twm installer (The link is part of the command)

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16" /> iSH | <img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux 
```bash
curl https://raw.githubusercontent.com/sharesourcecode/twm/refs/heads/master/easyinstall.sh -L -O
```
>4 - Give the installer execute permission

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16" /> iSH | <img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux
```bash
chmod +x easyinstall.sh
```

>5 - Copy and paste this command to install twm

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16" /> iSH | <img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux
```bash
./easyinstall.sh
```

>6 - To run twm

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16" /> iSH | <img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux
```bash
./twmu.sh
```

Run in cave mode

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16" /> iSH | <img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux
```bash
./twmu -cv
```

Coliseum priority mode

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16" /> iSH | <img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux

```bash
./twmu -cl
```

* To interrupt `Ctrl c` or force stop the Apps.

* To uninstall scripts on both systems:

```bash
rm -rf $HOME/TitansWarMacro-master
```

* Remove Termux boot shortcut on Android:

```bash
rm -rf $HOME/.termux/boot/play.sh
```
***Demo video for Android***

[![asciicast](https://asciinema.org/a/5tjdRTdLSgCu1ciDKeBBVgUu0.svg)](https://tube.tchncs.de/w/ejaAKjRBQqxig1V3m4EGQW?start=0s&stop=1m10s&autoplay=1&muted=1)

***
***Windows com Cygwin***

>1 - Abra o progama Cygwin(https://www.cygwin.com/setup-x86_64.exe) ou (https://www.cygwin.com/setup-x86.exe) como adiministrador no Windows. Na instalação selecione qualquer link, a parti daí é só dá Next até concluir. Em sequida com adiministrador abra o Cygwin Terminal que foi instalado. Digite, ou copie e cole o comando abaixo para baixar o instalador do twm(O link faz parte do comando):

```bash
curl https://raw.githubusercontent.com/sharesourcecode/twm/refs/heads/master/easyinstall.sh -L -O
```

>2 - Dê permissão de execução para o instalador:

```bash
chmod +x easyinstall.sh
```
>3 - Copie e cole este comando para instalar o twm:

```bash
bash $HOME/easyinstall.sh
```

>4 - Para executar o twm:

```bash
bash twmu
```

Executar em modo caverna:

```bash
bash twmu -cv
```

Modo de prioridade coliseu:

```bash
bash twmu -cl
```

`Para interroper (CTRL c) ou feche o programa Cygwin`

***
***Distribuição Alt Linux, ou base Debian e Ubuntu - Windows WSL***

>1 - No emulador de terminal digite, ou copie e cole para atualizar as listas de pacotes:

```bash
sudo apt-get update -y
```

>2 - Digite ou copie e cole este comando para baixar os pacotes necessários:

```bash
sudo apt-get install curl w3m procps -y
```

Opcional:
```bash
sudo apt-get install coreutils dnsutils-y
```

>3 - Copie e cole este comando para baixar o instalador do twm(O link faz parte do comando):

```bash
curl https://raw.githubusercontent.com/sharesourcecode/twm/refs/heads/master/easyinstall.sh -L -O
```

>4 - Dê permissão de execução para o instalador:

```bash
chmod +x easyinstall.sh
```
>5 - Copie e cole este comando para instalar o twm:

```bash
bash easyinstall.sh
```

>6 - Comando para executar o twm:

```bash
bash twmu
```

Executar em modo caverna:

```bash
bash twmu -cv
```

Modo de prioridade coliseu:

```bash
bash twmu -cl
```

`Para interroper (CTRL c)`

***

## **☕ Donates/Doações:**

**Pix: ueliton+inter@disroot.org** <br>

<img src="https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white" height="33" width="130" /><br>**ueliton@disroot.org** <br>

***
