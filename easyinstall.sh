#!/bin/sh
# $HOME/easyinstall.sh

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

TwmDir="twm-master"
mkdir -p $HOME/$TwmDir

cd $HOME/$TwmDir

Server="https://raw.githubusercontent.com/sharesourcecode/twm/refs/heads/master/"

Uagt='Mozilla/5.0 (SymbianOS/9.4; Series60/5.0 NokiaN97-1/20.0.019; Profile/MIDP-2.1 Configuration/CLDC-1.1) AppleWebKit/525 (KHTML, like Gecko) BrowserNG/7.1.18124'

# Remote LANGUAGE.po
Content=$(curl -H "$Uagt" -s -L "$Server/LANGUAGE.po")

G_T() {

 if [ -z "$Language" ]; then
   Language='2'
 fi

 Translate=`echo "$1"|sed 's/\[/\\[/g;s/\]/\\]/g;s/:/\:/g'`
 Text=$(echo "$Content"|sed -n '/|'"$Translate"'|/p'|awk -F'|' '{print $'$Language'}')

 if [ -z "$Text" ]; then
   echo "$1"
 else
   echo "$Text"
 fi

}

colors() { BlackBlack='\033[00;30m';BlackCyan='\033[01;36m\033[01;07m';BlackGreen='\033[00;32m\033[01;07m';BlackGray='\033[01;30m\033[01;07m';BlackPink='\033[01;35m\033[01;07m';BlackRed='\033[01;31m\033[01;07m';BlackYellow='\033[00;33m\033[01;07m';CyanBlack='\033[36m';CyanCyan='\033[01;36m\033[08;07m';ColorReset='\033[00m';GoldBlack='\033[33m';GreenBlack='\033[32m';PurpleIBlack='\033[03;34m\033[02;03m';PurpleIsBlack='\033[03;34m\033[02;04m';WhiteBlack='\033[37m';WhiteBBlack='\033[01;38m\033[05;01m';};
colors

script_slogan() { Colors="10 9 8 7 6 5 4 3 2 1";t="339";w="59";m="89";Author="$(G_T "author"):\nueliton@disroot.org 2019 — 2024";Collaborator="$(G_T "collaborator"):\n	@_hviegas";for i in $Colors; do clear;t=$((t - 27));w=$((w + 1));m=$((m - 2));printf "\033[1;38;5;${t}m  ╔══╗╔╗╔══╗╔══╗╔══╗╔══╗\n  ╚╗╔╝╠╣╚╗╔╝║╔╗║║╔╗║║══╣\n  ${BlackBlack}═\033[1;38;5;${t}m║║${BlackBlack}═\033[1;38;5;${t}m║║${BlackBlack}═\033[1;38;5;${t}m║║${BlackBlack}═\033[1;38;5;${t}m║╔╗║║║║║╠══║\n  ${BlackBlack}═\033[1;38;5;${t}m╚╝${BlackBlack}═\033[1;38;5;${t}m╚╝${BlackBlack}═\033[1;38;5;${t}m╚╝${BlackBlack}═\033[1;38;5;${t}m╚╝╚╝╚╝╚╝╚══╝\033[1;38;5;${w}m\n       ╔╦═╦╗╔══╗╔══╗\n       ║║║║║║╔╗║║╚╝╣\n       ║║║║║║╔╗║║║╗║\n       ╚═╩═╝╚╝╚╝╚╝╚╝\033[1;38;5;${m}m\n  ╔═╦═╗╔══╗╔══╗╔══╗╔══╗\n  ║║║║║║╔╗║║╔═╝║╚╝╣║╔╗║\n  ║║║║║║╔╗║║╚═╗║║╗║║╚╝║\n  ╚╩═╩╝╚╝╚╝╚══╝╚╝╚╝╚══╝\n  ${ColorReset}\n\n\033[1;38;5;${i}m${Author}\n\033[02m${Collaborator}\n${ColorReset}\n";sleep "0.2";done;};
script_slogan

cd ~/
printf "${BlackCyan} $(G_T "Installing TWM(Developed by Ueliton)")...\n⌛ $(G_T "Please wait")...⌛${ColorReset}\n"

# Termux
if ( case $PREFIX in *termux*) exit 0 ;; esac ); then
 termux-wake-lock

 # DNS
 printf "nameserver 1.1.1.1\nnameserver 1.0.0.1" >$PREFIX/etc/resolv.conf 2> /dev/null

 Ls="/data/data/com.termux/files/usr/share/doc"
 rm -rf ~/.termux/boot/play.sh 2>/dev/null
 mkdir -p ~/.termux/boot
 echo '#!/data/data/com.termux/files/usr/bin/sh' > ~/.termux/boot/play.sh 2>/dev/null
 echo 'bash $HOME/twm-master/twm.sh -boot' >> ~/.termux/boot/play.sh 2>/dev/null
 chmod +x ~/.termux/boot/play.sh 2>/dev/null

 if whereis -b w3m >/dev/null 2>&1; then
   :
 else
   pkg install w3m -y
 fi

 if whereis -b coreutils >/dev/null 2>&1; then
   :
 else
   pkg install coreutils ncurses-utils -y
 fi

 if [ -e "${Ls}/termux-api" ]; then
   :
 else
   pkg install termux-api -y
 fi

 if [ -e "${Ls}/procps" ]; then
   :
 else
   pkg install procps ncurses-utils -y
 fi

fi

# cygwin
if uname|grep -q -i "cygwin"; then
 LS="/usr/share/doc"

 if [ -e /bin/apt-cyg ]; then
   :
 else
   # cygwin repository
   curl -H "$Uagt" -s -L -O "http://raw.githubusercontent.com/sharesourcecode/apt-cyg/master/apt-cyg" &>/dev/null
   install apt-cyg /bin
 fi

 if [ -e "${Ls}/w3m" ]; then
   :
 else
   apt-cyg install w3m -y &>/dev/null
 fi

 if [ -e "${Ls}/ncurses-term" ]; then
   :
 else
   apt-cyg install ncurses-term -y &>/dev/null
 fi

 if [ "${Ls}/coreutils" ]; then
   :
 else
   apt-cyg install coreutils -y &>/dev/null
 fi

 if [ "${Ls}/procps" ]; then
   :
 else
   apt-cyg install procps -y &>/dev/null
 fi

fi

# ish Iphone
AppIsh=$(uname -a|grep -o "\-ish")

if [ "$SHELL" = "/bin/ash" ] && [ "$AppIsh" = '-ish' ]; then
 LS='/usr/share/doc'
 printf "${BlackCyan}$(G_T "Install the necessary packages for Alpine on app ISh(Iphone)"):${ColorReset}\n apk update\n apk add curl ; apk add w3m ; apk add coreutils ; apk add --no-cache tzdata\n\n"
 sleep 5s

# UserLAnd Terminal
elif [ "$SHELL" != "/bin/ash" ] && [ "$AppIsh" != '-ish' ] && uname -m|grep -q -E '(aarch64|armhf|armv7|mips64)' && [ ! -d /data/data/com.termux/files/usr/share/doc ]; then
 LS='/usr/share/doc'
 printf "${BlackCyan}$(G_T "Install the necessary packages for Alpine on app UserLAnd(Android)"):${ColorReset}\n apk update\n sudo apk add curl ; sudo apk add w3m ; sudo apk add coreutils ; sudo apk add --no-cache tzdata\n\n"
 sleep 1s

# Other unix
elif [ "$SHELL" != "/bin/ash" ] && [ "$AppIsh" != '-ish' ] && uname -m|grep -q -E "(ppc64le|riscv64|s390x|x86|x86_64)" && [ ! -d /data/data/com.termux/files/usr/share/doc ]; then
 LS='/usr/share/doc'
 printf "${BlackCyan}$(G_T "Install required packages for"); Linux, Windows WSL:${ColorReset}\n sudo apt update\n sudo apt install curl coreutils ncurses-term procps w3m -y\n"
 sleep 5s
fi

unset LS
printf "${BlackCyan}\n ⌛ $(G_T "Wait downloading scripts")...${ColorReset}\n"

rcconf() {

 if [ ! -e "$HOME/$Config" ]; then
   > $HOME/$Config
 elif [ ! -e "$HOME/loadrcfile.sh" ]; then
   > $HOME/loadrcfile.sh
 fi

 sed -i '/alias twmu/d' $HOME/$Config

 echo "alias twmu=_$HOME/$TwmDir/play.sh_"|sed 's#_#"#g' >> $HOME/$Config #"

 echo "$Shebang" > $HOME/loadrcfile.sh
 echo "$ShellCommand _source $HOME/${Config}_"|sed 's#_#`#g' >> $HOME/loadrcfile.sh #`

 chmod +x $HOME/loadrcfile.sh

 (
   sleep 3 && kill -15 $$ > /dev/null 2>&1
 ) </dev/null &>/dev/null &

 $ShellCommand $HOME/loadrcfile.sh
 rm $HOME/loadrcfile.sh
}

sync_func() {
 cd $HOME
 curl -L -O "https://github.com/sharesourcecode/twm/archive/refs/heads/master.tar.gz" -H "$Uagt"
 tar -xvzf master.tar.gz > /dev/null 2>&1
# sha256sum master.tar.gz >$HOME/$TwmDir/sha256sum
 rm master.tar.gz > /dev/null 2>&1

# DOS to Unix
 find $HOME/$TwmDir -type f -name '*.sh' -print0|xargs -0 sed -i 's/\r$//' 2>/dev/null
 chmod +x $HOME/$TwmDir/*.sh &>/dev/null

 if [ -L $HOME/twmu ]; then
   unlink $HOME/twmu
   rm -rf $HOME/twmu
 fi

 ln -s $HOME/$TwmDir/play.sh $HOME/twmu

 if ( case $PREFIX in *termux*) exit 0 ;; esac ) || [ ! -e "$HOME/.shrc" ] && command -v bash > /dev/null 2>&1; then
   ShellCommand='bash'
   Shebang='#!/bin/bash'
   Config='.bashrc'
   sed -i '1s,#!/bin/sh,#!/bin/bash,' $HOME/$TwmDir/{play.sh,twm.sh} > /dev/null 2>&1
 else
   sed -i '1s,#!/bin/bash,#!/bin/sh,' $HOME/$TwmDir/{play.sh,twm.sh} > /dev/null 2>&1

   if [ ! -e "$HOME/.shrc" ] && command -v zsh > /dev/null 2>&1; then
     ShellCommand='zsh'
     Shebang='#!/bin/zsh'
     Config='.zshrc'
   elif [ ! -e "$HOME/.shrc" ] && command -v ksh > /dev/null 2>&1; then
     ShellCommand='ksh'
     Shebang='#!/bin/ksh'
     Config='.kshrc'
   elif [ ! -e "$HOME/.shrc" ] && command -v csh > /dev/null 2>&1; then
     ShellCommand='csh '
     Shebang='#!/bin/csh'
     Config='.cshrc'
   else
     ShellCommand='sh'
     Shebang='#!/bin/sh'
     Config='.shrc'
   fi

 fi

 unset Server Content
}

sync_func

printf "✅ ${BlackCyan}$(G_T "Updated scripts")!${ColorReset}\n\n ${GoldBlack}[$(G_T "Simbolic links")]${ColorReset}\n $(G_T "To execute run command"): ${GoldBlack}./twmu${ColorReset}\n       $(G_T "For coliseum run"): ${GoldBlack}./twmu -cl${ColorReset}\n           $(G_T "For cave run"): ${GoldBlack}./twmu -cv${ColorReset}\n\n ${GoldBlack}[$(G_T "Aliases")]${ColorReset}\n $(G_T "To execute run command"): ${GoldBlack}twmu${ColorReset}\n       $(G_T "For coliseum run"): ${GoldBlack}twmu -cl${ColorReset}\n           $(G_T "For cave run"): ${GoldBlack}twmu -cv${ColorReset}\n $(G_T "You may need to restart your terminal, if that doesn't work use symbolic link")\n"

TiPidF=$(ps ax -o pid=,args=|grep "sh.*titanswarmacro/play.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')

until [ -z $TiPidF ]; do
 kill -9 $TiPidF 2>/dev/null
 TiPidF=$(ps ax -o pid=,args=|grep "sh.*titanswarmacro/play.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
 sleep 1s
done

TiPidF=$(ps ax -o pid=,args=|grep "sh.*titanswarmacro/twm.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')

until [ -z $TiPidF ]; do
 kill -9 $TiPidF 2>/dev/null
 TiPidF=$(ps ax -o pid=,args=|grep "sh.*titanswarmacro/twm.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
 sleep 1s
done

# Update local easyinstall.sh
cat "$HOME/$TwmDir/easyinstall.sh" > $HOME/easyinstall.sh
rcconf
