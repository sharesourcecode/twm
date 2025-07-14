Copyright (c) 2019-2024 Ueliton Alves Dos Santos
Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
# TWM(Titans War Macro)
Macro scripts for titanswar.net on all servers


**Level 16+ and 50 training points required to enter some battles**

***Instructions for iPhone and Android 7, or higher***

[![asciicast](https://asciinema.org/a/5tjdRTdLSgCu1ciDKeBBVgUu0.svg)](https://tube.tchncs.de/w/5i2ELTdjbnhgAV2zMVACgM?start=13s&stop=17m10s&autoplay=1)

1️⃣　On your iPhone, open the iSH app (https://ish.app/).
> Then type, or copy and paste to update the package lists

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16"/> iSH
```bash
apk update
```
• On Android, open the Termux app ([https://termux.dev/en/](https://termux.dev))
>Then type or paste the commands below to update the packages.
>* Questions may arise.
>* For two options (Y/n) answer Y
>* For multiple options (Y/I/N/O/D/Z) just press ENTER to proceed.

<img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux
```bash
pkg update -y ; pkg upgrade
```
2️⃣　Type or copy and paste this command to download the required packages

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16"/> iSH 👇
```bash
apk add curl ; apk add w3m ; apk add procps ; apk add coreutils ; apk add --no-cache tzdata
```
<img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux 👇
```bash
pkg install w3m termux-api procps coreutils ncurses-utils 
```
3️⃣　Copy and paste this command to download the twm installer (The link is part of the command)

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16" /> iSH | <img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux 
```bash
curl https://git.disroot.org/BourneShell/twm/raw/branch/master/easyinstall.sh -L -O
```
4️⃣　Give the installer execute permission

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16" /> iSH | <img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux
```bash
chmod +x easyinstall.sh
```

5️⃣　Copy and paste this command to install twm

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16" /> iSH | <img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux
```bash
./easyinstall.sh
```

6️⃣　To run twm

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16" /> iSH | <img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux
```bash
./twmu.sh
```

• Run in cave mode

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16" /> iSH | <img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux
```bash
./twmu -cv
```

• Coliseum priority mode

<img src="https://www.apple.com/favicon.ico" height="16" width="16" /> Iphone　<img src=https://ish.app/assets/icon.png height="16" width="16" /> iSH | <img src="https://www.android.com/static/img/favicons/16.png" /> Android　<img src="https://cdn.fosstodon.org/accounts/avatars/108/640/704/836/321/085/original/0e9b031ff15a4c3d.png" height="16" width="16" /> Termux

```bash
./twmu -cl
```

* To interrupt `Ctrl c` or force stop the Apps.

* To uninstall scripts on both systems:

```bash
rm -rf $HOME/twm-master
```

* Remove Termux boot shortcut on Android:

```bash
rm -rf $HOME/.termux/boot/play.sh
```
***
***Alt Linux distribution, or Debian and Ubuntu base - [Windows WSL](https://balta-io.translate.goog/blog/wsl?_x_tr_sl=pt&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=wapp)***

>1 - In the terminal emulator type, or copy and paste to update the package lists:

```bash
sudo apt-get update -y
```

>2 - Type or copy and paste this command to download the required packages:

```bash
sudo apt-get install curl w3m procps -y
```

Opcional:
```bash
sudo apt-get install coreutils dnsutils-y
```

>3 - Copy and paste this command to download the twm installer (The link is part of the command):

```bash
curl https://git.disroot.org/BourneShell/twm/raw/branch/master/easyinstall.sh -L -O
```

>4 - Give execute permission to the installer:

```bash
chmod +x easyinstall.sh
```
>5 - Copy and paste this command to install twm:

```bash
bash easyinstall.sh
```

>6 - Command to run twm:

```bash
bash twmu
```

• Run in cave mode:

```bash
bash twmu -cv
```

• Coliseum Priority Mode:

```bash
bash twmu -cl
```

`Para interroper (CTRL c)`
***
***Windows com Cygwin***

>1 - Open the program Cygwin(https://www.cygwin.com/setup-x86_64.exe) or (https://www.cygwin.com/setup-x86.exe) as an administrator in Windows. During installation, select any link, then just click Next until finished. Then, as an administrator, open the Cygwin Terminal that was installed. Type, or copy and paste the command below to download the twm installer (The link is part of the command):

```bash
curl https://git.disroot.org/BourneShell/twm/raw/branch/master/easyinstall.sh -L -O
```

>2 - Give execute permission to the installer:

```bash
chmod +x easyinstall.sh
```
>3 - Copy and paste this command to install twm:

```bash
bash $HOME/easyinstall.sh
```

>4 - To run twm:

```bash
bash twmu
```

• Run in cave mode:

```bash
bash twmu -cv
```

• Coliseum Priority Mode:

```bash
bash twmu -cl
```

`To interrupt (CTRL c) or close the Cygwin program`

***

## **☕ Donates/Doações:**

**Pix: ueliton+inter@disroot.org** <br>

<img src="https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white" height="33" width="130" /><br>**ueliton@disroot.org** <br>

***
