_requeriments () {
# /tmp dir
	mkdir -p $HOME/.tmp
# /update script and dependencies
	echo -e "\n Upgrading..."
	echo -e "👉 Please wait...☕👴"
	_sync () {
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
	}
# /termux on android
	cd $HOME/.tmp
	termux-wake-lock &> /dev/null
	if [[ $? = 0 ]] ; then
		[[ ! -e executed.txt ]] && pkg install termux-api w3m curl dos2unix -y && >executed.txt
# _sync - to disable coment #
		[[ $(date +%H) -lt 10 || $(date +%H) -gt 22 ]] && _sync
		reset; clear
		echo -e "Successful updates!\n"
	else
		sudo apt install w3m curl dos2unix -y
		[[ $(date +%H) -lt 10 || $(date +%H) -gt 22 ]] && _sync
		reset; clear
	fi
# /user agents to $HOME/.tmp/.ua
_userAgent () {
	cd $HOME/.tmp
#	echo -e 'Mozilla/5.0 (Android 7.1.2; Mobile; rv:80.0) Gecko/80.0 Firefox/80.0' >.ua
	echo -e '"Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.2.2339 Mobile Safari/537.35+"\n"Mozilla/5.0 (Linux; U; Android 4.3; en-us; ZTE-Z667G Build/JLS36C) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"\n"Mozilla/5.0 (Mobile; rv:32.0) Gecko/32.0 Firefox/32.0"\n"Mozilla/5.0 (Android; Linux armv7l; rv:5.0) Gecko/20110615 Firefox/5.0 Fennec/5.0"' >.ua
	clear
	echo "Simulate your real or random device."
	echo -e "\n1) Mannualy (Recommended)\n2) Automatic (not secure)\n"
	read -p "Set up User-Agent[1 to 2]: " -t 300 -e -n 1 UA
	case $UA in

		(1) clear; xdg-open "https://www.whatsmyua.info" ; read -p "Copy and paste your User Agent here and tip ENTER: " -t 300 -e -n 250 UA && echo "$UA" >$HOME/.tmp/.ua ;;

		(2) echo "Completed." ;;

		(*) clear; [[ -n $UA ]] && echo -e "\n Invalid option: $(echo $UA)" && kill -9 $$ || echo -e "\n Time exceeded!";;
	esac
	unset UA
}
if [[ ! -e $HOME/.tmp/.ua ]] ; then
	_userAgent
elif [[ $(cat $HOME/.tmp/.ua | wc -c) -lt 10 ]] ; then
	_userAgent
elif [[ $(cat $HOME/.tmp/.ua | wc -c) -gt 300 ]] ; then
	_userAgent
else
	echo -e "User-Agent: $(cat $HOME/.tmp/.ua)"
fi
dos2unix ~/.tmp/.ua &> /dev/null
# /servers
clear
	if [[ -z $URL ]] ; then
		echo -e " 1) 🇬🇧 English, Global: Titan's War online\n 2) 🇷🇺 Русский: Битва Титанов онлайн\n 3) 🇵🇱 Polski: Wojna Tytanów online\n 4) 🇩🇪 Deutsch: Krieg der Titanen online\n 5) 🇪🇸 Español: Guerra de Titanes online\n 6) 🇧🇷 Brazil, 🇵🇹 Português: Furia de Titãs online\n 7) 🇮🇹 Italiano: Guerra di Titani online\n 8) 🇫🇷 Français: Combat des Titans online\n 9) 🇷🇴 Română: Războiul Titanilor online\n10) 🇨🇳 中文, Chinese: 泰坦之战\n11) 🇮🇩 Indonesian: Titan's War Indonesia\n0) ❌ Cancel\n"
		read -p "Select number Server[1 to 11]: " -t 300 -e -n 2 UR
		case $UR in
			(1) URL='tiwar.net' ; export TZ=Europe/London ; ALLIES="_WORK" ;;

			(2|ru) URL='tiwar.ru' ; export TZ=Europe/Moscow ; ALLIES="" ;;

			(3|pl) URL='tiwar.pl' ; export TZ=Europe/Warsaw ; ALLIES="_WORK" ;;

			(4) URL='titanen.mobi' ; export TZ=Europe/Berlin ; ALLIES="_WORK" ;;

			(5) URL='guerradetitanes.net' ; export TZ=America/Cancun ; ALLIES="_WORK" ;;

			(6|fu) URL='furiadetitas.net' ; export TZ=America/Bahia ; ALLIES="_WORK" ;;

			(7) URL='guerradititani.net' ; export TZ=Europe/Rome ; ALLIES="_WORK" ;;

			(8|fr) URL='tiwar.fr' ; export TZ=Europe/Paris ; ALLIES="_WORK" ;;

			(9|ro) URL='tiwar.ro' ; export TZ=Europe/Bucharest ; ALLIES="_WORK" ;;

			(10|cn) URL='cn.tiwar.net' ; export TZ=Asia/Shanghai ; ALLIES="" ;;

			(11|ba) URL='tiwar-id.net' ; export TZ=Asia/Barnaul ; ALLIES="_WORK" ;;

			(0) kill -9 $$ ;;

			(*) clear; [[ -n $UR ]] && echo -e "\n Invalid option: $(echo $UR)" && kill -9 $$ || echo -e "\n Time exceeded!" ;;
		esac
	fi
	unset UR; clear
	[[ -z $URL ]] && exit
}
