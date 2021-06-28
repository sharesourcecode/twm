#!/bin/bash
termux-wake-lock &> /dev/null
[[ ! -e installed.txt ]] && apt install coreutils ncurses-utils git termux-api w3m curl dos2unix dnsutils -y; >installed.txt
rm -rf $HOME/twm/ &> /dev/null
mkdir -p $HOME/twm
cd $HOME/twm
echo -e "\n Downloading 1/21 PLAY.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/PLAY.sh -O -L &> /dev/null ;
echo -e "\n Downloading 2/21 allies.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/allies.sh -O -L &> /dev/null ;
echo -e "\n Downloading 3/21 altars.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/altars.sh -O -L &> /dev/null ;
echo -e "\n Downloading 4/21 arena.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/arena.sh -O -L &> /dev/null ;
echo -e "\n Downloading 5/21 campaign.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/campaign.sh -O -L &> /dev/null ;
echo -e "\n Downloading 6/21 career.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/career.sh -O -L &> /dev/null ;
echo -e "\n Downloading 7/21 cave.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/cave.sh -O -L &> /dev/null ;
echo -e "\n Downloading 8/21 clancoliseum.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/clancoliseum.sh -O -L &> /dev/null ;
echo -e "\n Downloading 9/21 clandungeon.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/clandungeon.sh -O -L &> /dev/null ;
echo -e "\n Downloading 10/21 clanfight.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/clanfight.sh -O -L &> /dev/null ;
echo -e "\n Downloading 11/21 clanid.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/clanid.sh -O -L &> /dev/null ;
echo -e "\n Downloading 12/21 coliseum.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/coliseum.sh -O -L &> /dev/null ;
echo -e "\n Downloading 13/21 crono.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/crono.sh -O -L &> /dev/null ;
echo -e "\n Downloading 14/21 flagfight.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/flagfight.sh -O -L &> /dev/null ;
echo -e "\n Downloading 15/21 king.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/king.sh -O -L &> /dev/null ;
echo -e "\n Downloading 16/21 loginlogoff.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/loginlogoff.sh &> /dev/null ;
echo -e "\n Downloading 17/21 play.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/play.sh -O -L &> /dev/null ;
echo -e "\n Downloading 18/21 requeriments.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/requeriments.sh -O -L &> /dev/null ;
echo -e "\n Downloading 19/21 svproxy.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/svproxy.sh -O -L &> /dev/null ;
echo -e "\n Downloading 20/21 trade.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/trade.sh -O -L &> /dev/null ;
echo -e "\n Downloading 21/21 undying.sh"
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/undying.sh -O -L &> /dev/null ;
dos2unix *.sh &> /dev/null
cd $HOME    
chmod a+x -R twm/
cp -R twm/ storage/downloads/twm
reset; clear
echo -e "\n Intalled scripts!\n Run command bash twm/PLAY.sh to execute."
exit
