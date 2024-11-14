#!/bin/sh
# $HOME/easyinstall.sh
# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

# Create fold titanswarmacro if does not exist
twm_dir="twm-master"
mkdir -p $HOME/$twm_dir

# Access dir
cd $HOME/$twm_dir

#SERVER="https://codeberg.org/ueliton/TitansWarMacro/raw/branch/master/"
SERVER="https://raw.githubusercontent.com/sharesourcecode/twm/refs/heads/master/"

UAGT='Mozilla/5.0 (SymbianOS/9.4; Series60/5.0 NokiaN97-1/20.0.019; Profile/MIDP-2.1 Configuration/CLDC-1.1) AppleWebKit/525 (KHTML, like Gecko) BrowserNG/7.1.18124'

# Remote LANGUAGE.po
content=$(curl -H "$UAGT" -s -L "$SERVER/LANGUAGE.po")

G_T() {
 if [ -z "$LANGUAGE" ]; then
  local LANGUAGE='2'
 fi

 local TRANSLATE=$(echo "$1" | sed 's/\[/\\[/g;s/\]/\\]/g;s/:/\:/g')
 local TEXT=$(echo "$content" | sed -n '/|'"$TRANSLATE"'|/p' | awk -F'|' '{print $'$LANGUAGE'}')

 if [ -z "$TEXT" ]; then
  echo "$1"
 else
  echo "$TEXT"
 fi
}

colors() { BLACK_BLACK='\033[00;30m';BLACK_CYAN='\033[01;36m\033[01;07m';BLACK_GREEN='\033[00;32m\033[01;07m';BLACK_GRAY='\033[01;30m\033[01;07m';BLACK_PINK='\033[01;35m\033[01;07m';BLACK_RED='\033[01;31m\033[01;07m';BLACK_YELLOW='\033[00;33m\033[01;07m';CYAN_BLACK='\033[36m';CYAN_CYAN='\033[01;36m\033[08;07m';COLOR_RESET='\033[00m';GOLD_BLACK='\033[33m';GREEN_BLACK='\033[32m';PURPLEi_BLACK='\033[03;34m\033[02;03m';PURPLEis_BLACK='\033[03;34m\033[02;04m';WHITE_BLACK='\033[37m';WHITEb_BLACK='\033[01;38m\033[05;01m';};
colors

script_slogan() { colors="10 9 8 7 6 5 4 3 2 1";t="339";w="59";m="89";author="$(G_T "author"):\nueliton@disroot.org 2019 — 2024";collaborator="$(G_T "collaborator"):\n	@_hviegas";for i in $colors; do clear;t=$((t - 27));w=$((w + 1));m=$((m - 2));printf "\033[1;38;5;${t}m  ╔══╗╔╗╔══╗╔══╗╔══╗╔══╗\n  ╚╗╔╝╠╣╚╗╔╝║╔╗║║╔╗║║══╣\n  ${BLACK_BLACK}═\033[1;38;5;${t}m║║${BLACK_BLACK}═\033[1;38;5;${t}m║║${BLACK_BLACK}═\033[1;38;5;${t}m║║${BLACK_BLACK}═\033[1;38;5;${t}m║╔╗║║║║║╠══║\n  ${BLACK_BLACK}═\033[1;38;5;${t}m╚╝${BLACK_BLACK}═\033[1;38;5;${t}m╚╝${BLACK_BLACK}═\033[1;38;5;${t}m╚╝${BLACK_BLACK}═\033[1;38;5;${t}m╚╝╚╝╚╝╚╝╚══╝\033[1;38;5;${w}m\n       ╔╦═╦╗╔══╗╔══╗\n       ║║║║║║╔╗║║╚╝╣\n       ║║║║║║╔╗║║║╗║\n       ╚═╩═╝╚╝╚╝╚╝╚╝\033[1;38;5;${m}m\n  ╔═╦═╗╔══╗╔══╗╔══╗╔══╗\n  ║║║║║║╔╗║║╔═╝║╚╝╣║╔╗║\n  ║║║║║║╔╗║║╚═╗║║╗║║╚╝║\n  ╚╩═╩╝╚╝╚╝╚══╝╚╝╚╝╚══╝\n  ${COLOR_RESET}\n\n\033[1;38;5;${i}m${author}\n\033[02m${collaborator}\n${COLOR_RESET}\n";sleep "0.2";done;};
script_slogan

cd ~/
printf "${BLACK_CYAN} $(G_T "Installing TWM(Developed by Ueliton)")...\n⌛ $(G_T "Please wait")...⌛${COLOR_RESET}\n"

# Termux
if [ -d /data/data/com.termux/files/usr/share/doc ]; then
 termux-wake-lock
# Termux DNS
 [ ! -z $PREFIX ] && printf "nameserver 1.1.1.1\nnameserver 1.0.0.1" >$PREFIX/etc/resolv.conf 2> /dev/null
 LS="/data/data/com.termux/files/usr/share/doc"
 rm -rf ~/.termux/boot/play.sh 2>/dev/null
 mkdir -p ~/.termux/boot
 echo "IyEvZGF0YS9kYXRhL2NvbS50ZXJtdXgvZmlsZXMvdXNyL2Jpbi9zaApiYXNoICRIT01FL3R3bS90d20uc2ggLWJvb3QK"|base64 -d >~/.termux/boot/play.sh 2>/dev/null
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

 if [ -e "${LS}/termux-api" ]; then
  :
 else
  pkg install termux-api -y
 fi

 if [ -e "${LS}/procps" ]; then
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
  curl -H "$UAGH" -s -L -O "http://raw.githubusercontent.com/sharesourcecode/apt-cyg/master/apt-cyg" &>/dev/null
  install apt-cyg /bin
 fi

 if [ -e "${LS}/w3m" ]; then
  :
 else
  apt-cyg install w3m -y &>/dev/null
 fi

 if [ -e "${LS}/ncurses-term" ]; then
  :
 else
  apt-cyg install ncurses-term -y &>/dev/null
 fi

 if [ "${LS}/coreutils" ]; then
  :
 else
  apt-cyg install coreutils -y &>/dev/null
 fi

 if [ "${LS}/procps" ]; then
  :
 else
  apt-cyg install procps -y &>/dev/null
 fi
fi

# ish Iphone
APPISH=$(uname -a|grep -o "\-ish")

if [ "$SHELL" = "/bin/ash" ] && [ "$APPISH" = '-ish' ]; then
 LS='/usr/share/doc'
 printf "${BLACK_CYAN}$(G_T "Install the necessary packages for Alpine on app ISh(Iphone)"):${COLOR_RESET}\n apk update\n apk add curl ; apk add w3m ; apk add coreutils ; apk add --no-cache tzdata\n\n"
 sleep 5s
# UserLAnd Terminal
elif [ "$SHELL" != "/bin/ash" ] && [ "$APPISH" != '-ish' ] && uname -m|grep -q -E '(aarch64|armhf|armv7|mips64)' && [ ! -d /data/data/com.termux/files/usr/share/doc ]; then
 LS='/usr/share/doc'
 printf "${BLACK_CYAN}$(G_T "Install the necessary packages for Alpine on app UserLAnd(Android)"):${COLOR_RESET}\n apk update\n sudo apk add curl ; sudo apk add w3m ; sudo apk add coreutils ; sudo apk add --no-cache tzdata\n\n"
 sleep 1s
# Other unix
elif [ "$SHELL" != "/bin/ash" ] && [ "$APPISH" != '-ish' ] && uname -m|grep -q -E "(ppc64le|riscv64|s390x|x86|x86_64)" && [ ! -d /data/data/com.termux/files/usr/share/doc ]; then
 LS='/usr/share/doc'
 printf "${BLACK_CYAN}$(G_T "Install required packages for"); Linux, Windows WSL:${COLOR_RESET}\n sudo apt update\n sudo apt install curl coreutils ncurses-term procps w3m -y\n"
 sleep 5s
fi

unset LS
#script_slogan
printf "${BLACK_CYAN}\n ⌛ $(G_T "Wait downloading scripts")...${COLOR_RESET}\n"

sync_func () {
 cd $HOME
 curl -L -O "https://github.com/sharesourcecode/twm/archive/refs/heads/master.tar.gz" -H "$UAGT"
#"https://codeberg.org/ueliton/TitansWarMacro/archive/master.tar.gz"
 tar -xvzf master.tar.gz || exit 1
 sha256sum master.tar.gz >$HOME/$twm_dir/sha256sum
 rm master.tar.gz

# DOS to Unix
 find $HOME/$twm_dir -type f -name '*.sh' -print0|xargs -0 sed -i 's/\r$//' 2>/dev/null
 chmod +x $HOME/$twm_dir/*.sh &>/dev/null

 if [ -L $HOME/twmu ]; then
  unlink $HOME/twmu
  rm -rf $HOME/twmu
 fi

 ln -s $HOME/$twm_dir/play.sh $HOME/twmu

# Lista de arquivos para verificar
 configs=".shrc .zshrc .bashrc .bash_profile .profile .norcfortwmu"

# Loop para verificar a existência de cada arquivo
 cforce=0

 for CONFIG in $configs; do

  if [ -e "$HOME/$CONFIG" ]; then

   if grep -q 'alias twmu' $CONFIG; then
    sed -i '/alias twmu/d' $HOME/$CONFIG
    alias=1
   fi

   echo "alias twmu=\"$HOME/$twm_dir/play.sh\"" >> $HOME/$CONFIG

  else

   cforce=$((cforce + 1))

   if [ "$cforce" -gt '5' ]; then
    sed -i '/alias twmu/d' $HOME/.bashrc
    echo "alias twmu=\"$HOME/$twm_dir/play.sh\"" >> $HOME/.bashrc
# Não há um arquivo rc definido
    norc=1
    break
   fi

  fi

 done

 unset SERVER content
}
sync_func

APPISH=$(uname -a|grep -o "\-ish")

if [ "$SHELL" = "/bin/ash" ] && [ "$APPISH" = '-ish' ]; then
 sed -i 's,#!/bin/bash,#!/bin/sh,g' $HOME/$twm_dir/*.sh
fi

#script_slogan

if [ -z "$alias" ] || [ "$cforce" -gt '5' ]; then
 printf "✅ ${BLACK_CYAN}$(G_T "Updated scripts")!${COLOR_RESET}\n $(G_T "To execute run command"): ${GOLD_BLACK}./twmu${COLOR_RESET}\n       $(G_T "For coliseum run"): ${GOLD_BLACK}./twmu -cl${COLOR_RESET}\n           $(G_T "For cave run"): ${GOLD_BLACK}./twmu -cv${COLOR_RESET}\n"
else
 printf "✅ ${BLACK_CYAN}$(G_T "Updated scripts")!${COLOR_RESET}\n $(G_T "To execute run command"): ${GOLD_BLACK}twmu${COLOR_RESET}\n       $(G_T "For coliseum run"): ${GOLD_BLACK}twmu -cl${COLOR_RESET}\n           $(G_T "For cave run"): ${GOLD_BLACK}twmu -cv${COLOR_RESET}\n $(G_T "You may need to restart your terminal, if that doesn't work use this symbolic link"):\n $(G_T "To execute run command"): ${GOLD_BLACK}./twmu${COLOR_RESET}\n       $(G_T "For coliseum run"): ${GOLD_BLACK}./twmu -cl${COLOR_RESET}\n           $(G_T "For cave run"): ${GOLD_BLACK}./twmu -cv${COLOR_RESET}\n"
fi

# Update local easyinstall.sh
cat $HOME/$twm_dir/easyinstall.sh > $HOME/easyinstall.sh

tipidf=$(ps ax -o pid=,args=|grep "sh.*titanswarmacro/play.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
until [ -z $tipidf ]; do
 kill -9 $tipidf 2>/dev/null
 tipidf=$(ps ax -o pid=,args=|grep "sh.*titanswarmacro/play.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
 sleep 1s
done

tipidf=$(ps ax -o pid=,args=|grep "sh.*titanswarmacro/twm.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
until [ -z $tipidf ]; do
 kill -9 $tipidf 2>/dev/null
 tipidf=$(ps ax -o pid=,args=|grep "sh.*titanswarmacro/twm.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
 sleep 1s
done

if [ -f $HOME/$twm_dir/runmode_file ]; then

 if awk -v arg="-cl" -v file="$(cat $HOME/$twm_dir/runmode_file)" 'BEGIN { exit !(arg == file) }'; then
  printf "${BLACK_GREEN}$(G_T "Automatically restarting in 5s after update")...${COLOR_RESET}\n"
  sleep 5s
  $HOME/$twm_dir/play.sh -cl
 elif awk -v arg="-cv" -v file="$(cat $HOME/$twm_dir/runmode_file)" 'BEGIN { exit !(arg == file) }'; then
  printf "${BLACK_GREEN}$(G_T "Automatically restarting in 5s after update")...${COLOR_RESET}\n"
  sleep 5s
  $HOME/$twm_dir/play.sh -cv
 else
  printf "${BLACK_GREEN}$(G_T "Automatically restarting in 5s after update")...${COLOR_RESET}\n"
  sleep 5s
  $HOME/$twm_dir/play.sh -boot
 fi

fi
