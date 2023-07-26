#!/bin/bash
BLACK_CYAN='\033[01;36m\033[01;07m'
printf "${BLACK_CYAN} Upgrading...\n👉 Please wait...☕👴${COLOR_RESET}\n"
cd ~/
rm -rf $HOME/sourceinstall.sh
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/sourceinstall.sh -L -O
sleep 3s
chmod +x ./sourceinstall.sh
printf "Updated... Starting"
./sourceinstall.sh