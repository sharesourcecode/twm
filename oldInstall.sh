#!/bin/sh
# $HOME/easyinstall.sh

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

# Create fold TitansWarMacro-master if does not exist
mkdir -p ~/TitansWarMacro-master

# Access dir
cd ~/TitansWarMacro-master

# Termux DNS
printf "nameserver 1.1.1.1\nnameserver 1.0.0.1" >$PREFIX/etc/resolv.conf 2> /dev/null

#curl -L -O https://github.com/sharesourcecode/TitansWarMacro/archive/refs/heads/master.tar.gz
#tar -xvzf master.tar.gz
#curl -L -O https://codeberg.org/ueliton/auth/raw/branch/main/sha256sum

# (1/2)
SERVER="https://raw.githubusercontent.com/sharesourcecode/TitansWarMacro/refs/heads/master/"

UAGT='Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)'

# Remote LANGUAGE.po
content=$(curl -H $UAGT -s -L $SERVER/LANGUAGE.po)

# Remote info.lib
INFOLIB=$(curl -H $UAGT -s -L $SERVER/info.lib) && \
eval "$INFOLIB" && \
unset INFOLIB

# Update local easyinstall.sh
curl -H $UAGH -s -L $SERVER/easyinstall.sh >$HOME/easyinstall.sh

colors
script_slogan

if [ -z "$@" ] || [ "$@" = 'merge' ]; then
 version="master"
else
# ./easyinstall.sh beta1, or backup
 version="$@"
fi

# (2/2)
SERVER="https://raw.githubusercontent.com/sharesourcecode/TitansWarMacro/refs/heads/$version/"
remote_count=$(curl -H "$UAGH" ${SERVER}easyinstall.sh -s -L|wc -c)
if [ -e "easyinstall.sh" ]; then
 local_count=$(wc -c <"easyinstall.sh")
else
 local_count=1
fi

cd ~/
printf "${BLACK_CYAN} $(G_T "Installing TWM")...\n⌛ $(G_T "Please wait")...⌛${COLOR_RESET}\n"

#termux
if [ -d /data/data/com.termux/files/usr/share/doc ]; then
 termux-wake-lock
 printf "nameserver 1.1.1.1\nnameserver 1.0.0.1" >$PREFIX/etc/resolv.conf
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

#/ish Iphone
APPISH=$(uname -a|grep -o "\-ish")
if [ "$SHELL" = "/bin/ash" ] && [ "$APPISH" = '-ish' ]; then
 LS='/usr/share/doc'
 printf "${BLACK_CYAN}$(G_T "Install the necessary packages for Alpine on app ISh(Iphone)"):${COLOR_RESET}\n apk update\n apk add curl ; apk add w3m ; apk add coreutils ; apk add --no-cache tzdata\n\n"
 sleep 5s
#/UserLAnd Terminal
elif [ "$SHELL" != "/bin/ash" ] && [ "$APPISH" != '-ish' ] && uname -m|grep -q -E '(aarch64|armhf|armv7|mips64)' && [ ! -d /data/data/com.termux/files/usr/share/doc ]; then
 LS='/usr/share/doc'
 printf "${BLACK_CYAN}$(G_T "Install the necessary packages for Alpine on app UserLAnd(Android)"):${COLOR_RESET}\n apk update\n sudo apk add curl ; sudo apk add w3m ; sudo apk add coreutils ; sudo apk add --no-cache tzdata\n\n"
 sleep 1s
#/other linux
elif [ "$SHELL" != "/bin/ash" ] && [ "$APPISH" != '-ish' ] && uname -m|grep -q -E "(ppc64le|riscv64|s390x|x86|x86_64)" && [ ! -d /data/data/com.termux/files/usr/share/doc ]; then
 LS='/usr/share/doc'
 printf "${BLACK_CYAN}$(G_T "Install required packages for Linux or") Windows WSL:${COLOR_RESET}\n sudo apt update\n sudo apt install curl coreutils ncurses-term procps w3m -y\n"
 sleep 5s
fi

#starting...
unset LS
cd ~/TitansWarMacro-master
#script_slogan
printf "${BLACK_CYAN}\n ⌛ $(G_T "Wait downloading scripts")...${COLOR_RESET}\n"

sync_func () {
	SCRIPTS="play.sh TitansWarMacro-master.sh"
	NUM_SCRIPTS=$(echo $SCRIPTS|wc -w)
	LEN=0
	for script in $SCRIPTS; do
		LEN=$((LEN+1))
		printf "$(G_T "Checking") $LEN/$NUM_SCRIPTS $script\n"
 		remote_count=$(curl -H "$UAGH" ${SERVER}$script -s -L|wc -c)

		if [ -e ~/TitansWarMacro-master/$script ]; then
			local_count=$(wc -c < "$script")
		else
			local_count=1
		fi

		if [ -e ~/TitansWarMacro-master/$script ] && [ "$remote_count" -eq "$local_count" ]; then
			printf "✅ ${BLACK_CYAN}$(G_T "Updated") $script${COLOR_RESET}\n"
		elif [ -e ~/TitansWarMacro-master/$script ] && [ "$remote_count" -ne "$local_count" ]; then
			printf "🔁 ${BLACK_GREEN}$(G_T "Updating") $script${COLOR_RESET}\n"
			curl -H "$UAGH" ${SERVER}$script -s -L > $script
		else
			printf "🔽 ${BLACK_YELLOW}$(G_T "Downloading") $script${COLOR_RESET}\n"
			curl -H "$UAGH" ${SERVER}$script -s -L -O
		fi
		sleep 0.1s
	done
# DOS to Unix
	find ~/TitansWarMacro-master -type f -name '*.sh' -print0|xargs -0 sed -i 's/\r$//' 2>/dev/null
# find ~/TitansWarMacro-master -type f -name '*.lib' -print0|xargs -0 sed -i 's/\r$//' 2>/dev/null
	chmod +x ~/TitansWarMacro-master/*.sh &>/dev/null
	unset UAGT SERVER content
}
sync_func

APPISH=$(uname -a|grep -o "\-ish")
if [ "$SHELL" = "/bin/ash" ] && [ "$APPISH" = '-ish' ]; then
	sed -i 's,#!/bin/bash,#!/bin/sh,g' $HOME/TitansWarMacro-master/*.sh
fi

script_slogan

printf "✅ ${BLACK_CYAN}$(G_T "Updated scripts")!${COLOR_RESET}\n $(G_T "To execute run command"): ${GOLD_BLACK}./twmu${COLOR_RESET}\n       $(G_T "For coliseum run"): ${GOLD_BLACK}./twmu -cl${COLOR_RESET}\n           $(G_T "For cave run"): ${GOLD_BLACK}./twmu -cv${COLOR_RESET}\n"

tipidf=$(ps ax -o pid=,args=|grep "sh.*TitansWarMacro-master/play.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
until [ -z $tipidf ]; do
	kill -9 $tipidf 2>/dev/null
	tipidf=$(ps ax -o pid=,args=|grep "sh.*TitansWarMacro-master/play.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
	sleep 1s
done

tipidf=$(ps ax -o pid=,args=|grep "sh.*TitansWarMacro-master/twm.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
until [ -z $tipidf ]; do
	kill -9 $tipidf 2>/dev/null
	tipidf=$(ps ax -o pid=,args=|grep "sh.*TitansWarMacro-master/twm.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
	sleep 1s
done
if [ -f ~/TitansWarMacro-master/runmode_file ]; then
	if awk -v arg="-cl" -v file="$(cat ~/TitansWarMacro-master/runmode_file)" 'BEGIN { exit !(arg == file) }'; then
		printf "${BLACK_GREEN}$(G_T "Automatically restarting in 5s after update")...${COLOR_RESET}\n"
		sleep 5s
		~/TitansWarMacro-master/play.sh -cl
	elif awk -v arg="-cv" -v file="$(cat ~/TitansWarMacro-master/runmode_file)" 'BEGIN { exit !(arg == file) }'; then
		printf "${BLACK_GREEN}$(G_T "Automatically restarting in 5s after update")...${COLOR_RESET}\n"
		sleep 5s
		~/twmu -cv
	else
		printf "${BLACK_GREEN}$(G_T "Automatically restarting in 5s after update")...${COLOR_RESET}\n"
		sleep 5s
		~/twmu -boot
	fi
fi
