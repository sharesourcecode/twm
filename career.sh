# /career
# /career/attack/?r=8781779
_career () {
	echo "Career..."
	_clanid
	if [[ -n $CLD ]]; then
		$PAGE "$URL/clan/$CLD/quest/take/6" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		x1=$! &> /dev/null ; echo "$URL/clan/$CLD/quest/take/6" ; sleep 2
		$PAGE "$URL/clan/$CLD/quest/help/6" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		x2=$! &> /dev/null ; echo "$URL/clan/$CLD/quest/help/6" ; sleep 3
		kill -9 $x1 $x2 &> /dev/null
	fi
	echo "$URL/career"
	echo $($SOURCE "$URL/career" -o user_agent="$(shuf -n1 .ua)") >SRC &
	x=$! &> /dev/null ; sleep 3
	ENTER=$(cat SRC | sed 's/href=/\n/g' | grep -o 'career/attack')
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/career/attack/' | head -n1 | awk -F\' '{ print $2 }')
	kill -9 $x &> /dev/null
	until [[ -z $ENTER ]]; do
		echo " ⚔ $URL$ACCESS"
		echo $($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
		x=$! &> /dev/null ; sleep 3
		ENTER=$(cat SRC | sed 's/href=/\n/g' | grep -o 'career/attack')
		ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/career/attack/' | head -n1 | awk -F\' '{ print $2 }')
		kill -9 $x &> /dev/null
	done
	if [[ -n $CLD ]]; then
		$PAGE "$URL/clan/$CLD/quest/deleteHelp/6" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		x1=$! &> /dev/null ; echo "$URL/clan/$CLD/quest/deleteHelp/6" ; sleep 2
		$PAGE "$URL/clan/$CLD/quest/end/6" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		x2=$! &> /dev/null ; echo "$URL/clan/$CLD/quest/end/6" ; sleep 3
		kill -9 $x1 $x2 &> /dev/null
	fi
	unset CLD ENTER ACCESS
	echo -e "career (✔)\n" ; sleep 5
}
