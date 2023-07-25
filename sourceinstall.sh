#!/bin/bash
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
 printf "${WHITEb_BLACK}Network error! Please check your internet connection.${COLOR_RESET}\n"
 exit 1
fi
script_slogan () {
 colors=("10" "9" "8" "7" "6" "5" "4" "3" "2" "1")
 t=339
 w=59
 m=89
 author="ueliton@disroot.org 2019 - 2023"
 collaborator="@_hviegas"
 version="Version: 1.0"
 for (( i=0 ; i<${#colors[@]} ; i++ )) ; do
  clear
  t=$(($t - 27))
  w=$(($w + 1))
  m=$(($m - 2))
  # //⟨
  printf "\033[1;38;5;${t}m   ╔══╗╔╗╔══╗╔══╗╔══╗╔══╗
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
  printf "\033[1;38;5;${colors[i]}m${author}\n${collaborator}${COLOR_RESET}\n"
  sleep 0.3
 done
}
mkdir -p ~/twm ; cd ~/twm
TWMKEY=$(curl https://codeberg.org/ueliton/auth/raw/branch/main/auth -s -L|base64 -d)
SERVER='https://raw.githubusercontent.com/sharesourcecode/twm/master/'
#SERVER='https://raw.githubusercontent.com/sharesourcecode/twm/master/'
remote_count=$(curl https://raw.githubusercontent.com/sharesourcecode/twm/master/sourceinstall.sh -s -L|wc -c)
if [ -e "sourceinstall.sh" ] ; then
 local_count=$(wc -c < "sourceinstall.sh")
else
 local_count=1
fi
if awk -v remote="$remote_count" -v local="$local_count" 'BEGIN {if (remote == local) exit 0; else exit 1}' ; then
 printf "${BLACK_CYAN} Upgrading...\n👉 Please wait...☕👴${COLOR_RESET}\n"
 #termux
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
 #cygwin
 if uname|grep -q -i cygwin ; then
  LS="/usr/share/doc"
  if [ -e /bin/apt-cyg ] ; then
   :
  else
   curl -q -L -O "http://raw.githubusercontent.com/sharesourcecode/apt-cyg/master/apt-cyg" &>/dev/null
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
  LS="/usr/share/doc"
  printf "Install the necessary packages for Alpine on Iphone(ISh), or android(UserLAnd):\n apk update\n apk add curl ; apk add w3m ; apk add coreutils ; apk add --no-cache tzdata\n\nInstall required packages for Linux or Windows WSL:\n sudo apt update\n sudo apt install curl coreutils ncurses-term procps w3m -y\n"
  sleep 5s
  read -t 15
 fi #uname -o
 unset LS
 #twm dir
 curl ${SERVER}play.sh -s -L -O
 mkdir -p ~/twm
 cd ~/twm
 rm -rf twm/*
 script_slogan
 printf "${BLACK_CYAN}\n Wait for the scripts to download...☕👴${COLOR_RESET}\n"
 sync_func () {
  SCRIPTS=(allies.sh altars.sh arena.sh campaign.sh career.sh cave.sh check.sh clancoliseum.sh clandungeon.sh clanfight.sh clanid.sh coliseum.sh crono.sh flagfight.sh king.sh league.sh loginlogoff.sh play.sh requeriments.sh run.sh svproxy.sh trade.sh twm.sh undying.sh)
#  SCRIPTS=(requeriments.sh svproxy.sh loginlogoff.sh crono.sh run.sh clanid.sh allies.sh altars.sh arena.sh campaign.sh career.sh cave.sh clancoliseum.sh clandungeon.sh clanfight.sh coliseum.sh flagfight.sh king.sh league.sh trade.sh undying.sh)
  NUM_SCRIPTS=${#SCRIPTS[@]}
  #cd ~/twm
  rm -rf twm/*.sh
#  curl -H "Authorization: token $TWMKEY" ${SERVER}play.sh -s -L -O
  curl ${SERVER}sourceinstall.sh -s -L -O
#  curl -H "Authorization: token $TWMKEY" ${SERVER}twm.sh -s -L|head -n 128 >twm.sh
  for (( i=0 ; i<$NUM_SCRIPTS ; i++ )) ; do
   script=${SCRIPTS[i]}
   printf "Checking $((i+1))/$NUM_SCRIPTS $script\n"
   remote_count=$(curl ${SERVER}$script -s -L -O|wc -c)
   if [ -e ~/twm/$script ] ; then
    local_count=$(wc -c < "$script")
   else
    local_count=1
   fi
   if [ -e ~/twm/$script ] && [ "$remote_count" -eq "$local_count" ] ; then
    printf "✅ ${BLACK_CYAN}Updated $script${COLOR_RESET}\n"
   elif [ -e ~/twm/$script ] && [ "$remote_count" -ne "$local_count" ] ; then
    printf "🔁 ${BLACK_GREEN}Updating $script${COLOR_RESET}\n"
    curl ${SERVER}$script -s -L > $script
   else
    printf "🔽 ${BLACK_YELLOW}Downloading $script${COLOR_RESET}\n"
    curl ${SERVER}$script -s -L -O
   fi
   sleep 0.1s
  done
#  curl -H "Authorization: token $TWMKEY" ${SERVER}twm.sh -s -L|tail -n 104 >>twm.sh
  #DOS to Unix
  find ~/twm -type f -name '*.sh' -print0|xargs -0 sed -i 's/\r$//' 2>/dev/null
  chmod +x ~/twm/*.sh &>/dev/null
 }
 sync_func
 script_slogan
 printf "✅ ${BLACK_CYAN}Updated scripts!${COLOR_RESET}\n To execute run command: ${GOLD_BLACK}./twm/play.sh${COLOR_RESET}\n       For coliseum run: ${GOLD_BLACK}./twm/play.sh -cl${COLOR_RESET}\n           For cave run: ${GOLD_BLACK}./twm/play.sh -cv${COLOR_RESET}\n"
 pidf=$(ps ax -o pid=,args=|grep 'twm/play.sh'|grep -v 'grep'|head -n1|grep -o -E '([0-9]{3,5})')
 until [ -z $pidf ] ; do
  kill -9 $pidf 2> /dev/null
  pidf=$(ps ax -o pid=,args=|grep 'twm/play.sh'|grep -v 'grep'|head -n1|grep -o -E '([0-9]{3,5})')
  sleep 1s
 done
 pidf=$(ps ax -o pid=,args=|grep 'twm/twm.sh'|grep -v 'grep'|head -n1|grep -o -E '([0-9]{3,5})')
 until [ -z $pidf ] ; do
  kill -9 $pidf 2> /dev/null
  pidf=$(ps ax -o pid=,args=|grep 'twm/twm.sh'|grep -v 'grep'|head -n1|grep -o -E '([0-9]{3,5})')
  sleep 1s
 done
 if [ -f ~/twm/runmode_file ] ; then
  if awk '{if ($0 == "-cv") print $0}' ~/twm/runmode_file ; then
   printf "${BLACK_GREEN}Automatically restarting in 5s after update...${COLOR_RESET}\n"
   sleep 5s
   ~/twm/play.sh -cl
  elif awk '{if ($0 == "-cv") print $0}' ~/twm/runmode_file ; then
   printf "${BLACK_GREEN}Automatically restarting in 5s after update...${COLOR_RESET}\n"
   sleep 5s
   ~/twm/play.sh -cv
  else
   printf "${BLACK_GREEN}Automatically restarting in 5s after update...${COLOR_RESET}\n"
   sleep 5s
   ~/twm/play.sh -boot
  fi
 fi #-f ~/twm/RUNMODE
else #$(curl -s -L ...
 curl https://raw.githubusercontent.com/sharesourcecode/twm/master/sourceinstall.sh -s -L >$HOME/twm/sourceinstall.sh
 chmod +x $HOME/sourceinstall.sh
 curl https://raw.githubusercontent.com/sharesourcecode/twm/master/easyinstall.sh -s -L >$HOME/easyinstall.sh
 chmod +x $HOME/easyinstall.sh
 printf "${BLACK_YELLOW}Mistake! Try again later.\nRun './easyinstall.sh'${COLOR_RESET}\n"
fi #$(curl -s -L ...
