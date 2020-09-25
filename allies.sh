_members () {
	cd $TMP
	echo "Ilililililililil" >>allies.txt
	_clanid
	[[ -n $CLD ]] && {
	echo -e "\nUpdating clan members into allies..."
	for num in `seq 5 -1 1`; do $SOURCE -o accept_encoding=="*;q=0" "$URL/clan/$CLD/$num" -o user_agent="$(shuf -n1 .ua)" | grep -oP "/>\p{Lu}{1}\p{Ll}{0,15}[\ ]{0,1}\p{L}{0,14}, <s" | awk -F"[>]" '{print $2}' | awk -F"[,]" '{print $1}' | sed 's,\ ,_,' >>allies.txt; done
	sort -u allies.txt -o allies.txt
	}
# Print info
	echo -ne "\033[33m"; echo "Allies for Coliseum and King of the Immortals:"
	cat allies.txt
	echo -ne "\033[37m"
	echo "Look UP↑ or wait to continue.  👈"
	sleep 3
}
_alliesID () {
# Friends ID
	cd $TMP
	SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/mail/friends" -o user_agent="$(shuf -n1 .ua)")
	NPG=$(echo $SRC | sed 's/href=/\n/g' | grep "/mail/friends/[0-9]'>&#62;&#62;" | cut -d\' -f2 | cut -d\/ -f4)
	>tmp.txt; echo -ne "\033[33m"
	if [[ -z $NPG ]] ; then
		$SOURCE -o accept_encoding=="*;q=0" "$URL/mail/friends" -o user_agent="$(shuf -n1 .ua)" | sed 's,/user/,\n/user/,g' |  grep "/user/" | grep "/mail/" | cut -d\< -f1 >>tmp.txt; echo "Looking for allies on friend list..."
	else
		for num in `seq $NPG -1 1`; do $SOURCE -o accept_encoding=="*;q=0" "$URL/mail/friends/$num" -o user_agent="$(shuf -n1 .ua)" | sed 's,/user/,\n/user/,g' | grep "/user/" | grep "/mail/" | cut -d\< -f1 >>tmp.txt; echo "Looking for allies on friend list page $num..."; done
	fi
	sort -u tmp.txt -o tmp.txt
	cat tmp.txt | cut -d\> -f2 | sed 's,\ ,_,' >allies.txt
}
_calliesID () {
# Clan ID by Leader/Deputy on friend list
	_clanid
	[[ -n $CLD ]] && {
	cd $TMP
	ts=0
	echo "Ilililililililililil" >callies.txt; echo -ne "\033[36m"
	cat tmp.txt | cut -d/ -f3 >ids.txt
	echo "Clan allies by Leader/Deputy on friends list..."
	while read IDN; do
		if [[ -n $IDN ]]; then
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/user/$IDN" -o user_agent="$(shuf -n1 .ua)")
			LEADPU=$(echo $SRC | sed 's,/clan/,\n/clan/,g' |  grep -E "</a>, <span class='blue'|</a>, <span class='green'" | cut -d\< -f1 |cut -d\> -f2)
			alCLAN=$(echo $SRC | grep -E -o '/clan/[0-9]{1,3}' | tail -n1)
			[[ -n $LEADPU ]] && {
			ts=$[$ts+1]
			echo $LEADPU | sed 's,\ ,_,' >>callies.txt
			echo "$ts. Ally $LEADPU $alCLAN added."
			sort -u callies.txt -o callies.txt
			}
		fi
	done < ids.txt
	}
}
_alliesConf () {
	cd $TMP
	clear
	echo -e "The script will consider users on your friends list and you Clan as allies, Leader/Deputy on friend list will add Clan allies."
	echo -e "\n1) Add/Update alliances(All Battles)\n\n2) Add/Update just Herois alliances(Coliseum/King of immortals\n\n3) Add/Update just Clan alliances(Altars,Clan Coliseum,Clan Fight and Flagfight)\n\n4) Do nothing\n"
	read -p "Set up alliances[1 to 4]: " -t 300 -e -n 1 AL
	case $AL in
		(1) _alliesID; _calliesID; _members; ALD=1; echo "Alliances on all battles active" ;;

		(2) _alliesID; _members; [[ -e $TMP/callies.txt ]] && >$TMP/callies.txt; ALD=1; echo "Just Herois alliances now." ;;

		(3) _alliesID; _calliesID; [[ -e $TMP/allies.txt ]] && >$TMP/allies.txt; unset ALD; echo "Just Clan alliances now." ;;

		(4) echo "Nothing changed."; ALD=1; >>allies.txt; >>callies.txt ;;

		(*) clear; [[ -n $AL ]] && echo -e "\n Invalid option: $(echo $AL)" && kill -9 $$ || echo -e "\n Time exceeded!" ;;
	esac
	unset ts IDN SRC LEADPU alCLA AL SRC NPG
}
