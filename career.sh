# /career
# /career/attack/?r=8781779
_career () {
	echo "Checking career..."
	_clanid
	if [[ -n $CLD ]]; then
		echo "Clan ID: $CLD"
		$PAGE "$URL/clan/$CLD/quest/take/6" -o user_agent="$(shuf -n1 .ua)" | head -n4 | tail -n3 &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
		$PAGE "$URL/clan/$CLD/quest/help/6" -o user_agent="$(shuf -n1 .ua)" | head -n4 | tail -n3 &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
	fi
	echo $($SOURCE "$URL/career" -o user_agent="$(shuf -n1 .ua)") >SRC &
	x=$! ; sleep 3 && kill -9 $x &> /dev/null
	ENTER=$(cat SRC | sed 's/href=/\n/g' | grep -o 'career/attack')
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/career/attack/' | head -n1 | awk -F\' '{ print $2 }')
	until [[ -z $ENTER ]]; do
		echo $($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
		ENTER=$(cat SRC | sed 's/href=/\n/g' | grep -o 'career/attack')
		ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/career/attack/' | head -n1 | awk -F\' '{ print $2 }')
		echo " ⚔ $ACCESS"
	done
	if [[ -n $CLD ]]; then
		$PAGE "$URL/clan/$CLD/quest/deleteHelp/6" -o user_agent="$(shuf -n1 .ua)" | head -n4 | tail -n3 &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
		$PAGE "$URL/clan/$CLD/quest/end/6" -o user_agent="$(shuf -n1 .ua)" | head -n4 | tail -n3 & 
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
	fi
	unset CLD ENTER ACCESS
	echo -e "career (✔)\n"
}
