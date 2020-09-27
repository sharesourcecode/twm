_undying () {
# /enterGame
	echo "Undying"
	$PAGE $URL/undying/enterGame -o user_agent="$(shuf -n1 .ua)" | head -n5
#
	echo " 👣 Entering..."
	SRC=$($SOURCE -o accept_encoding=="*;q=0" $URL/undying -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/undying/' | head -n1 | awk -F\' '{ print $2 }')
	MANA=$(echo $SRC | grep -o 'undying/mana/' | head -n1)
# /wait
	echo " 😴 Waiting..."
	until [[ -n $MANA ]] ; do
		[[ $(date +%M) = 00 && $(date +%S) > 19 ]] && break
		echo -e " 💤 	..."
		SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/undying/' | head -n1 | awk -F\' '{ print $2 }')
		MANA=$(echo $SRC | grep -o 'undying/mana/' | head -n1)
	done
	SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
	MANA=$(echo $SRC | grep -o 'undying/mana/' | head -n1)
	HIT=$(echo $SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | awk -F\' '{ print $2 }')
#	_AtakeHelp
	_fullmana
#	_AdeleteEnd
	SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/undying" -o user_agent="$(shuf -n1 .ua)")
	MANA=$(echo $SRC | grep -o 'undying/mana/' | head -n1)
	HIT=$(echo $SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | awk -F\' '{ print $2 }')
	OUTGATE=$(echo $SRC | grep -o 'out_gate')
	while [[ -n $OUTGATE ]] ; do
		[[ $(date +%M) = 0[78] ]] && break
		SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$HIT" -o user_agent="$(shuf -n1 .ua)")
		HIT=$(echo $SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | awk -F\' '{ print $2 }')
		OUTGATE=$(echo $SRC | grep -o 'out_gate')
		echo -e " 🎲 $HIT"
		sleep 1.44
	done
	unset SRC ACCESS MANA HIT OUTGATE
# /view
	echo ""
	$PAGE $URL/undying -o user_agent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color $ACC
	unset ACC
	echo -e "Undying (✔)"
}
