#!/bin/sh
#create fold twm if does not exist
mkdir -p ~/twm

if [ ! -e "~/twm/info.sh" ]; then
 curl https://raw.githubusercontent.com/sharesourcecode/twm/backup/info.sh -s -L >$HOME/twm/info.sh
 chmod +x ~/twm/info.sh
 sleep 0.5s
fi

. ~/twm/info.sh
colors
script_slogan

#access dir
cd ~/twm

if [ -z "$@" ]; then
 version="backup"
else
#./easyinstall.sh beta1, or backup
 version="$@"
fi

SERVER="https://raw.githubusercontent.com/sharesourcecode/twm/$version/"
remote_count=$(curl ${SERVER}easyinstall.sh -s -L|wc -c)
if [ -e "easyinstall.sh" ]; then
 local_count=$(wc -c <"easyinstall.sh")
else
 local_count=1
fi

cd ~/
printf "${BLACK_CYAN} Installing TWM...\n⌛ Please wait...⌛${COLOR_RESET}\n"

#termux
if [ -d /data/data/com.termux/files/usr/share/doc ]; then
 termux-wake-lock
 sed -u -i '/nameserver/d' $PREFIX/etc/resolv.conf &>/dev/null
 printf "nameserver 94.140.14.15\nnameserver 94.140.15.16" >$PREFIX/etc/resolv.conf
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

#/cygwin
if uname|grep -q -i "cygwin"; then
 LS="/usr/share/doc"
 if [ -e /bin/apt-cyg ]; then
  :
 else
  #/cygwin repository
  curl -s -L -O "http://raw.githubusercontent.com/sharesourcecode/apt-cyg/master/apt-cyg" &>/dev/null
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

#/ish Iphone
APPISH=$(uname -a|grep -o '-ish')
if [ "$SHELL" = "/bin/ash" ] && [ "$APPISH" = '-ish' ]; then
 LS='/usr/share/doc'
 printf "${BLACK_CYAN}Install the necessary packages for Alpine on app ISh(Iphone):${COLOR_RESET}\n apk update\n apk add curl ; apk add w3m ; apk add coreutils ; apk add --no-cache tzdata\n\n"
 sleep 5s
#/UserLAnd Terminal
elif [ "$SHELL" != "/bin/ash" ] && [ "$APPISH" != '-ish' ] && uname -m|grep -q -E '(aarch64|armhf|armv7|mips64)' && [ ! -d /data/data/com.termux/files/usr/share/doc ]; then
 sudo apk update
 sudo apk add curl ; sudo apk add w3m ; sudo apk add coreutils ; sudo apk add --no-cache tzdata
 LS='/usr/share/doc'
 printf "${BLACK_CYAN}Install the necessary packages for Alpine on app UserLAnd(Android):${COLOR_RESET}\n apk update\n sudo apk add curl ; sudo apk add w3m ; sudo apk add coreutils ; sudo apk add --no-cache tzdata\n\n"
 sleep 5s
#/other linux
elif [ "$SHELL" != "/bin/ash" ] && [ "$APPISH" != '-ish' ] && uname -m|grep -q -E "(ppc64le|riscv64|s390x|x86|x86_64)" && [ ! -d /data/data/com.termux/files/usr/share/doc ]; then
 LS='/usr/share/doc'
 printf "${BLACK_CYAN}Install required packages for Linux or Windows WSL:${COLOR_RESET}\n sudo apt update\n sudo apt install curl coreutils ncurses-term procps w3m -y\n"
 sleep 5s
fi

#starting...
unset LS
cd ~/twm
#script_slogan
printf "${BLACK_CYAN}\n ⌛ Wait downloading scripts...${COLOR_RESET}\n"

sync_func () {
 SCRIPTS="allies.sh altars.sh arena.sh campaign.sh career.sh cave.sh check.sh clancoliseum.sh clandungeon.sh clanfight.sh clanid.sh coliseum.sh crono.sh flagfight.sh king.sh league.sh loginlogoff.sh play.sh requeriments.sh run.sh svproxy.sh trade.sh twm.sh undying.sh"
 NUM_SCRIPTS=$(echo $SCRIPTS|wc -w)
 LEN=0
 for script in $SCRIPTS; do
  LEN=$((LEN+1))
  printf "Checking $LEN/$NUM_SCRIPTS $script\n"
  remote_count=$(curl ${SERVER}$script -s -L|wc -c)

  if [ -e ~/twm/$script ]; then
   local_count=$(wc -c < "$script")
  else
   local_count=1
  fi

  if [ -e ~/twm/$script ] && [ "$remote_count" -eq "$local_count" ]; then
   printf "✅ ${BLACK_CYAN}Updated $script${COLOR_RESET}\n"
  elif [ -e ~/twm/$script ] && [ "$remote_count" -ne "$local_count" ]; then
   printf "🔁 ${BLACK_GREEN}Updating $script${COLOR_RESET}\n"
   curl ${SERVER}$script -s -L > $script
  else
   printf "🔽 ${BLACK_YELLOW}Downloading $script${COLOR_RESET}\n"
   curl ${SERVER}$script -s -L -O
  fi
  sleep 0.1s
 done
 #DOS to Unix
 find ~/twm -type f -name '*.sh' -print0|xargs -0 sed -i 's/\r$//' 2>/dev/null
 chmod +x ~/twm/*.sh &>/dev/null
}

sync_func_other () {
 SCRIPTS="requeriments.sh svproxy.sh loginlogoff.sh crono.sh check.sh run.sh clanid.sh allies.sh altars.sh arena.sh campaign.sh career.sh cave.sh clancoliseum.sh clandungeon.sh clanfight.sh coliseum.sh flagfight.sh king.sh league.sh trade.sh undying.sh"
 curl ${SERVER}play.sh -s -L -O
 curl ${SERVER}info.sh -s -L >twm.sh
 curl ${SERVER}twm.sh -s -L|sed -n '3,33p' >>twm.sh
 NUM_SCRIPTS=$(echo $SCRIPTS|wc -w)
 LEN=0

 for script in $SCRIPTS; do
  LEN=$((LEN+1))
  printf "Checking $LEN/$NUM_SCRIPTS $script\n"
  printf "🔁 ${BLACK_GREEN}Updating $script${COLOR_RESET}\n"
  curl ${SERVER}$script -s -L >>twm.sh
  printf "\n#\n" >>twm.sh
  sleep 0.1s
 done
 curl ${SERVER}twm.sh -s -L|sed -n '40,120p' >>twm.sh

 APPISH=$(uname -a|grep -o '-ish')
 if [ "$SHELL" = "/bin/ash" ] && [ "$APPISH" = '-ish' ]; then
  sed -i 's,#!/bin/bash,#!/bin/sh,g' $HOME/twm/*.sh
 fi

 #DOS to Unix
 find ~/twm -type f -name '*.sh' -print0|xargs -0 sed -i 's/\r$//' 2>/dev/null
 chmod +x ~/twm/*.sh &>/dev/null
}

#/merge
if [ "$@" = "m" ]; then
  sync_func_other
else
  sync_func
fi

script_slogan
printf "✅ ${BLACK_CYAN}Updated scripts!${COLOR_RESET}\n To execute run command: ${GOLD_BLACK}./twm/play.sh${COLOR_RESET}\n       For coliseum run: ${GOLD_BLACK}./twm/play.sh -cl${COLOR_RESET}\n           For cave run: ${GOLD_BLACK}./twm/play.sh -cv${COLOR_RESET}\n"
tipidf=$(ps ax -o pid=,args=|grep "sh.*twm/play.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
until [ -z $tipidf ]; do
 kill -9 $tipidf 2>/dev/null
 tipidf=$(ps ax -o pid=,args=|grep "sh.*twm/play.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
 sleep 1s
done
tipidf=$(ps ax -o pid=,args=|grep "sh.*twm/twm.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
until [ -z $tipidf ]; do
 kill -9 $tipidf 2>/dev/null
 tipidf=$(ps ax -o pid=,args=|grep "sh.*twm/twm.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
 sleep 1s
done
if [ -f ~/twm/runmode_file ]; then
 if awk '{if ($0 == "-cv") print $0}' ~/twm/runmode_file; then
  printf "${BLACK_GREEN}Automatically restarting in 5s after update...${COLOR_RESET}\n"
  sleep 5s
  ~/twm/play.sh -cl
 elif awk '{if ($0 == "-cv") print $0}' ~/twm/runmode_file; then
  printf "${BLACK_GREEN}Automatically restarting in 5s after update...${COLOR_RESET}\n"
  sleep 5s
  ~/twm/play.sh -cv
 else
  printf "${BLACK_GREEN}Automatically restarting in 5s after update...${COLOR_RESET}\n"
  sleep 5s
  ~/twm/play.sh -boot
 fi
fi
