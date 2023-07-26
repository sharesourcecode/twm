#!/bin/bash
BLACK_CYAN='\033[01;36m\033[01;07m'
BLACK_GREEN='\033[00;32m\033[01;07m'
COLOR_RESET='\033[00m'
printf "${BLACK_CYAN} Upgrading...👉 Please wait...☕👴${COLOR_RESET}\n"
cd ~/
rm -rf $HOME/sourceinstall.sh
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/sourceinstall.sh -L -O
sleep 3s
chmod +x ./sourceinstall.sh
printf "${BLACK_GREENN}✅ Updated... Starting${COLOR_RESET}\n"
./sourceinstall.sh