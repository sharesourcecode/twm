_undying () {
	echo "undying"
# /clear bag
	$PAGE $URL/inv/bag/sellAll/1/ -o user_agent="$(shuf -n1 .ua)" | tail -n 0 &
	echo -e "/inv/bag/sellAll/1/"
	sleep 3
# /enterGame
	$PAGE $URL/undying/enterGame -o user_agent="$(shuf -n1 .ua)" | tail -n 0  &
	echo -e "/undying/enterGame"
	sleep 3
#
	echo " 👣 Entering..."
	echo $($SOURCE $URL/undying -o user_agent="$(shuf -n1 .ua)") >SRC &
	echo -e "/undying/"
	sleep 3
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/undying/' | head -n1 | awk -F\' '{ print $2 }')
	MANA=$(cat SRC | grep -o 'undying/mana/' | head -n1)
# /wait
	echo " 😴 Waiting..."
	until [[ -n $MANA ]] ; do
		[[ $(date +%M) = 00 && $(date +%S) > 19 ]] && break
		echo $($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
		echo -e " 💤 $ACCESS"
		sleep 3
		ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/undying/' | head -n1 | awk -F\' '{ print $2 }')
		MANA=$(cat SRC | grep -o 'undying/mana/' | head -n1)
		killall -q -9 w3m
	done
	echo $($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
	echo -e "$ACCESS"
	sleep 3
	MANA=$(cat SRC | grep -o 'undying/mana/' | head -n1)
	HIT=$(cat SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | awk -F\' '{ print $2 }')
	_AtakeHelp
	_fullmana
	_AdeleteEnd
	echo $($SOURCE "$URL/undying" -o user_agent="$(shuf -n1 .ua)") >SRC &
	echo -e "/undying/"
	sleep 3
	MANA=$(cat SRC | grep -o 'undying/mana/' | head -n1)
	HIT=$(cat SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | awk -F\' '{ print $2 }')
	OUTGATE=$(cat SRC | grep -o 'out_gate')
	while [[ -n $OUTGATE ]] ; do
		[[ $(date +%M) = 0[78] ]] && break
		echo $($SOURCE "$URL$HIT" -o user_agent="$(shuf -n1 .ua)") >SRC &
		echo -e " 🎲 $HIT"
		sleep 1.44
		HIT=$(cat SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | awk -F\' '{ print $2 }')
		OUTGATE=$(cat SRC | grep -o 'out_gate')
		killall -q -9 w3m
	done
	unset ACCESS MANA HIT OUTGATE
# /view
	echo ""
	$PAGE $URL/undying -o user_agent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color $ACC &
	sleep 3
	unset ACC
	echo -e "undying (✔)"
	killall -q -9 w3m
}
