_requeriments () {
# /servers
	clear
	if [[ -z $URL ]] ; then
		_one () {
			clear
			echo -e " \e[01;32m\e[01;07m1\e[00m)\e[01;30m\e[01;07m 🇬🇧 English, Global: Titan's War online \e[01;32m\e[01;07m[ENTER]\e[00m\n 2)\e[05;30m\e[08;07m 🇷🇺 Русский: Битва Титанов онлайн \e[00m\n 3)\e[01;30m\e[08;07m 🇵🇱 Polski: Wojna Tytanów online \e[00m\n 4)\e[05;30m\e[08;07m 🇩🇪 Deutsch: Krieg der Titanen online \e[00m\n 5)\e[01;30m\e[08;07m 🇪🇸 Español: Guerra de Titanes online \e[00m\n 6)\e[05;30m\e[08;07m 🇧🇷 Brazil, 🇵🇹 Português: Furia de Titãs online \e[00m\n 7)\e[01;30m\e[08;07m 🇮🇹 Italiano: Guerra di Titani online \e[00m\n 8)\e[05;30m\e[08;07m 🇫🇷 Français: Combat des Titans online \e[00m\n 9)\e[01;30m\e[08;07m 🇷🇴 Română: Războiul Titanilor online \e[00m\n\e[01;32m\e[01;07m1\e[00m0)\e[01;30m\e[01;07m 🇨🇳 中文, Chinese: 泰坦之战 \e[00m\n\e[01;32m\e[01;07m1\e[00m1)\e[01;30m\e[01;07m 🇮🇩 Indonesian: Titan's War Indonesia \e[00m\n C)\e[00;33m\e[01;07m ❌ Cancel \e[00m"
			while IFS= read -p "Select number Server[1 to 11]: 1" -t 300 -r -s -n 1 UR; do
				if [[ $UR == $'\0' ]]; then
					URL='tiwar.net' ; TMP="$HOME/.1" ; export TZ=Europe/London LANG=en.UTF-8 ; ALLIES="_WORK" ; break
				elif [[ $UR == 0 ]]; then
					URL='cn.tiwar.net' ; TMP="$HOME/.10" ; export TZ=Asia/Shanghai LANG=zh-CN.UTF-8 ; ALLIES="_WORK" ; break
				elif [[ $UR == 1 ]]; then
					URL='tiwar-id.net' ; TMP="$HOME/.11" ; export TZ=Asia/Jakarta LANG=id.UTF-8 ; ALLIES="_WORK" ; break
				elif [[  $UR  == $'\177' ]]; then
					_requeriments
				else
					clear; [[ -n $UR ]] && echo -e "\n Invalid option: $(echo $UR)" && kill -9 $$ || echo -e "\n Time exceeded!"
				fi
			done
		}
		echo -e " 1)\e[01;30m\e[01;07m 🇬🇧 English, Global: Titan's War online \e[00m\n 2)\e[01;30m\e[01;07m 🇷🇺 Русский: Битва Титанов онлайн \e[00m\n 3)\e[01;30m\e[01;07m 🇵🇱 Polski: Wojna Tytanów online \e[00m\n 4)\e[01;30m\e[01;07m 🇩🇪 Deutsch: Krieg der Titanen online \e[00m\n 5)\e[01;30m\e[01;07m 🇪🇸 Español: Guerra de Titanes online \e[00m\n 6)\e[01;30m\e[01;07m 🇧🇷 Brazil, 🇵🇹 Português: Furia de Titãs online \e[00m\n 7)\e[01;30m\e[01;07m 🇮🇹 Italiano: Guerra di Titani online \e[00m\n 8)\e[01;30m\e[01;07m 🇫🇷 Français: Combat des Titans online \e[00m\n 9)\e[01;30m\e[01;07m 🇷🇴 Română: Războiul Titanilor online \e[00m\n10)\e[01;30m\e[01;07m 🇨🇳 中文, Chinese: 泰坦之战 \e[00m\n11)\e[01;30m\e[01;07m 🇮🇩 Indonesian: Titan's War Indonesia \e[00m\n C)\e[00;33m\e[02;07m ❌ Cancel \e[00m"
		read -p "Select number Server[1 to 11]: " -t 300 -e -n 1 UR
		case $UR in
			(1) _one ;;

			(2|ru) URL='tiwar.ru' ; TMP="$HOME/.2" ; export TZ=Europe/Moscow LANG=ru.UTF-8 ; ALLIES="_WORK" ;;

			(3|pl) URL='tiwar.pl' ; TMP="$HOME/.3" ; export TZ=Europe/Warsaw LANG=pl.UTF-8 ; ALLIES="_WORK" ;;

			(4) URL='titanen.mobi' ; TMP="$HOME/.4" ; export TZ=Europe/Berlin LANG=de.UTF-8 ; ALLIES="_WORK" ;;

			(5) URL='guerradetitanes.net' ; TMP="$HOME/.5" ; export TZ=America/Cancun LANG=es-MX.UTF-8 ;  ALLIES="_WORK" ;;

			(6|fu) URL='furiadetitas.net' ; TMP="$HOME/.6" ; export TZ=America/Bahia LANG=pt-BR.UTF-8 ;ALLIES="_WORK" ;;

			(7) URL='guerradititani.net' ; TMP="$HOME/.7" ; export TZ=Europe/Rome LANG=it.UTF-8 ; ALLIES="_WORK" ;;

			(8|fr) URL='tiwar.fr' ; TMP="$HOME/.8" ; export TZ=Europe/Paris LANG=fr-FR.UTF-8 ; ALLIES="_WORK" ;;

			(9|ro) URL='tiwar.ro' ; TMP="$HOME/.9" ; export TZ=Europe/Bucharest LANG=ro.UTF-8 ; ALLIES="_WORK" ;;

			(10|cn) _one ;;

			(11|ba) _one ;;

			(0|c|C) kill -9 $$ ;;

			(*) clear; [[ -n $UR ]] && echo -e "\n Invalid option: $(echo $UR)" && kill -9 $$ || echo -e "\n Time exceeded!" ;;
		esac
	fi
	unset UR; clear
	[[ -z $URL ]] && exit
# /tmp dir
	mkdir -p $TMP
# /update script and dependencies
	echo -e "\n Upgrading..."
	echo -e "👉 Please wait...☕👴"
	_sync () {
		cd $HOME/twm
		curl https://raw.githubusercontent.com/sharesourcecode/twm/master/cave.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 1/21"
		curl https://raw.githubusercontent.com/sharesourcecode/twm/master/PLAY.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 2/21"
		curl https://raw.githubusercontent.com/sharesourcecode/twm/master/altars.sh -O -L &> /dev/null ;
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
		curl https://raw.githubusercontent.com/sharesourcecode/twm/master/requeriments.sh -O -L &> /dev/null ;
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
	cd $TMP
	termux-wake-lock &> /dev/null
	if [[ $? = 0 ]] ; then
		[[ ! -e executed.txt ]] && pkg install termux-api w3m curl dos2unix dnsutils -y && >executed.txt
# _sync - to disable coment #
		[[ $(date +%H) -lt 10 || $(date +%H) -gt 22 ]] && _sync
		reset; clear
		echo -e "Successful updates!\n"
	else
		sudo apt install w3m curl dos2unix dnsutils -y
		[[ $(date +%H) -lt 10 || $(date +%H) -gt 22 ]] && _sync
		reset; clear
	fi
# /user agents to $TMP/.ua
_userAgent () {
	cd $TMP
#	echo -e 'Mozilla/5.0 (Android 7.1.2; Mobile; rv:80.0) Gecko/80.0 Firefox/80.0' >.ua
	echo -e '"Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.2.2339 Mobile Safari/537.35+"\n"Mozilla/5.0 (Linux; U; Android 4.3; en-us; ZTE-Z667G Build/JLS36C) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"\n"Mozilla/5.0 (Mobile; rv:32.0) Gecko/32.0 Firefox/32.0"\n"Mozilla/5.0 (Android; Linux armv7l; rv:5.0) Gecko/20110615 Firefox/5.0 Fennec/5.0"' >.ua
	clear
	echo "Simulate your real or random device."
	echo -e "\n1) Mannualy (Recommended)\n2) Automatic (not secure)\n"
	read -p "Set up User-Agent[1 to 2]: " -t 300 -e -n 1 UA
	case $UA in

		(1) clear; xdg-open "https://www.whatsmyua.info" ; read -p "Copy and paste your User Agent here and tip ENTER: " -t 300 -e -n 250 UA && echo "$UA" >$TMP/.ua ;;

		(2) echo "Completed." ;;

		(*) clear; [[ -n $UA ]] && echo -e "\n Invalid option: $(echo $UA)" && kill -9 $$ || echo -e "\n Time exceeded!";;
	esac
	unset UA
}
if [[ ! -e $TMP/.ua ]] ; then
	_userAgent
elif [[ $(cat $TMP/.ua | wc -c) -lt 10 ]] ; then
	_userAgent
elif [[ $(cat $TMP/.ua | wc -c) -gt 300 ]] ; then
	_userAgent
else
	echo -e "User-Agent: $(cat $TMP/.ua)"
fi
dos2unix $TMP/.ua &> /dev/null
}
