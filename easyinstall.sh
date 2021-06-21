#!/bin/bash
termux-wake-lock &> /dev/null
#echo "deb https://termux.mentality.rip/termux-main stable main" >$PREFIX/etc/apt/sources.list
#echo "deb https://termux.mentality.rip/termux-games games stable" >$PREFIX/etc/apt/sources.list.d/game.list
#echo "deb https://termux.mentality.rip/termux-science science stable" >$PREFIX/etc/apt/sources.list.d/science.list
[[ ! -e installed.txt ]] && pkg install coreutils ncurses-utils git termux-api w3m curl dos2unix dnsutils -y; >installed.txt
echo "Click Enter to continue."
rm -rf twm/ &> /dev/null
git clone https://github.com/sharesourcecode/twm.git
chmod a+x -R twm/
cp -R twm/ storage/downloads/twm
reset; clear
echo -e "\n Intalled scripts!\n Run command bash twm/PLAY.sh to execute."
exit
