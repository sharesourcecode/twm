_requeriments () {
# /servers
	clear
	if [[ -z $URL ]] ; then
		_one () {
			clear
			echo -e " "$rr_"1\e[00m)"$ww_" 🇬🇧 English, Global: Titan's War online "$gg_"[ENTER]\e[00m\n 2)"$_w_" 🇷🇺 Русский: Битва Титанов онлайн \e[00m\n 3)"$_w_" 🇵🇱 Polski: Wojna Tytanów online \e[00m\n 4)"$_w_" 🇩🇪 Deutsch: Krieg der Titanen online \e[00m\n 5)"$_w_" 🇪🇸 Español: Guerra de Titanes online \e[00m\n 6)"$_w_" 🇧🇷 Brazil, 🇵🇹 Português: Furia de Titãs online \e[00m\n 7)"$_w_" 🇮🇹 Italiano: Guerra di Titani online \e[00m\n 8)"$_w_" 🇫🇷 Français: Combat des Titans online \e[00m\n 9)"$_w_" 🇷🇴 Română: Războiul Titanilor online \e[00m\n"$rr_"1\e[00m"$gg_"0\e[00m)"$ww_" 🇨🇳 中文, Chinese: 泰坦之战 \e[00m\n"$rr_"1\e[00m"$gg_"1\e[00m)"$ww_" 🇮🇩 Indonesian: Titan's War Indonesia \e[00m\n C)"$yy_" ❌ Cancel \e[00m"
			while IFS= read -p "Select number Server[1 to 11]: 1" -t 300 -r -s -n 1 UR; do
				if [[ $UR == $'\0' ]]; then
					URL=$(echo "dGl3YXIubmV0" | base64 -d) ; TMP="$HOME/.1" ; export TZ=Europe/London LANG=en.UTF-8 ; ALLIES="_WORK" ; break
				elif [[ $UR == 0 ]]; then
					URL=$(echo "Y24udGl3YXIubmV0" | base64 -d) ; TMP="$HOME/.10" ; export TZ=Asia/Shanghai LANG=zh-CN.UTF-8 ; ALLIES="_WORK" ; break
				elif [[ $UR == 1 ]]; then
					URL=$(echo "dGl3YXItaWQubmV0" | base64 -d) ; TMP="$HOME/.11" ; export TZ=Asia/Jakarta LANG=id.UTF-8 ; ALLIES="_WORK" ; break
				elif [[  $UR  == $'\177' ]]; then
					_requeriments ; break
				else
					clear; [[ -n $UR ]] && echo -e "\n Invalid option: $(echo $UR)" && kill -9 $$ || echo -e "\n Time exceeded!"
				fi
			done
		}
		echo -e " 1)"$ww_" 🇬🇧 English, Global: Titan's War online \e[00m\n 2)"$ww_" 🇷🇺 Русский: Битва Титанов онлайн \e[00m\n 3)"$ww_" 🇵🇱 Polski: Wojna Tytanów online \e[00m\n 4)"$ww_" 🇩🇪 Deutsch: Krieg der Titanen online \e[00m\n 5)"$ww_" 🇪🇸 Español: Guerra de Titanes online \e[00m\n 6)"$ww_" 🇧🇷 Brazil, 🇵🇹 Português: Furia de Titãs online \e[00m\n 7)"$ww_" 🇮🇹 Italiano: Guerra di Titani online \e[00m\n 8)"$ww_" 🇫🇷 Français: Combat des Titans online \e[00m\n 9)"$ww_" 🇷🇴 Română: Războiul Titanilor online \e[00m\n10)"$ww_" 🇨🇳 中文, Chinese: 泰坦之战 \e[00m\n11)"$ww_" 🇮🇩 Indonesian: Titan's War Indonesia \e[00m\n C)\e[00;33m\e[02;07m ❌ Cancel \e[00m"
		read -p "Select number Server[1 to 11]: " -t 300 -e -n 1 UR
		case $UR in
			(1) _one ; break ;;

			(2|ru) URL=$(echo "dGl3YXIucnU=" | base64 -d) ; TMP="$HOME/.2" ; export TZ=Europe/Moscow LANG=ru.UTF-8 ; ALLIES="_WORK" ;;

			(3|pl) URL=$(echo "dGl3YXIucGw=" | base64 -d) ; TMP="$HOME/.3" ; export TZ=Europe/Warsaw LANG=pl.UTF-8 ; ALLIES="_WORK" ;;

			(4) URL=$(echo "dGl0YW5lbi5tb2Jp" | base64 -d) ; TMP="$HOME/.4" ; export TZ=Europe/Berlin LANG=de.UTF-8 ; ALLIES="_WORK" ;;

			(5) URL=$(echo "Z3VlcnJhZGV0aXRhbmVzLm5ldA==" | base64 -d) ; TMP="$HOME/.5" ; export TZ=America/Cancun LANG=es-MX.UTF-8 ;  ALLIES="_WORK" ;;

			(6|fu) URL=$(echo "ZnVyaWFkZXRpdGFzLm5ldA==" | base64 -d) ; TMP="$HOME/.6" ; export TZ=America/Bahia LANG=pt-BR.UTF-8 ;ALLIES="_WORK" ;;

			(7) URL=$(echo "Z3VlcnJhZGl0aXRhbmkubmV0" | base64 -d) ; TMP="$HOME/.7" ; export TZ=Europe/Rome LANG=it.UTF-8 ; ALLIES="_WORK" ;;

			(8|fr) URL=$(echo "dGl3YXIuZnI=" | base64 -d) ; TMP="$HOME/.8" ; export TZ=Europe/Paris LANG=fr-FR.UTF-8 ; ALLIES="_WORK" ;;

			(9|ro) URL=$(echo "dGl3YXIucm8=" | base64 -d) ; TMP="$HOME/.9" ; export TZ=Europe/Bucharest LANG=ro.UTF-8 ; ALLIES="_WORK" ;;

#			(10|cn) _one ;;

#			(11|ba) _one ;;

			(0|c|C) kill -9 $$ ;;

			(*) clear; [[ -n $UR ]] && echo -e "\n Invalid option: $(echo $UR)" && kill -9 $$ || echo -e "\n Time exceeded!" ;;
		esac
	fi
	clear
	[[ -z $URL ]] && exit
# /tmp dir
	mkdir -p $TMP
# /termux on android
	cd $TMP
	termux-wake-lock &> /dev/null
	[[ $? = 0 ]] && {
		[[ ! -e executed.txt ]] && pkg install termux-api w3m dos2unix dnsutils -y && >executed.txt
# _sync - to disable coment #
		[[ $(date +%H) < 10 || $(date +%H) > 22 ]] && . $HOME/easyinstall.sh ;
		mkdir -p ~/.termux/boot
		ln -s ~/twm/PLAY.sh ~/.termux/boot/PLAY.sh &> /dev/null
		chmod a+x ~/.termux/boot/PLAY.sh
		reset; clear
		echo -e "Successful updates!\n"
	} || {
		sudo apt install w3m dos2unix dnsutils -y
		[[ $(date +%H) -lt 10 || $(date +%H) -gt 22 ]] && . $HOME/easyinstall.sh ;
		reset; clear
	}
# /user agents to $TMP/.ua
	_userAgent () {
		cd $TMP
 		echo -e '"Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.2.2339 Mobile Safari/537.35+"\n"Mozilla/5.0 (Linux; U; Android 4.3; en-us; ZTE-Z667G Build/JLS36C) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"\n"Mozilla/5.0 (Mobile; rv:32.0) Gecko/32.0 Firefox/32.0"\n"Mozilla/5.0 (Android; Linux armv7l; rv:5.0) Gecko/20110615 Firefox/5.0 Fennec/5.0"' >$TMP/.ua
		sed -i 's,\",,g' $TMP/.ua
		clear
		echo -e ""$ww_" Simulate your real or random device. \e[00m\n1)"$ww_" Mannualy (Recommended) \e[00m\n2)"$ww_" Automatic \e[00m"
		read -p "Set up User-Agent[1 to 2]: " -t 300 -e -n 1 UA
		case $UA in

			(1) clear; xdg-open $(echo "aHR0cHM6Ly93d3cud2hhdHNteXVhLmluZm8=" | base64 -d) ; read -p "Copy and paste your User Agent here and tip ENTER: " -t 900 -e -n 250 UA && echo "$UA" >$TMP/.ua ;;

			(2) echo -e ""$pp_"" ; echo -e "User-Agent: $(cat $TMP/.ua)" ; echo -e "\e[00m" ;;

			(*) clear; [[ -n $UA ]] && echo -e "\n Invalid option: $(echo $UA)" && kill -9 $$ || echo -e "\n Time exceeded!" ;;
		esac
		unset UA
	}
	[[ ! -e $TMP/.ua || $(cat $TMP/.ua | wc -c) -lt 10 || $(cat $TMP/.ua | wc -c) -gt 300 ]] && {
		_userAgent
	} || {
		echo -e ""$pp_"" ; echo -e "User-Agent: $(shuf -n 1 $TMP/.ua)" ; echo -e "\e[00m"
	}
	dos2unix $TMP/.ua &> /dev/null
	killall -q -9 w3m
	unset UR
}
