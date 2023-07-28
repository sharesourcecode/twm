#!/bin/bash
clear
BLACK_CYAN='\033[01;36m\033[01;07m'
BLACK_GREEN='\033[00;32m\033[01;07m'
GOLD_BLACK='\033[33m'
CYAN_BLACK='\033[36m'
COLOR_RESET='\033[00m'

version="master"
printf "Versions\n 1- Master\n 2- Beta1\n 3- Beta2\n"
printf "Select the version: \n"
read -n 1 version
case $version in
(1)
version="master"
;;
(2)
version="beta1"
;;
(3)
version="backup"
esac
printf "\n $version"
printf "${CYAN_BLACK} 🔁Upgrading... Please wait...${COLOR_RESET}\n"
cd ~/
rm -rf $HOME/sourceinstall.sh
rm -rf $HOME/easyinstall.sh
rm -rf $HOME/twminstall.sh
rm -rf $HOME/info.sh
#sleep 0.5s
curl https://raw.githubusercontent.com/sharesourcecode/twm/${version}/info.sh -s -L -O >$HOME/info.sh
sleep 1s
curl https://raw.githubusercontent.com/sharesourcecode/twm/${version}/sourceinstall.sh -s -L -O >$HOME/sourceinstall.sh
sleep 1s
curl https://raw.githubusercontent.com/sharesourcecode/twm/${version}/easyinstall.sh -s -L -O >$HOME/easyinstall.sh
sleep 1s
curl https://raw.githubusercontent.com/sharesourcecode/twm/${version}/twminstall.sh -s -L -O >$HOME/easyinstall.sh
sleep 1s
chmod +x $HOME/*.sh
printf "${BLACK_GREENN}✅ Updated... Starting${COLOR_RESET}\n"
./twminstall.sh