# /career
# /career/attack/?r=8781779
_career () {
	echo "Career..."
	_clanid
	if [[ -n $CLD ]]; then
		$PAGE "$URL/clan/$CLD/quest/take/6" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		echo "/clan/$CLD/quest/take/6" ; sleep 2
		$PAGE "$URL/clan/$CLD/quest/help/6" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		echo "/clan/$CLD/quest/help/6" ; sleep 3
		killall -q -9 w3m
	fi
	echo "/career"
	echo $($SOURCE "$URL/career" -o user_agent="$(shuf -n1 .ua)") >SRC &
	sleep 3
	ENTER=$(cat SRC | sed 's/href=/\n/g' | grep -o 'career/attack')
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/career/attack/' | head -n1 | awk -F\' '{ print $2 }')
	until [[ -z $ENTER ]]; do
		echo " ⚔ $ACCESS"
		echo $($SOURCE "$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
		sleep 3
		ENTER=$(cat SRC | sed 's/href=/\n/g' | grep -o 'career/attack')
		ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/career/attack/' | head -n1 | awk -F\' '{ print $2 }')
		killall -q -9 w3m
	done
	if [[ -n $CLD ]]; then
		$PAGE "$URL/clan/$CLD/quest/deleteHelp/6" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		echo "/clan/$CLD/quest/deleteHelp/6" ; sleep 2
		$PAGE "$URL/clan/$CLD/quest/end/6" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		echo "/clan/$CLD/quest/end/6" ; sleep 3
		killall -q -9 w3m
	fi
	unset CLD ENTER ACCESS
	echo -e "career (✔)\n" ; sleep 5
}
