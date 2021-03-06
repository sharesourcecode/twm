_members () {
	cd $TMP
	echo "VWVsaXRvbgo=" | base64 -d >>allies.txt
	_clanid
	[[ -n $CLD ]] && {
		echo -e ""$ww_"\nUpdating clan members into allies\n\e[00m"
		for num in `seq 5 -1 1`; do
			echo -e ""$b__"/clan/$CLD/$num\e[00m"
			$SOURCE "$URL/clan/$CLD/$num" -o user_agent="$(shuf -n1 .ua)" | grep -oP "/>\p{Lu}{1}\p{Ll}{0,15}[\ ]{0,1}\p{L}{0,14}, <s" | awk -F"[>]" '{print $2}' | awk -F"[,]" '{print $1}' | sed 's,\ ,_,' >>allies.txt &
			sleep 5
			killall -q -9 w3m
		done
		sort -u allies.txt -o allies.txt
	}
# Print info
	echo -e ""$ww_"\nAllies for Coliseum and King of the Immortals:\n\e[00m"
	cat allies.txt
	echo -e ""$ww_"Wait to continue.  👈\e[00m"
	sleep 10
}
_alliesID () {
# Friends ID
	echo -e ""$ww_"Looking for allies on friends list\e[00m"
	cd $TMP
	echo -e ""$b__"/mail/friends\e[00m"
	echo $($SOURCE "$URL/mail/friends" -o user_agent="$(shuf -n1 .ua)") >SRC &
	sleep 5
	NPG=$(cat SRC | sed 's/href=/\n/g' | grep "/mail/friends/[0-9]'>&#62;&#62;" | cut -d\' -f2 | cut -d\/ -f4)
	>tmp.txt
	[[ -z $NPG ]] && {
		echo -e ""$b__"/mail/friends\e[00m"
		$SOURCE "$URL/mail/friends" -o user_agent="$(shuf -n1 .ua)" | sed 's,/user/,\n/user/,g' |  grep "/user/" | grep "/mail/" | cut -d\< -f1 >>tmp.txt &
		sleep 5
	} || {
		for num in `seq $NPG -1 1`; do
			echo -e ""$ww_"Friends list page $num\e[00m\n"$b__"/mail/friends/$num\e[00m";
			$SOURCE "$URL/mail/friends/$num" -o user_agent="$(shuf -n1 .ua)" | sed 's,/user/,\n/user/,g' | grep "/user/" | grep "/mail/" | cut -d\< -f1 >>tmp.txt &
			sleep 5
			killall -q -9 w3m
		done
	}
	sort -u tmp.txt -o tmp.txt
	cat tmp.txt | cut -d\> -f2 | sed 's,\ ,_,' >allies.txt
	killall -q -9 w3m
}
_calliesID () {
# Clan ID by Leader/Deputy on friend list
	_clanid
	[[ -n $CLD ]] && {
		cd $TMP
		echo "QmFja2dyb3VuZF9Qcm9jZXNzCg==" | base64 -d >callies.txt
		cat tmp.txt | cut -d/ -f3 >ids.txt
		echo -e ""$ww_"\nClan allies by Leader/Deputy on friends list\n\e[00m"
		#loop conf
		Lnl=$(cat ids.txt | wc -l)
		nl=1
		ts=0
		for num in `seq $Lnl -1 $nl`;
		do
			IDN=$(cat ids.txt | tail -n $Lnl | head -n 1)
#		while read IDN; do
			[[ -n $IDN ]] && {
				echo -e "$Lnl "$b__"/user/$IDN\e[00m"
				echo $($SOURCE "$URL/user/$IDN" -o user_agent="$(shuf -n1 .ua)") >SRC &
				sleep 5
				LEADPU=$(cat SRC | sed 's,/clan/,\n/clan/,g' |  grep -E "</a>, <span class='blue'|</a>, <span class='green'" | cut -d\< -f1 |cut -d\> -f2)
				alCLAN=$(cat SRC | grep -E -o '/clan/[0-9]{1,3}' | tail -n1)
				echo -e ""$bi_" $LEADPU - $alCLAN\e[00m"
				[[ -n $LEADPU ]] && {
					ts=$[$ts+1]
					echo $LEADPU | sed 's,\ ,_,' >>callies.txt
					echo -e ""$ww_" $ts. Ally $LEADPU $alCLAN added.\e[00m"
					sort -u callies.txt -o callies.txt
				}
				Lnl=$[$Lnl-1]
			}
			killall -q -9 w3m
#		done < ids.txt
		done
	}
}
_alliesConf () {
	curl -s -L https://raw.githubusercontent.com/sharesourcecode/twm/master/allies.sh | cmp -s --bytes $((100 * 1024 * 1024)) $HOME/twm/allies.sh || echo -e " There is a new update for allies.sh,\nuse bash easyinstall.sh to update this script."
	cd $TMP
	clear
	echo -e ""$ww_"\nThe script will consider users on your friends list and \nClan as allies.\nLeader/Deputy on friend list will add \nClan allies.\n\e[00m\n1) Add/Update alliances(All Battles)\n\n2) Add/Update just Herois alliances(Coliseum/King of immortals)\n\n3) Add/Update just Clan alliances(Altars,Clan Coliseum and Clan Fight)\n\n4) Do nothing\n"
	read -p "Set up alliances[1 to 4]: " -t 300 -e -n 1 AL
	case $AL in
		(1) _alliesID; _calliesID; _members; ALD=1; echo "Alliances on all battles active" ;;

		(2) _alliesID; _members; [[ -e $TMP/callies.txt ]] && >$TMP/callies.txt; ALD=1; echo "Just Herois alliances now." ;;

		(3) _alliesID; _calliesID; [[ -e $TMP/allies.txt ]] && >$TMP/allies.txt; unset ALD; echo "Just Clan alliances now." ;;

		(4) echo "Nothing changed."; ALD=1; >>allies.txt; >>callies.txt ;;

		(*) clear; [[ -n $AL ]] && echo -e "\n Invalid option: $(echo $AL)" && kill -9 $$ || echo -e "\n Time exceeded!" ;;
	esac
	unset ts IDN LEADPU alCLA AL NPG
}
