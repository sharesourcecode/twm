#!/bin/bash
termux-wake-lock &> /dev/null
[[ ! -e installed.txt ]] && apt install coreutils ncurses-utils git termux-api w3m curl dos2unix dnsutils -y; >installed.txt
rm -rf $HOME/twm/ &> /dev/null
mkdir -p $HOME/twm
cd $HOME/twm
curl https://github.com/sharesourcecode/twm/raw/master/cave.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 1/21"
curl https://github.com/sharesourcecode/twm/raw/master/PLAY.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 2/21"
curl https://github.com/sharesourcecode/twm/raw/master/altars.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 3/21"
curl https://github.com/sharesourcecode/twm/raw/master/arena.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 4/21"
curl https://github.com/sharesourcecode/twm/raw/master/campaign.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 5/21"
curl https://github.com/sharesourcecode/twm/raw/master/career.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 6/21"
curl https://github.com/sharesourcecode/twm/raw/master/clancoliseum.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 7/21"
curl https://github.com/sharesourcecode/twm/raw/master/clandungeon.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 8/21"
curl https://github.com/sharesourcecode/twm/raw/master/clanfight.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 9/21"
curl https://github.com/sharesourcecode/twm/raw/master/clanid.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 10/21"
curl https://github.com/sharesourcecode/twm/raw/master/coliseum.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 11/21"
curl https://github.com/sharesourcecode/twm/raw/master/crono.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 12/21"
curl https://github.com/sharesourcecode/twm/raw/master/king.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 13/21"
curl https://github.com/sharesourcecode/twm/raw/master/loginlogoff.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 14/21"
curl https://github.com/sharesourcecode/twm/raw/master/play.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 15/21"
curl https://github.com/sharesourcecode/twm/raw/master/requeriments.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 16/21"
curl https://github.com/sharesourcecode/twm/raw/master/trade.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 17/21"
curl https://github.com/sharesourcecode/twm/raw/master/undying.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 18/21"
curl https://github.com/sharesourcecode/twm/raw/master/flagfight.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 19/21"
curl https://github.com/sharesourcecode/twm/raw/master/allies.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 20/21"
curl https://github.com/sharesourcecode/twm/raw/master/svproxy.sh -O -L &> /dev/null ;
echo -e "\n Upgrading 21/21"
dos2unix *.sh &> /dev/null
cd $HOME    
chmod a+x -R twm/
cp -R twm/ storage/downloads/twm
reset; clear
echo -e "\n Intalled scripts!\n Run command bash twm/PLAY.sh to execute."
exit
