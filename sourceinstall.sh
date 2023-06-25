#!/bin/bash
# 15/6/2023
# automatic update turned off
# Definindo variáveis de cores
COLOR_BLUE='\e[01;36m\e[01;07m'
COLOR_BLACK='\e[0;30m'
COLOR_CYAN='\e[01;36m\e[01;07m'
COLOR_GREEN='\e[00;32m\e[01;07m'
COLOR_RED='\e[1;38;5;1m'
COLOR_RESET='\e[00m'
COLOR_YELLOW='\e[00;33m\e[01;07m'
LETTER_YELLOW='\033[33m'
if ! curl -s --head --request GET titanswar.net | grep "200 OK" > /dev/null; then
 echo -e "${COLOR_RED}Network error! Please check your internet connection.${COLOR_RESET}"
 exit 1
fi
slogan_func () {
 colors=("10" "9" "8" "7" "6" "5" "4" "3" "2" "1")
 t=339
 w=59
 m=89
 author="ueliton@disroot.org 2019 - 2023"
 for (( i=0; i<${#colors[@]}; i++ )); do
  clear
  t=$(($t - 27))
  w=$(($w + 1))
  m=$(($m - 2))
  # //⟨
  echo -e "\e[1;38;5;${t}m   ╔══╗╔╗╔══╗╔══╗╔══╗╔══╗
   ╚╗╔╝╠╣╚╗╔╝║╔╗║║╔╗║║══╣
   ${COLOR_BLACK}═\e[1;38;5;${t}m║║${COLOR_BLACK}═\e[1;38;5;${t}m║║${COLOR_BLACK}═\e[1;38;5;${t}m║║${COLOR_BLACK}═\e[1;38;5;${t}m║╔╗║║║║║╠══║
   ${COLOR_BLACK}═\e[1;38;5;${t}m╚╝${COLOR_BLACK}═\e[1;38;5;${t}m╚╝${COLOR_BLACK}═\e[1;38;5;${t}m╚╝${COLOR_BLACK}═\e[1;38;5;${t}m╚╝╚╝╚╝╚╝╚══╝\e[1;38;5;${w}m
        ╔╦═╦╗╔══╗╔══╗
        ║║║║║║╔╗║║╚╝╣
        ║║║║║║╔╗║║║╗║
        ╚═╩═╝╚╝╚╝╚╝╚╝\e[1;38;5;${m}m
    ╔═╦═╗╔══╗╔══╗╔══╗╔══╗
    ║║║║║║╔╗║║╔═╝║╚╝╣║╔╗║
    ║║║║║║╔╗║║╚═╗║║╗║║╚╝║
    ╚╩═╩╝╚╝╚╝╚══╝╚╝╚╝╚══╝
        ${COLOR_RESET}"
  # ⟩\\
  echo -e "\e[1;38;5;${colors[i]}m${author}${COLOR_RESET}"
  sleep 0.3
 done
} #slogan_func()
cd ~/twm
TWMKEY=$(curl https://codeberg.org/ueliton/auth/raw/branch/main/auth -s -L | base64 -d)
SERVER="https://api.github.com/repos/sharesourcecode/twm/contents/"
remote_count=$(curl -H "Authorization: Bearer $TWMKEY" -H "Accept: application/vnd.github.v3.raw" ${SERVER}sourceinstall.sh -s -L | wc -c)
if [ -e "sourceinstall.sh" ] ; then
 local_count=$(wc -c < "sourceinstall.sh")
else
 local_count=1
fi
if awk -v remote="$remote_count" -v local="$local_count" 'BEGIN {if (remote == local) exit 0; else exit 1}' ; then
 echo -e "${COLOR_CYAN} Upgrading...\n👉 Please wait...☕👴${COLOR_RESET}"
 #termux
 if [ -d /data/data/com.termux/files/usr/share/doc ] ; then
  termux-wake-lock
  sed -u -i '/nameserver/d' $PREFIX/etc/resolv.conf &> /dev/null
  echo -e "nameserver 1.1.1.1\nnameserver 8.8.8.8" >$PREFIX/etc/resolv.conf
  LS="/data/data/com.termux/files/usr/share/doc"
  rm -rf ~/.termux/boot/play.sh 2> /dev/null
  mkdir -p ~/.termux/boot
  echo "IyEvZGF0YS9kYXRhL2NvbS50ZXJtdXgvZmlsZXMvdXNyL2Jpbi9zaApiYXNoICRIT01FL3R3bS90d20uc2ggLWJvb3QK" | base64 -d >~/.termux/boot/play.sh 2> /dev/null
  chmod +x ~/.termux/boot/play.sh 2> /dev/null
  if which w3m &> /dev/null ; then
   :
  else
   pkg install w3m -y
  fi
  if which coreutils &> /dev/null ; then
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
 if uname | grep -q -i cygwin ; then
  LS="/usr/share/doc"
  if [ -e /bin/apt-cyg ] ; then
   :
  else
   curl -q -L -O "http://raw.githubusercontent.com/sharesourcecode/apt-cyg/master/apt-cyg" &> /dev/null
   install apt-cyg /bin
  fi #ls /bin
  if [ -e "${LS}/w3m" ] ; then
   :
  else
   apt-cyg install w3m -y &> /dev/null
  fi
  if [ -e "${LS}/ncurses-term" ] ; then
   :
  else
   apt-cyg install ncurses-term -y &> /dev/null
  fi
  if [ "${LS}/coreutils" ] ; then
   :
  else
   apt-cyg install coreutils -y &> /dev/null
  fi
  if [ "${LS}/procps" ] ; then
   :
  else
   apt-cyg install procps -y &> /dev/null
  fi
 fi #cygwin
 #linux
 if uname -o | grep -q -i GNU/Linux ; then
  LS="/usr/share/doc"
  echo -e "Install the necessary packages for Alpine on Iphone(ISh), or android(UserLAnd):\n apk update\n apk add curl w3m coreutils\napk add --no-cache tzdata\n\nInstall required packages for Linux or Windows WSL:\n sudo apt update\n sudo apt install curl coreutils ncurses-term procps w3m -y"
  sleep 5s
  read -t 15
 fi #uname -o
 unset LS
 #twm dir
 mkdir -p ~/twm
 cd ~/twm
 rm -rf twm/*
 slogan_func
 echo -e "${COLOR_CYAN}\n Wait for the scripts to download...☕👴${COLOR_RESET}"
 sync_func () {
  SCRIPTS=(allies.sh altars.sh arena.sh campaign.sh career.sh cave.sh clancoliseum.sh clandungeon.sh clanfight.sh clanid.sh coliseum.sh crono.sh flagfight.sh king.sh loginlogoff.sh play.sh requeriments.sh run.sh svproxy.sh trade.sh twm.sh undying.sh)
#  SCRIPTS=(requeriments.sh svproxy.sh loginlogoff.sh crono.sh run.sh clanid.sh allies.sh altars.sh arena.sh campaign.sh career.sh cave.sh clancoliseum.sh clandungeon.sh clanfight.sh coliseum.sh flagfight.sh king.sh trade.sh undying.sh)
  NUM_SCRIPTS=${#SCRIPTS[@]}
  cd ~/twm
#  curl -H "Authorization: Bearer $TWMKEY" -H "Accept: application/vnd.github.v3.raw" ${SERVER}play.sh -s -L -O
#  curl -H "Authorization: Bearer $TWMKEY" -H "Accept: application/vnd.github.v3.raw" ${SERVER}sourceinstall.sh -s -L -O
#  curl -H "Authorization: Bearer $TWMKEY" -H "Accept: application/vnd.github.v3.raw" ${SERVER}twm.sh -s -L | head -n 128 >twm.sh
  for (( i=0; i<$NUM_SCRIPTS; i++ )) ; do
   script=${SCRIPTS[i]}
   echo -e "Checking $((i+1))/$NUM_SCRIPTS $script"
   remote_count=$(curl -H "Authorization: Bearer $TWMKEY" -H "Accept: application/vnd.github.v3.raw" ${SERVER}$script -s -L | wc -c)
   if [ -e ~/twm/$script ] ; then
    local_count=$(wc -c < "$script")
   else
    local_count=1
   fi
   if [ -e ~/twm/$script ] && [ "$remote_count" -eq "$local_count" ] ; then
    echo -e "✅ ${COLOR_CYAN}Updated $script${COLOR_RESET}"
   elif [ -e ~/twm/$script ] && [ "$remote_count" -ne "$local_count" ] ; then
    echo -e "🔁 ${COLOR_GREEN}Updating $script${COLOR_RESET}"
    curl -H "Authorization: Bearer $TWMKEY" -H "Accept: application/vnd.github.v3.raw" ${SERVER}$script -s -L > $script
   else
    echo -e "🔽 ${COLOR_YELLOW}Downloading $script${COLOR_RESET}"
    curl -H "Authorization: Bearer $TWMKEY" -H "Accept: application/vnd.github.v3.raw" ${SERVER}$script -s -L -O
   fi
   sleep 0.1s
  done
#  curl -H "Authorization: Bearer $TWMKEY" -H "Accept: application/vnd.github.v3.raw" ${SERVER}twm.sh -s -L | tail -n 104 >>twm.sh
  #DOS to Unix
  find ~/twm -type f -name '*.sh' -print0 | xargs -0 sed -i 's/\r$//' 2>/dev/null
  chmod +x ~/twm/*.sh &>/dev/null
 }
 sync_func
 slogan_func
 echo -e "✅ ${COLOR_CYAN}Updated scripts!${COLOR_RESET}\n To execute run command: ${LETTER_YELLOW}bash twm/play.sh${COLOR_RESET}\n\ For cave run: ${LETTER_YELLOW}bash twm/play.sh -cv${COLOR_RESET}\n\ For coliseum run: ${LETTER_YELLOW}bash twm/play.sh -cl${COLOR_RESET}"
 pidf=$(ps ax -o pid=,args= | grep 'twm/play.sh' | grep -v 'grep' | head -n1 | grep -o -E '([0-9]{3,5})')
 until [ -z $pidf ] ; do
  kill -9 $pidf 2> /dev/null
  pidf=$(ps ax -o pid=,args= | grep 'twm/play.sh' | grep -v 'grep' | head -n1 | grep -o -E '([0-9]{3,5})')
  sleep 1s
 done
 pidf=$(ps ax -o pid=,args= | grep 'twm/twm.sh' | grep -v 'grep' | head -n1 | grep -o -E '([0-9]{3,5})')
 until [ -z $pidf ] ; do
  kill -9 $pidf 2> /dev/null
  pidf=$(ps ax -o pid=,args= | grep 'twm/twm.sh' | grep -v 'grep' | head -n1 | grep -o -E '([0-9]{3,5})')
  sleep 1s
 done
 if [ -f ~/twm/.runmode_file ] ; then
  if awk '{if ($0 == "-cv") print $0}' ~/twm/.runmode_file ; then
   echo -e "${COLOR_GREEN}Automatically restarting in 5s after update...${COLOR_RESET}"
   sleep 5s
   ~/twm/play.sh -cl
  elif awk '{if ($0 == "-cv") print $0}' ~/twm/.runmode_file ; then
   echo -e "${COLOR_GREEN}Automatically restarting in 5s after update...${COLOR_RESET}"
   sleep 5s
   ~/twm/play.sh -cv
  else
   echo -e "${COLOR_GREEN}Automatically restarting in 5s after update...${COLOR_RESET}"
   sleep 5s
   ~/twm/play.sh
  fi
 fi #-f ~/twm/RUNMODE
else #$(curl -s -L ...
 curl -H "Authorization: Bearer $TWMKEY" -H "Accept: application/vnd.github.v3.raw" ${SERVER}sourceinstall.sh -s -L >$HOME/twm/sourceinstall.sh
 chmod +x $HOME/sourceinstall.sh
 curl -H "Authorization: Bearer $TWMKEY" -H "Accept: application/vnd.github.v3.raw" ${SERVER}easyinstall.sh -s -L >$HOME/easyinstall.sh
 chmod +x $HOME/easyinstall.sh
 echo -e "${COLOR_YELLOW}Mistake! Try again later.\nRun 'bash easyinstall.sh'${COLOR_RESET}"
fi #$(curl -s -L ...

