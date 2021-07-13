_sync () {
	SERVER="https://raw.githubusercontent.com/sharesourcecode/twm/master"
	echo -e "\e[01;30m\e[01;07m\n Upgrading...\n👉 Please wait...☕👴\e[00m"
	echo -e "\n Downloading 1/21 PLAY.sh"
	curl $SERVER/PLAY.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 2/21 allies.sh"
	curl $SERVER/allies.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 3/21 altars.sh"
	curl $SERVER/altars.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 4/21 arena.sh"
	curl $SERVER/arena.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 5/21 campaign.sh"
	curl $SERVER/campaign.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 6/21 career.sh"
	curl $SERVER/career.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 7/21 cave.sh"
	curl $SERVER/cave.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 8/21 clancoliseum.sh"
	curl $SERVER/clancoliseum.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 9/21 clandungeon.sh"
	curl $SERVER/clandungeon.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 10/21 clanfight.sh"
	curl $SERVER/clanfight.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 11/21 clanid.sh"
	curl $SERVER/clanid.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 12/21 coliseum.sh"
	curl $SERVER/coliseum.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 13/21 crono.sh"
	curl $SERVER/crono.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 14/21 flagfight.sh"
	curl $SERVER/flagfight.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 15/21 king.sh"
	curl $SERVER/king.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 16/21 loginlogoff.sh"
	curl $SERVER/loginlogoff.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 17/21 play.sh"
	curl $SERVER/play.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 18/21 requeriments.sh"
	curl $SERVER/requeriments.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 19/21 svproxy.sh"
	curl $SERVER/svproxy.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 20/21 trade.sh"
	curl $SERVER/trade.sh -O -L &> /dev/null ;
	echo -e "\n Downloading 21/21 undying.sh"
	curl $SERVER/undying.sh -O -L &> /dev/null ;
	dos2unix *.sh &> /dev/null
	chmod a+x -R $HOME/twm/
	#cp -R twm/ storage/downloads/twm
}
termux-wake-lock &> /dev/null
[[ ! -e installed.txt ]] && apt install coreutils ncurses-utils git termux-api w3m curl dos2unix dnsutils -y; >installed.txt
rm -rf $HOME/twm/ &> /dev/null
mkdir -p $HOME/twm
cd $HOME/twm
_sync
echo -e "\n Intalled scripts!\n Run command bash twm/PLAY.sh to execute."
