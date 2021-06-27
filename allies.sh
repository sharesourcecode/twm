_members () {
	cd $TMP
	echo "Ilililililililil" >>allies.txt
	_clanid
	[[ -n $CLD ]] && {
	echo -e "\n________________________________________\nUpdating clan members into allies..."
	for num in `seq 5 -1 1`; do
		echo "/clan/$CLD/$num ..."
		$SOURCE "$URL/clan/$CLD/$num" -o user_agent="$(shuf -n1 .ua)" | grep -oP "/>\p{Lu}{1}\p{Ll}{0,15}[\ ]{0,1}\p{L}{0,14}, <s" | awk -F"[>]" '{print $2}' | awk -F"[,]" '{print $1}' | sed 's,\ ,_,' >>allies.txt &
		sleep 2
	done
	sleep 2
	sort -u allies.txt -o allies.txt
	killall -q -9 w3m
	}
# Print info
	echo -ne "\033[33m"; echo "Allies for Coliseum and King of the Immortals:"
	cat allies.txt
	echo -ne "\033[37m"
	echo "Wait to continue.  👈"
	sleep 5
}
_alliesID () {
# Friends ID
	echo -e "\n________________________________________\nLooking for allies on friends list..."
	cd $TMP
	echo "/mail/friends ..."
	echo $($SOURCE "$URL/mail/friends" -o user_agent="$(shuf -n1 .ua)") >SRC &
	sleep 2
	NPG=$(cat SRC | sed 's/href=/\n/g' | grep "/mail/friends/[0-9]'>&#62;&#62;" | cut -d\' -f2 | cut -d\/ -f4)
	>tmp.txt; echo -ne "\033[33m"
	if [[ -z $NPG ]] ; then
		echo "/mail/friends ..."
		$SOURCE "$URL/mail/friends" -o user_agent="$(shuf -n1 .ua)" | sed 's,/user/,\n/user/,g' |  grep "/user/" | grep "/mail/" | cut -d\< -f1 >>tmp.txt &
		sleep 2
	else
		for num in `seq $NPG -1 1`; do
			echo -e "Friends list page ...\n/mail/friends/$num";
			$SOURCE "$URL/mail/friends/$num" -o user_agent="$(shuf -n1 .ua)" | sed 's,/user/,\n/user/,g' | grep "/user/" | grep "/mail/" | cut -d\< -f1 >>tmp.txt &
			sleep 2
		done
	fi
	sleep 2
	sort -u tmp.txt -o tmp.txt
	cat tmp.txt | cut -d\> -f2 | sed 's,\ ,_,' >allies.txt
	killall -q -9 w3m
}
_calliesID () {
# Clan ID by Leader/Deputy on friend list
	_clanid
	[[ -n $CLD ]] && {
	cd $TMP
	ts=0
	echo "Ilililililililililil" >callies.txt; echo -ne "\033[36m"
	cat tmp.txt | cut -d/ -f3 >ids.txt
	echo -e "\n________________________________________\nClan allies by Leader/Deputy on friends list..."
	while read IDN; do
		if [[ -n $IDN ]]; then
			echo "/user/$IDN ..."
			echo $($SOURCE "$URL/user/$IDN" -o user_agent="$(shuf -n1 .ua)") >SRC &
			sleep 2
			LEADPU=$(cat SRC | sed 's,/clan/,\n/clan/,g' |  grep -E "</a>, <span class='blue'|</a>, <span class='green'" | cut -d\< -f1 |cut -d\> -f2)
			alCLAN=$(cat SRC | grep -E -o '/clan/[0-9]{1,3}' | tail -n1)
			echo "$LEADPU - $alCLAN"
			[[ -n $LEADPU ]] && {
			ts=$[$ts+1]
			echo $LEADPU | sed 's,\ ,_,' >>callies.txt
			echo -e "$ts. Ally $LEADPU $alCLAN added.\n_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
			sort -u callies.txt -o callies.txt
			}
		fi
		sleep 2
	done < ids.txt
	killall -q -9 w3m
	}
}
_alliesConf () {
	cd $TMP
	clear
	echo -e "The script will consider users on your friends list and Clan as allies, Leader/Deputy on friend list will add Clan allies.\n"
	echo -e "\n1) Add/Update alliances(All Battles)\n\n2) Add/Update just Herois alliances(Coliseum/King of immortals)\n\n3) Add/Update just Clan alliances(Altars,Clan Coliseum and Clan Fight)\n\n4) Do nothing\n"
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
