#!/bin/bash
BLACK_CYAN='\033[01;36m\033[01;07m'
BLACK_GREEN='\033[00;32m\033[01;07m'
COLOR_RESET='\033[00m'
version="master"
printf "Versions\n 1- Master\n 2- Beta1\n 3- Beta2\n"
printf "Select the version: "
read -t 5 version
case $version in
(1)
version="master"
;;
(2)
version="Beta-Teste"
;;
(3)
version="backup"
esac
echo $version
printf "${BLACK_CYAN} Upgrading...👉 Please wait...☕👴${COLOR_RESET}\n"
cd ~/
rm -rf $HOME/sourceinstall.sh
curl https://raw.githubusercontent.com/sharesourcecode/twm/${version}/sourceinstall.sh -s -L >$HOME/sourceinstall.sh
chmod +x $HOME/sourceinstall.sh
printf "${BLACK_GREENN}✅ Updated... Starting${COLOR_RESET}\n"
./sourceinstall.sh