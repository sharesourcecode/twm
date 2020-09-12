_requeriments () {
# /tmp dir
	mkdir -p $HOME/.tmp
# /update script and dependencies
	echo -e "\n Upgrading..."
	echo -e "👉 Please wait...☕👴"
	_sync () {
		cd $HOME/twm

		curl https://github.com/DemonBloody/twm/raw/master/cave.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 1/20"
		curl https://github.com/DemonBloody/twm/raw/master/PLAY.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 2/20"
		curl https://github.com/DemonBloody/twm/raw/master/altars.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 3/20"
		curl https://github.com/DemonBloody/twm/raw/master/arena.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 4/20"
		curl https://github.com/DemonBloody/twm/raw/master/campaign.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 5/20"
		curl https://github.com/DemonBloody/twm/raw/master/career.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 6/20"
		curl https://github.com/DemonBloody/twm/raw/master/clancoliseum.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 7/20"
		curl https://github.com/DemonBloody/twm/raw/master/clandungeon.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 8/20"
		curl https://github.com/DemonBloody/twm/raw/master/clanfight.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 9/20"
		curl https://github.com/DemonBloody/twm/raw/master/clanid.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 10/20"
		curl https://github.com/DemonBloody/twm/raw/master/coliseum.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 11/20"
		curl https://github.com/DemonBloody/twm/raw/master/crono.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 12/20"
		curl https://github.com/DemonBloody/twm/raw/master/king.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 13/20"
		curl https://github.com/DemonBloody/twm/raw/master/loginlogoff.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 14/20"
		curl https://github.com/DemonBloody/twm/raw/master/play.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 15/20"
		curl https://github.com/DemonBloody/twm/raw/master/requeriments.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 16/20"
		curl https://github.com/DemonBloody/twm/raw/master/trade.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 17/20"
		curl https://github.com/DemonBloody/twm/raw/master/undying.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 18/20"
		curl https://github.com/DemonBloody/twm/raw/master/flagfight.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 19/20"
		curl https://github.com/DemonBloody/twm/raw/master/allies.sh -O -L &> /dev/null ;
		curl https://github.com/sharesourcecode/twm/raw/master/cave.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 1/20"
		curl https://github.com/sharesourcecode/twm/raw/master/PLAY.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 2/20"
		curl https://github.com/sharesourcecode/twm/raw/master/altars.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 3/20"
		curl https://github.com/sharesourcecode/twm/raw/master/arena.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 4/20"
		curl https://github.com/sharesourcecode/twm/raw/master/campaign.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 5/20"
		curl https://github.com/sharesourcecode/twm/raw/master/career.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 6/20"
		curl https://github.com/sharesourcecode/twm/raw/master/clancoliseum.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 7/20"
		curl https://github.com/sharesourcecode/twm/raw/master/clandungeon.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 8/20"
		curl https://github.com/sharesourcecode/twm/raw/master/clanfight.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 9/20"
		curl https://github.com/sharesourcecode/twm/raw/master/clanid.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 10/20"
		curl https://github.com/sharesourcecode/twm/raw/master/coliseum.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 11/20"
		curl https://github.com/sharesourcecode/twm/raw/master/crono.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 12/20"
		curl https://github.com/sharesourcecode/twm/raw/master/king.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 13/20"		curl https://github.com/sharesourcecode/twm/raw/master/loginlogoff.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 14/20"
		curl https://github.com/sharesourcecode/twm/raw/master/play.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 15/20"
		curl https://github.com/sharesourcecode/twm/raw/master/requeriments.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 16/20"
		curl https://github.com/sharesourcecode/twm/raw/master/trade.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 17/20"
		curl https://github.com/sharesourcecode/twm/raw/master/undying.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 18/20"
		curl https://github.com/sharesourcecode/twm/raw/master/flagfight.sh -O -L &> /dev/null ;
		echo -e "\n Upgrading 19/20"
		curl https://github.com/sharesourcecode/twm/raw/master/allies.sh -O -L &> /dev/null ;

		echo -e "\n Upgrading 20/20"
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
	>$HOME/.tmp/.ua
_userAgent () {
	cd $HOME/.tmp
	echo -e '"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/600.7.12 (KHTML, like Gecko) Version/8.0.7 Safari/600.7.12"\n"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/600.8.9 (KHTML, like Gecko) Version/8.0.8 Safari/600.8.9"\n"Mozilla/5.0 (iPhone; CPU iPhone OS 8_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) CriOS/44.0.2403.67 Mobile/12D508 Safari/600.1.4"\n"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.1; rv:38.0) Gecko/20100101 Firefox/38.0"\n"Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36"\n"Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.10240"\n"Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.65 Safari/537.36"\n"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/42.0 Safari/537.31"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; rv:39.0) Gecko/20100101 Firefox/39.0"\n"Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.59.10 (KHTML, like Gecko) Version/5.1.9 Safari/534.59.10"\n"Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)"\n"Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0)"\n"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) coc_coc_browser/50.0.125 Chrome/44.0.2403.125 Safari/537.36"\n"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)"\n"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0"\n"Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36 Edge/12.0"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0"\n"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; GTB7.5; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C)"\n"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.10240"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0) LinkCheck by Siteimprove.com"\n"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.65 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.3; Win64; x64; Trident/7.0; rv:11.0) like Gecko"\n"Moziqlla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4"\n"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:39.0) Gecko/20100101 Firefox/39.0"\n"Mozilla/5.0 (Windows NT 6.2; WOW64; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36"\n"Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.2.2339 Mobile Safari/537.35+"\n"Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.65 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/5.0 (Windows NT 10.0; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:40.0) Gecko/20100101 Firefox/40.0"\n"Mozilla/5.0 (Mobile; Windows Phone 8.1; Android 4.0; ARM; Trident/7.0; Touch; rv:11.0; IEMobile/11.0; NOKIA; Lumia 525) like iPhone OS 7_0_3 Mac OS X AppleWebKit/537 (KHTML, like Gecko) Mobile Safari/537"\n"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:37.0) Gecko/20100101 Firefox/37.0"\n"Mozilla/5.0 (Windows NT 5.1; WOW64; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/44.0.2403.89 Chrome/44.0.2403.89 Safari/537.36"\n"Mozilla/5.0 (iPad; CPU OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10) AppleWebKit/600.1.25 (KHTML, like Gecko) QuickLook/5.0"\n"Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:40.0) Gecko/20100101 Firefox/40.0"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; MATBJS; rv:11.0) like Gecko"\n"Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36"\n"Mozilla/5.0 (Windows NT 10.0; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"\n"Mozilla/5.0 (Windows NT 6.0; WOW64; rv:35.0) Gecko/20100101 Firefox/35.0"\n"Mozilla/5.0 (Linux; U; Android 4.3; en-us; ZTE-Z667G Build/JLS36C) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"\n"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; Touch; ASU2JS; rv:11.0) like Gecko"\n"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0"\n"Mozilla/5.0 (Windows NT 6.0; WOW64; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/5.0 (Windows NT 5.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.65 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.65 Safari/537.36"\n"Mozilla/5.0 (iPad; CPU OS 8_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12F69 Safari/600.1.4"\n"Mozilla/5.0 (Windows NT 6.0; WOW64; rv:39.0) Gecko/20100101 Firefox/39.0"\n"Mozilla/5.0 (iPhone; CPU iPhone OS 8_4_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H321 Safari/600.1.4"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; TNJB; rv:11.0) like Gecko"\n"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0"\n"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; InfoPath.2)"\n"Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko"\n"Mozilla/5.0 (iPad; CPU OS 7_1_2 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D257 Safari/9537.53"\n"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36"\n"Mozilla/5.0 (iPhone; CPU iPhone OS 8_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12F70 Safari/600.1.4"\n"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) coc_coc_browser/50.2.155 Chrome/44.2.2403.155 Safari/537.36"\n"Mozilla/5.0 (X11; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0"\n"Mozilla/5.0 (iPad; CPU OS 8_4_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H321 Safari/600.1.4"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:35.0) Gecko/20100101 Firefox/35.0"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.78.2 (KHTML, like Gecko) Version/6.1.6 Safari/537.78.2"\n"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.130 Safari/537.36"\n"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0"\n"Mozilla/5.0 (Mobile; rv:32.0) Gecko/32.0 Firefox/32.0"\n"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.2; WOW64; Trident/7.0; .NET4.0E; .NET4.0C; .NET CLR 3.5.30729; .NET CLR 2.0.50727; .NET CLR 3.0.30729; Tablet PC 2.0; McAfee; AmericasCardroom; BRI/2; GWX:DOWNLOADED)"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.155 Safari/537.36"\n"Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/7.0)"\n"Mozilla/5.0 (iPad; CPU OS 8_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12D508 Safari/600.1.4"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2483.0 Safari/537.36"\n"Mozilla/5.0 (Windows NT 5.1; WOW64; rv:39.0) Gecko/20100101 Firefox/39.0"\n"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/6.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.3; .NET4.0C; .NET4.0E; MS-RTC LM 8)"\n"Mozilla/5.0 (Android; Linux armv7l; rv:5.0) Gecko/20110615 Firefox/5.0 Fennec/5.0"\n"Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12B466 [FBAN/FBIOS;FBAV/37.0.0.21.273;FBBV/13822349;FBDV/iPhone6,1;FBMD/iPhone;FBSN/iPhone OS;FBSV/8.1.3;FBSS/2; FBCR/fido;FBID/phone;FBLC/fr_FR;FBOP/5]"\n"Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:40.0) Gecko/20100101 Firefox/40.0 Cyberfox/40.0"\n"Mozilla/5.0 (iPad; CPU OS 7_0_4 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Mercury/8.7 Mobile/11B554a Safari/9537.53"\n"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.3; WOW64; Trident/7.0; .NET4.0E; .NET4.0C; .NET CLR 3.5.30729; .NET CLR 2.0.50727; .NET CLR 3.0.30729; GWX:QUALIFIED; MASMJS)"\n"Mozilla/5.0 (iPhone; CPU iPhone OS 7_1 like Mac OS X) AppleWebKit (KHTML, like Gecko) Mobile (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)"\n"Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; NP06; rv:11.0) like Gecko"\n"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.3; ARM; Trident/7.0; Touch; .NET4.0E; .NET4.0C; Tablet PC 2.0)"\n"Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.0.19) Gecko/2010062819 Firefox/3.0.19 Flock/2.6.1"\n"Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"\n"Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; Touch; rv:11.0) like Gecko"\n"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)"\n"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10) AppleWebKit/600.1.25 (KHTML, like Gecko) Version/8.0 Safari/600.1.25"\n"Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36"' >.ua
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
	if [[ -z $URL ]] ; then
		echo -e " 1) 🇬🇧 English, Global: Titan's War online\n 2) 🇷🇺 Русский: Битва Титанов онлайн\n 3) 🇵🇱 Polski: Wojna Tytanów online\n 4) 🇩🇪 Deutsch: Krieg der Titanen online\n 5) 🇪🇸 Español: Guerra de Titanes online\n 6) 🇧🇷 Brazil, 🇵🇹 Português: Furia de Titãs online\n 7) 🇮🇹 Italiano: Guerra di Titani online\n 8) 🇫🇷 Français: Combat des Titans online\n 9) 🇷🇴 Română: Războiul Titanilor online\n10) 🇨🇳 中文, Chinese: 泰坦之战\n11) 🇮🇩 Indonesian: Titan's War Indonesia\n0) ❌ Cancel\n"
		read -p "Select number Server[1 to 11]: " -t 300 -e -n 2 UR
		case $UR in
			(1) URL='tiwar.net' ; export TZ=Europe/London ; ALLIES="_WORK" ;;

			(2|ru) URL='tiwar.ru' ; export TZ=Europe/Moscow ;;

			(3|pl) URL='tiwar.pl' ; export TZ=Europe/Warsaw ;;

			(4) URL='titanen.mobi' ; export TZ=Europe/Berlin ;;

			(5) URL='guerradetitanes.net' ; export TZ=America/Cancun ; ALLIES="_WORK" ;;

			(6|fu) URL='furiadetitas.net' ; export TZ=America/Bahia ; ALLIES="_WORK" ;;

			(7) URL='guerradititani.net' ; export TZ=Europe/Rome ; ALLIES="_WORK" ;;

			(8|fr) URL='tiwar.fr' ; export TZ=Europe/Paris ; ALLIES="_WORK" ;;

			(9|ro) URL='tiwar.ro' ; export TZ=Europe/Bucharest ; ALLIES="_WORK";;

			(10|cn) URL='cn.tiwar.net' ; export TZ=Asia/Shanghai ;;

			(11|ba) URL='bahasa.tiwar.net' ; export TZ=Asia/Barnaul ; ALLIES="_WORK";;

			(0) kill -9 $$ ;;

			(*) clear; [[ -n $UR ]] && echo -e "\n Invalid option: $(echo $UR)" && kill -9 $$ || echo -e "\n Time exceeded!" ;;
		esac
	fi
	unset UR; clear
	[[ -z $URL ]] && exit
}
