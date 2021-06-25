_undying () {
# /clear bag
	$PAGE $URL/inv/bag/sellAll/1/ -o user_agent="$(shuf -n1 .ua)" | head -n 3 | tail -n 2 &
	x=$! ; sleep 2 && kill -9 $x &> /dev/null
# /enterGame
	echo "Undying"
	$PAGE $URL/undying/enterGame -o user_agent="$(shuf -n1 .ua)" | head -n5 &
	x=$! ; sleep 2 && kill -9 $x &> /dev/null
#
	echo " 👣 Entering..."
	echo $($SOURCE $URL/undying -o user_agent="$(shuf -n1 .ua)") >SRC &
	x=$! ; sleep 3 && kill -9 $x &> /dev/null
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/undying/' | head -n1 | awk -F\' '{ print $2 }')
	MANA=$(cat SRC | grep -o 'undying/mana/' | head -n1)
# /wait
	echo " 😴 Waiting..."
	until [[ -n $MANA ]] ; do
		[[ $(date +%M) = 00 && $(date +%S) > 19 ]] && break
		echo -e " 💤 	..."
		cat $($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
		ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/undying/' | head -n1 | awk -F\' '{ print $2 }')
		MANA=$(cat SRC | grep -o 'undying/mana/' | head -n1)
	done
	echo $($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
	x=$! ; sleep 3 && kill -9 $x &> /dev/null
	MANA=$(cat SRC | grep -o 'undying/mana/' | head -n1)
	HIT=$(cat SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | awk -F\' '{ print $2 }')
	_AtakeHelp
	_fullmana
	_AdeleteEnd
	echo $($SOURCE "$URL/undying" -o user_agent="$(shuf -n1 .ua)") >SRC &
	x=$! ; sleep 3 && kill -9 $x &> /dev/null
	MANA=$(cat SRC | grep -o 'undying/mana/' | head -n1)
	HIT=$(cat SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | awk -F\' '{ print $2 }')
	OUTGATE=$(cat SRC | grep -o 'out_gate')
	while [[ -n $OUTGATE ]] ; do
		[[ $(date +%M) = 0[78] ]] && break
		echo $($SOURCE "$URL$HIT" -o user_agent="$(shuf -n1 .ua)") >SRC &
		x=$! ; sleep 1.44 && kill -9 $x &> /dev/null
		HIT=$(cat SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | awk -F\' '{ print $2 }')
		OUTGATE=$(cat SRC | grep -o 'out_gate')
		echo -e " 🎲 $HIT"
	done
	unset ACCESS MANA HIT OUTGATE
# /view
	echo ""
	$PAGE $URL/undying -o user_agent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color $ACC &
	x=$! ; sleep 3 && kill -9 $x &> /dev/null
	unset ACC
	echo -e "Undying (✔)"
}
