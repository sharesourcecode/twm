# TWM(Titans War Macro)
Scripts macros para titanswar.net em todos os servidores.

**Necessário level 16+ e 50 pontos de treinamento para entrar em algumas batalhas**
***

***Recomendado para qualquer Android e Iphone***

>1 - No Android abra o app UserLAnd(https://f-droid.org/repo/tech.ula_2927098.apk), instale o Alpine com SSH e entre com a senha que foi criada.
>  - No Iphone abra o app iSH(https://ish.app/).
> Em seguida digite, ou copie e cole para atualizar as listas de pacotes

>Android(UserLAnd):
```bash
sudo apk update
```
>Iphone(iSH):
```bash
apk update
```

>2 - Digite ou copie e cole este comando para baixar os pacotes necessários

>Android(UserLAnd):
```bash
sudo apk add curl ; apk add w3m ; apk add procps ; apk add coreutils ; apk add --no-cache tzdata
```
>Iphone(iSH):
```bash
apk add curl ; apk add w3m ; apk add procps ; apk add coreutils ; apk add --no-cache tzdata
```

>3 - Copie e cole este comando para baixar o instalador do twm(O link faz parte do comando)

>Android(UserLAnd) e Iphone(iSH):
```bash
curl https://codeberg.org/ueliton/auth/raw/branch/main/easyinstall.sh -L -O
```

>4 - Dê permissão de execução para o instalador

>Android(UserLAnd) e Iphone(iSH):
```bash
chmod +x easyinstall.sh
```

>5 - Copie e cole este comando para instalar o twm

>Android(UserLAnd) e Iphone(iSH):
```bash
./easyinstall.sh
```

>6 - Para executar o twm

>Android(UserLAnd) e Iphone(iSH):
```bash
./twm/play.sh
```

Executar em modo caverna no Android(UserLAnd) e Iphone(iSH):

```bash
./twm/play.sh -cv
```

Modo de prioridade coliseu no Android(UserLAnd) e Iphone(iSH):

```bash
./twm/play.sh -cl
```

* Para interromper `Ctrl c` ou force a parada dos Apps.

* Para desinstalar scripts em ambos sistemas:

```bash
rm -rf $HOME/twm
```
***

***Alternativa para Android 7 ou superior***

_[Vídeo Tutorial](https://tube.tchncs.de/videos/embed/53422137-b802-465e-ad49-0a02b406733c)_

>1 - Abra o app Termux(https://f-droid.org/repo/com.termux_118.apk) no Android e digite ou cole os comandos abaixo para atualizar os pacotes.

* Podem ocorrer questões.

* Para duas opções (Y/n) responda Y

* Para múltiplas opções (Y/I/N/O/D/Z) apenas pressione ENTER para prosseguir.

```bash
pkg update -y
```
Também:
```bash
pkg upgrade
```
>2 - Copie e cole este comando para baixar o instalador do twm(O link faz parte do comando):
```bash
curl https://codeberg.org/ueliton/auth/raw/branch/main/easyinstall.sh -L -O
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
./twm/play.sh
```
Executar o modo Caverna:
```bash
./twm/play.sh -cv
```
Modo de prioridade Coliseum:
```bash
./twm/play.sh -cl
```

* Para interromper `Ctrl c` ou force a parada do App Termux.

* Para desinstalar scripts:

```bash
rm -rf $HOME/twm
```
* Remover atalho do Termux boot:

```bash
rm -rf $HOME/.termux/boot/play.sh
```
***

***Windows com Cygwin***

>1 - Abra o progama Cygwin(https://www.cygwin.com/setup-x86_64.exe) ou (https://www.cygwin.com/setup-x86.exe) como adiministrador no Windows. Na instalação selecione qualquer link, a parti daí é só dá Next até concluir. Em sequida com adiministrador abra o Cygwin Terminal que foi instalado. Digite, ou copie e cole o comando abaixo para baixar o instalador do twm(O link faz parte do comando):

```bash
curl https://codeberg.org/ueliton/auth/raw/branch/main/sourceinstall.sh -L -O
```

>2 - Dê permissão de execução para o instalador:

```bash
chmod +x sourceinstall.sh
```
>3 - Copie e cole este comando para instalar o twm:

```bash
bash $HOME/sourceinstall.sh
```

>4 - Para executar o twm:

```bash
bash $HOME/twm/play.sh
```

Executar em modo caverna:

```bash
bash $HOME/twm/play.sh -cv
```

Modo de prioridade coliseu:

```bash
bash $HOME/twm/play.sh -cl
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
curl https://codeberg.org/ueliton/auth/raw/branch/main/sourceinstall.sh -L -O
```

>4 - Dê permissão de execução para o instalador:

```bash
chmod +x sourceinstall.sh
```
>5 - Copie e cole este comando para instalar o twm:

```bash
bash sourceinstall.sh
```

>6 - Comando para executar o twm:

```bash
bash twm/play.sh
```

Executar em modo caverna:

```bash
bash twm/play.sh -cv
```

Modo de prioridade coliseu:

```bash
bash twm/play.sh -cl
```

`Para interroper (CTRL c)`


*Faço atualizações e correções periódicas, caso queira manter os scripts atualizados em seu dispositivo reexecute as instruções acima a partir da segunda etapa.

As atualizações são exibidas nesta página:
https://gitea.com/Ueliton/twm/commits/branch/master

Clique nelas para saber o que foi alterado.

***

## **☕ Donates/Doações:**

https://link.mercadopago.com.br/titanswarmacro

**Pix: ueliton@disroot.org** <br>

<img src="https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white" height="33" width="130" /><br>**ueliton@disroot.org** <br>

***

***Colaboradores***

>Envie o email de sua conta no GitHub e nome, ou apelido(para possíveis créditos) para ueliton@disroot.org

>As contribuições serão aplicadas neste repositório:
```bash
git clone https://github.com/sharesourcecode/twm.git
```

>O código deve ser compatível em bash e principalmente em sh. >Recomenda-se testar no Termux e no UserLAnd, no caso do Iphone use o app iSH.

>Após aprovado, será aplicado com os devidos créditos(inclusive no slogan) em https://gitea.com/Ueliton/twm.git para os usuários finais.
