# /career
# /career/attack/?r=8781779
_career () {
	echo "Checking career..."
	_clanid
#	if [[ -n $CLD ]]; then
#		echo "Clan ID: $CLD"
#		$PAGE "$URL/clan/$CLD/quest/take/6" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
#		$PAGE "$URL/clan/$CLD/quest/help/6" -o user_agent="$(shuf -n1 .ua)" | head -n15 &
#	fi
	SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/career" -o user_agent="$(shuf -n1 .ua)")
	ENTER=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'career/attack')
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/career/attack/' | head -n1 | awk -F\' '{ print $2 }')
	until [[ -z $ENTER ]]; do
		SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ENTER=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'career/attack')
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/career/attack/' | head -n1 | awk -F\' '{ print $2 }')
		echo " ⚔ $ACCESS"
	done
#	if [[ -n $CLD ]]; then
#		$PAGE "$URL/clan/$CLD/quest/deleteHelp/6" -o user_agent="$(shuf -n1 .ua)" | head -n15
#		$PAGE "$URL/clan/$CLD/quest/end/6" -o user_agent="$(shuf -n1 .ua)" | head -n15
#	fi
	unset CLD SRC ENTER ACCESS
	echo -e "career (✔)\n"
}
