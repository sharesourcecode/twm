#!/bin/bash
termux-wake-lock &> /dev/null
[[ ! -e installed.txt ]] && pkg update -y && pkg install git termux-api w3m curl dos2unix dnsutils -y && >installed.txt
termux-setup-storage &> /dev/null
echo "Click Enter to continue."
rm -rf twm/ &> /dev/null
git clone https://github.com/sharesourcecode/twm.git
chmod a+x -R twm/
cp -R twm/ storage/downloads/twm
reset; clear
echo "Intalled scripts! Run command ./twm/Play to execute."
exit
