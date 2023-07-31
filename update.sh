#!/bin/sh
clear
BLACK_CYAN='\033[01;36m\033[01;07m'
BLACK_GREEN='\033[00;32m\033[01;07m'
BLACK_YELLOW='\033[00;33m\033[01;07m'
GOLD_BLACK='\033[33m'
CYAN_BLACK='\033[36m'
COLOR_RESET='\033[00m'

printf "Versions\n 1- Master\n 2- Beta 1\n 3- Old\n"
printf "${CYAN_BLACK}Select the version:${COLOR_RESET} \n"

#/user input
#stty -echo
stty raw
VERSION=$(dd bs=1 count=1 2>/dev/null)
stty -raw
#stty echo

case $VERSION in
 (1)
  VERSION="Master"
 ;;
 (2)
  VERSION="Beta 1"
 ;;
 (3)
  VERSION="Backup"
 ;;
esac
version=$(echo "$VERSION"|sed 's/[ \t]//g'|tr "[[:upper:]]" "[[:lower:]]")

printf "\n${CYAN_BLACK}🔧 Preparing${COLOR_RESET} ${GOLD_BLACK}$VERSION${COLOR_RESET} ${CYAN_BLACK}repository source...${COLOR_RESET}\n"

mkdir -p ~/twm
cd ~/twm

SCRIPTS="info.sh easyinstall.sh"
rm -rf "$HOME/$SCRIPTS" $SCRIPTS 2>/dev/null

SERVER="https://raw.githubusercontent.com/sharesourcecode/twm/${version}/"

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

 chmod +x "$script"
 sleep 0.1s
done
cp easyinstall.sh "$HOME/easyinstall.sh" 2>/dev/null

printf "\n${BLACK_GREEN}✅ Updated repository source${COLOR_RESET}\n\n${BLACK_CYAN}Starting ./easyinstall.sh $version ...${COLOR_RESET}\n"
sleep 3s
./easyinstall.sh $version
