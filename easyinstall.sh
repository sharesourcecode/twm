#!/bin/sh
REPO=$1
: '
This script merges most of the functions in the twm.sh script with the exception of play.sh and sourceinstall.sh
The Bash shebang is also converted to Bourn Shell(#!/bin/bash > #!/bin/sh).
' 
#/Colors - font(formatting)_background
BLACK_BLACK='\033[00;30m'
BLACK_CYAN='\033[01;36m\033[01;07m'
BLACK_GREEN='\033[00;32m\033[01;07m'
BLACK_GRAY='\033[01;30m\033[01;07m'
BLACK_PINK='\033[01;35m\033[01;07m'
BLACK_RED='\033[01;31m\033[01;07m'
BLACK_YELLOW='\033[00;33m\033[01;07m'
CYAN_BLACK='\033[36m'
CYAN_CYAN='\033[01;36m\033[08;07m'
COLOR_RESET='\033[00m'
GOLD_BLACK='\033[33m'
GREEN_BLACK='\033[32m'
PURPLEi_BLACK='\033[03;34m\033[02;03m'
PURPLEis_BLACK='\033[03;34m\033[02;04m'
WHITE_BLACK='\033[37m'
WHITEb_BLACK='\033[01;38m\033[05;01m'
if ! curl -s --head --request GET titanswar.net|grep "200 OK" > /dev/null ; then
 printf "${BLACK_RED}Network error! Please check your internet connection.${COLOR_RESET}\n"
 exit 1
fi
script_slogan () {
 colors="10 9 8 7 6 5 4 3 2 1"
 t=339
 w=59
 m=89
 author="ueliton@disroot.org 2019 - 2023"
 collaborator="@_hviegas"
 for i in $colors ; do
  clear
  t=$((t - 27))
  w=$((w + 1))
  m=$((m - 2))
  # //⟨
  printf "\033[1;38;5;${t}m  ╔══╗╔╗╔══╗╔══╗╔══╗╔══╗
  ╚╗╔╝╠╣╚╗╔╝║╔╗║║╔╗║║══╣
  ${BLACK_BLACK}═\033[1;38;5;${t}m║║${BLACK_BLACK}═\033[1;38;5;${t}m║║${BLACK_BLACK}═\033[1;38;5;${t}m║║${BLACK_BLACK}═\033[1;38;5;${t}m║╔╗║║║║║╠══║
  ${BLACK_BLACK}═\033[1;38;5;${t}m╚╝${BLACK_BLACK}═\033[1;38;5;${t}m╚╝${BLACK_BLACK}═\033[1;38;5;${t}m╚╝${BLACK_BLACK}═\033[1;38;5;${t}m╚╝╚╝╚╝╚╝╚══╝\033[1;38;5;${w}m
       ╔╦═╦╗╔══╗╔══╗
       ║║║║║║╔╗║║╚╝╣
       ║║║║║║╔╗║║║╗║
       ╚═╩═╝╚╝╚╝╚╝╚╝\033[1;38;5;${m}m
  ╔═╦═╗╔══╗╔══╗╔══╗╔══╗
  ║║║║║║╔╗║║╔═╝║╚╝╣║╔╗║
  ║║║║║║╔╗║║╚═╗║║╗║║╚╝║
  ╚╩═╩╝╚╝╚╝╚══╝╚╝╚╝╚══╝
  ${COLOR_RESET}\n"
  # ⟩\\
  printf "\033[1;38;5;${i}m${author}\n${collaborator}\n${version}${COLOR_RESET}\n"
  sleep 0.3s
 done
}
cd ~/
if echo "$REPO"|grep -q -E '[-]test' ; then
 #/test repository
 SERVER='https://raw.githubusercontent.com/sharesourcecode/twm/master/'
 remote_count=$(curl ${SERVER}easyinstall.sh -s -L|wc -c)
else
 #/final repository
 TWMKEY=$(curl https://codeberg.org/ueliton/auth/raw/branch/main/auth -s -L|base64 -d)
 SERVER='https://gitea.com/api/v1/repos/Ueliton/twm/raw/master/'
 remote_count=$(curl -H "Authorization: token $TWMKEY" ${SERVER}easyinstall.sh -s -L|wc -c)
fi
if [ -e "easyinstall.sh" ] ; then
 local_count=$(wc -c < "easyinstall.sh")
else
 local_count=1
fi
if awk -v remote="$remote_count" -v local="$local_count" 'BEGIN {if (remote == local) exit 0; else exit 1}' ; then
 #/termux
 if [ -d /data/data/com.termux/files/usr/share/doc ] ; then
  termux-wake-lock
  sed -u -i '/nameserver/d' $PREFIX/etc/resolv.conf &>/dev/null
  printf "nameserver 94.140.14.15\nnameserver 94.140.15.16" >$PREFIX/etc/resolv.conf
  LS="/data/data/com.termux/files/usr/share/doc"
  rm -rf ~/.termux/boot/play.sh 2> /dev/null
  mkdir -p ~/.termux/boot
  echo "IyEvZGF0YS9kYXRhL2NvbS50ZXJtdXgvZmlsZXMvdXNyL2Jpbi9zaApiYXNoICRIT01FL3R3bS90d20uc2ggLWJvb3QK"|base64 -d >~/.termux/boot/play.sh 2> /dev/null
  chmod +x ~/.termux/boot/play.sh 2> /dev/null
  if whereis w3m &>/dev/null ; then
   :
  else
   pkg install w3m -y
  fi
  if whereis coreutils &>/dev/null ; then
   :
  else
   pkg install coreutils ncurses-utils -y
  fi
  if [ -e "${LS}/termux-api" ] ; then
   :
  else
   pkg install termux-api -y
  fi
  if [ -e "${LS}/procps" ] ; then
   :
  else
   pkg install procps ncurses-utils -y
  fi
 fi #ls /data/...
 #/cygwin
 if uname|grep -q -i cygwin ; then
  LS="/usr/share/doc"
  if [ -e /bin/apt-cyg ] ; then
   :
  else
   #/cygwin repository
   curl -s -L -O "http://raw.githubusercontent.com/sharesourcecode/apt-cyg/master/apt-cyg" &>/dev/null
   install apt-cyg /bin
  fi #ls /bin
  if [ -e "${LS}/w3m" ] ; then
   :
  else
   apt-cyg install w3m -y &>/dev/null
  fi
  if [ -e "${LS}/ncurses-term" ] ; then
   :
  else
   apt-cyg install ncurses-term -y &>/dev/null
  fi
  if [ "${LS}/coreutils" ] ; then
   :
  else
   apt-cyg install coreutils -y &>/dev/null
  fi
  if [ "${LS}/procps" ] ; then
   :
  else
   apt-cyg install procps -y &>/dev/null
  fi
 fi #cygwin
 #linux
 if uname -o|grep -q -i GNU/Linux ; then
  LS='/usr/share/doc'
  printf "Install the necessary packages for Alpine on Iphone(ISh), or android(UserLAnd):\n apk update\n apk add curl ; apk add w3m ; apk add coreutils ; apk add --no-cache tzdata\n\nInstall required packages for Linux or Windows WSL:\n sudo apt update\n sudo apt install curl coreutils ncurses-term procps w3m -y\n"
  sleep 5s
  read -t 15
 fi #uname -o
 unset LS
 #twm dir
 mkdir -p ~/twm
 cd ~/twm
 rm -rf $HOME/twm/*
 script_slogan
 printf "${BLACK_CYAN}\n Wait for the scripts to download...☕👴${COLOR_RESET}\n"
 sync_func () {
  SCRIPTS="requeriments.sh svproxy.sh loginlogoff.sh crono.sh run.sh clanid.sh allies.sh altars.sh arena.sh campaign.sh career.sh cave.sh clancoliseum.sh clandungeon.sh clanfight.sh coliseum.sh flagfight.sh king.sh league.sh trade.sh undying.sh"
  cd ~/twm
  if echo "$REPO"|grep -q -E '[-]test' ; then
   #/test repository
   curl ${SERVER}play.sh -s -L -O
   curl ${SERVER}sourceinstall.sh -s -L -O
   curl ${SERVER}twm.sh -s -L|sed -n '1,124p' >twm.sh
  else
   #/final repository
   curl -H "Authorization: token $TWMKEY" ${SERVER}play.sh -s -L -O
   curl -H "Authorization: token $TWMKEY" ${SERVER}sourceinstall.sh -s -L -O
   curl -H "Authorization: token $TWMKEY" ${SERVER}twm.sh -s -L|sed -n '1,124p' >twm.sh
  fi
  NUM_SCRIPTS=$(echo $SCRIPTS|wc -w)
  LEN=0
  for script in $SCRIPTS ; do
   LEN=$((LEN+1))
   printf "Checking $LEN/$NUM_SCRIPTS $script\n"
   printf "🔁 ${BLACK_GREEN}Updating $script${COLOR_RESET}\n"
   if echo "$REPO"|grep -q -E '[-]test' ; then
    #/test repository
    curl ${SERVER}$script -s -L >>twm.sh
   else
    #/final repository
    curl -H "Authorization: token $TWMKEY" ${SERVER}$script -s -L >>twm.sh
   fi
    printf "\n#\n" >>twm.sh
   sleep 0.1s
  done
  if echo "$REPO"|grep -q -E '[-]test' ; then
   #/test repository
   curl ${SERVER}twm.sh -s -L|sed -n '131,194p' >>twm.sh
  else
   #/final repository
   curl -H "Authorization: token $TWMKEY" ${SERVER}twm.sh -s -L|sed -n '131,194p' >>twm.sh
  fi
  case $(uname -o) in
  (Android)
   :
   ;;
  (*)
   sed -i 's,#!/bin/bash,#!/bin/sh,g' $HOME/twm/twm.sh
   ;;
  esac
  #DOS to Unix
  find ~/twm -type f -name '*.sh' -print0|xargs -0 sed -i 's/\r$//' 2>/dev/null
  chmod +x ~/twm/*.sh &>/dev/null
 }
 sync_func
 script_slogan
 printf "✅ ${BLACK_CYAN}Updated scripts!${COLOR_RESET}\n To execute run command: ${GOLD_BLACK}./twm/play.sh${COLOR_RESET}\n       For coliseum run: ${GOLD_BLACK}./twm/play.sh -cl${COLOR_RESET}\n           For cave run: ${GOLD_BLACK}./twm/play.sh -cv${COLOR_RESET}\n"
 pidf=$(ps ax -o pid=,args=|grep "sh.*twm/play.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
 until [ -z $pidf ] ; do
  kill -9 $pidf 2> /dev/null
  pidf=$(ps ax -o pid=,args=|grep "sh.*twm/play.sh"|grep -v 'grep'|head -n1|grep -o -E '([0-9]{3,5})')
  sleep 1s
 done
 pidf=$(ps ax -o pid=,args=|grep "sh.*twm/twm.sh"|grep -v 'grep'|head -n1|grep -o -E '([0-9]{3,5})')
 until [ -z $pidf ] ; do
  kill -9 $pidf 2> /dev/null
  pidf=$(ps ax -o pid=,args=|grep "sh.*twm/twm.sh"|grep -v 'grep'|head -n1|grep -o -E '([0-9]{3,5})')
  sleep 1s
 done
 if [ -f ~/twm/runmode_file ] ; then
  RUN=$(cat $HOME/twm/runmode_file)
  if echo "$RUN"|grep -q -E '[-]cl' ; then
   printf " ${BLACK_GREEN}Automatically restarting in 5s after update...${COLOR_RESET}\n"
   sleep 5s
   ~/twm/play.sh -cl
  elif echo "$RUN"|grep -q -E '[-]cv' ; then
   printf " ${BLACK_GREEN}Automatically restarting in 5s after update...${COLOR_RESET}\n"
   sleep 5s
   ~/twm/play.sh -cv
  elif echo "$RUN"|grep -q -E '[-]boot' ; then
   printf " ${BLACK_GREEN}Automatically restarting in 5s after update...${COLOR_RESET}\n"
   sleep 5s
   ~/twm/play.sh -boot
  else
   printf " ${BLACK_GREEN}Automatically restarting in 5s after update...${COLOR_RESET}\n"
   sleep 5s
   ~/twm/play.sh -boot
  fi
 fi #-f ~/twm/RUNMODE
else #$(curl -s -L ...
 cd ~/
 if echo "$REPO"|grep -q -E '[-]test' ; then
  #/test repository
  curl ${SERVER}easyinstall.sh -s -L -O
 else
  #/final repository
  curl https://codeberg.org/ueliton/auth/raw/branch/main/easyinstall.sh -s -L -O
 fi
 chmod +x easyinstall.sh
 printf "${BLACK_YELLOW}Mistake! Try again later.\nRun:${COLOR_RESET} ${GOLD_BLACK}./easyinstall.sh${COLOR_RESET}\n"
fi #$(curl -s -L ...
