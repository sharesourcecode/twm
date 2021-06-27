# /arena
_openChest () {
	echo $($SOURCE  "$URL/quest" -o user_agent="$(shuf -n1 .ua)") >SRC &
	sleep 2
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep 'quest/openChest' | head -n1 | awk -F\' '{ print $2 }')
	while [[ -n $ACCESS ]]; do
		echo $ACCESS
		echo $($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
		sleep 2
		ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep 'quest/openChest' | head -n1 | awk -F\' '{ print $2 }')
	done
	unset ACCESS
	echo -e "openChest (✔)\n"
	killall -q -9 w3m
}
_colifight () {
	echo $($SOURCE "$URL/collfight/enterFight" -o user_agent="$(shuf -n1 .ua)") >SRC &
	sleep 2
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep 'collfight/take' | head -n1 | awk -F\' '{ print $2 }') #/arena/attack/1/1234567*/
	$SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
	sleep 2
	$SOURCE "$URL/collfight/enterFight" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
	sleep 2
	unset ACCESS
	killall -q -9 w3m
}
_AtakeHelp () {
	_clanid
	if [[ -n $CLD ]]; then
		$DUMP "$URL/clan/$CLD/quest/take/3" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		echo "/clan/$CLD/quest/take/3" ; sleep 2
		$DUMP "$URL/clan/$CLD/quest/help/3" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		echo "/clan/$CLD/quest/help/3" ; sleep 2
		$DUMP "$URL/clan/$CLD/quest/take/4" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		echo "/clan/$CLD/quest/take/4" ; sleep 2
		$DUMP "$URL/clan/$CLD/quest/help/4" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		echo "/clan/$CLD/quest/help/4" ; sleep 2
		killall -q -9 w3m
	fi
	unset CLD
}
_AdeleteEnd () {
	_clanid
	if [[ -n $CLD ]]; then
		$DUMP "$URL/clan/$CLD/quest/deleteHelp/3" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		echo "/clan/$CLD/quest/deleteHelp/3" ; sleep 2
		$DUMP "$URL/clan/$CLD/quest/end/3" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		echo "/clan/$CLD/quest/end/3" ; sleep 2
		$DUMP "$URL/clan/$CLD/quest/deleteHelp/4" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		echo "/clan/$CLD/quest/deleteHelp/4" ; sleep 2
		$DUMP "$URL/clan/$CLD/quest/end/4" -o user_agent="$(shuf -n1 .ua)" | tail -n0 &
		echo "/clan/$CLD/quest/end/4" ; sleep 2
		killall -q -9 w3m
	fi
	unset CLD
}
_arena () {
	echo "arena ..."
	_AtakeHelp
	echo $($SOURCE "$URL/arena/" -o user_agent="$(shuf -n1 .ua)") >SRC &
	sleep 2
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep 'arena/attack' | head -n1 | awk -F\' '{ print $2 }') #/arena/attack/1/1234567*/
	EXIT=$(cat SRC | sed 's/href=/\n/g' | grep 'lab/wizard' | head -n1 | awk -F\' '{ print $2 }') #/lab/wizard/potion/1234567*/?ref=/arena/
	while [[ -z $EXIT && -n $ACCESS ]]; do
		echo $($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
		sleep 2
		ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep 'arena/attack' | head -n1 | awk -F\' '{ print $2 }') #/arena/attack/1/1234567*/
		echo "$ACCESS"
		EXIT=$(cat SRC | sed 's/href=/\n/g' | grep 'lab/wizard' | head -n1 | awk -F\' '{ print $2 }') #/lab/wizard/potion/1234567*/?ref=/arena/
	done
	killall -q -9 w3m
	unset ACCESS EXIT
	_AdeleteEnd
	echo -e "arena (✔)\n"
}
_fullmana () {
	echo $($SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]") >ARENA &
	sleep 2
	echo " ⚔ - 1 Attack..."
	echo $($SOURCE "$URL/arena/attack/1/?r=`cat ARENA`" -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "arena/lastPlayer" | head -n1 | awk -F\' '{ print $1 }' | tr -cd "[[:digit:]]") >ATK1 &
	sleep 2
	echo " ⚔ - Full Attack..."
	$DUMP "$URL/arena/lastPlayer/?r=`cat ATK1`&fullmana=true" -o user_agent="$(shuf -n1 .ua)" | head -n5 | tail -n4 &
	sleep 2
	killall -q -9 w3m
}
