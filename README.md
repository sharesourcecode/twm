Copyright (c) 2019-2024 Ueliton Alves Dos Santos
Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
# TWM(Titans War Macro)
Scripts macros para titanswar.net em todos os servidores.


**Necessário level 16+ e 50 pontos de treinamento para entrar em algumas batalhas**

***Recomendado para Iphone***

[![asciicast](https://asciinema.org/a/5tjdRTdLSgCu1ciDKeBBVgUu0.svg)](https://tube.tchncs.de/w/5i2ELTdjbnhgAV2zMVACgM?start=13s&stop=17m10s&autoplay=1)

1. >  - No Iphone abra o app iSH(https://ish.app/).
> Em seguida digite, ou copie e cole para atualizar as listas de pacotes

>Iphone(iSH):
```bash
apk update
```

>2 - Digite ou copie e cole este comando para baixar os pacotes necessários

>Iphone(iSH):
```bash
apk add curl ; apk add w3m ; apk add procps ; apk add coreutils ; apk add --no-cache tzdata
```

>3 - Copie e cole este comando para baixar o instalador do twm(O link faz parte do comando)

>Iphone(iSH):
```bash
curl https://raw.githubusercontent.com/sharesourcecode/twm/refs/heads/master/easyinstall.sh -L -O
```

>4 - Dê permissão de execução para o instalador

>Iphone(iSH):
```bash
chmod +x easyinstall.sh
```

>5 - Copie e cole este comando para instalar o twm

>Iphone(iSH):
```bash
./easyinstall.sh
```

>6 - Para executar o twm

>Iphone(iSH):
```bash
./twmu.sh
```

Executar em modo caverna no Iphone(iSH):

```bash
./twmu -cv
```

Modo de prioridade coliseu no Iphone(iSH):

```bash
./twmu -cl
```

* Para interromper `Ctrl c` ou force a parada dos Apps.

* Para desinstalar scripts em ambos sistemas:

```bash
rm -rf $HOME/TitansWarMacro-master
```

***Alternativa para Android 7 ou superior***

[![asciicast](https://asciinema.org/a/5tjdRTdLSgCu1ciDKeBBVgUu0.svg)](https://tube.tchncs.de/w/ejaAKjRBQqxig1V3m4EGQW?start=0s&stop=1m10s&autoplay=1&muted=1)

>1 - Abra o app Termux(https://f-droid.org/repo/com.termux_1020.apk) no Android e digite ou cole os comandos abaixo para atualizar os pacotes.

* Podem ocorrer questões.

* Para duas opções (Y/n) responda Y

* Para múltiplas opções (Y/I/N/O/D/Z) apenas pressione ENTER para prosseguir.

```bash
pkg update -y ; pkg upgrade
```
Também:
```bash
pkg install w3m termux-api procps coreutils ncurses-utils 
```
>2 - Copie e cole este comando para baixar o instalador do twm(O link faz parte do comando):
```bash
curl https://raw.githubusercontent.com/sharesourcecode/twm/refs/heads/master/easyinstall.sh -L -O
```
>3 - Dê permissão de execução para o instalador:

```bash
chmod +x easyinstall.sh
```
>4 - Copie e cole este comando para instalar o twm:
```bash
./easyinstall.sh
```
>5 - Para executar o twm:
```bash
./twmu
```
Executar o modo Caverna:
```bash
./twmu -cv
```
Modo de prioridade Coliseum:
```bash
./twmu -cl
```
Para ver estatísticas do servidor digite "online" e confirme, quando estiver na seguinte seção:
![](https://codeberg.org/ueliton/auth/raw/branch/main/images/cygwin/1/online.png)

* Para interromper `Ctrl c` ou force a parada do App Termux.

* Para desinstalar scripts:

```bash
rm -rf $HOME/TitansWarMacro-master
```
* Remover atalho do Termux boot:

```bash
rm -rf $HOME/.termux/boot/play.sh
```

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
