# /arena
_openChest () {
	SRC=$($SOURCE  "$URL/quest" -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'quest/openChest' | head -n1 | awk -F\' '{ print $2 }')
	while [[ -n $ACCESS ]]; do
		echo $ACCESS
		SRC=$($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'quest/openChest' | head -n1 | awk -F\' '{ print $2 }')
	done
	unset SRC ACCESS
	echo -e "openChest (✔)\n"
}
_colifight () {
	SRC=$($SOURCE "$URL/collfight/enterFight" -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'collfight/take' | head -n1 | awk -F\' '{ print $2 }') #/arena/attack/1/1234567*/
	SRC=$($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
	SRC=$($SOURCE "$URL/collfight/enterFight" -o user_agent="$(shuf -n1 .ua)")
	unset SRC ACCESS
}
_AtakeHelp () {
	_clanid
	if [[ -n $CLD ]]; then
		$PAGE "$URL/clan/$CLD/quest/take/3" -o user_agent="$(shuf -n1 .ua)" | head -n15;
#		$PAGE "$URL/clan/$CLD/quest/help/3" -o user_agent="$(shuf -n1 .ua)" | head -n15;
		$PAGE "$URL/clan/$CLD/quest/take/4" -o user_agent="$(shuf -n1 .ua)" | head -n15;
#		$PAGE "$URL/clan/$CLD/quest/help/4" -o user_agent="$(shuf -n1 .ua)" | head -n15;
	fi
	unset CLD
}
_AdeleteEnd () {
	_clanid
	if [[ -n $CLD ]]; then
#		$PAGE "$URL/clan/$CLD/quest/deleteHelp/3" -o user_agent="$(shuf -n1 .ua)" | head -n15;
#		$PAGE "$URL/clan/$CLD/quest/deleteHelp/4" -o user_agent="$(shuf -n1 .ua)" | head -n15;
		$PAGE "$URL/clan/$CLD/quest/end/3" -o user_agent="$(shuf -n1 .ua)" | head -n15;
		$PAGE "$URL/clan/$CLD/quest/end/4" -o user_agent="$(shuf -n1 .ua)" | head -n15;
	fi
	unset CLD
}
_arena () {
	_AtakeHelp
	SRC=$($SOURCE "$URL/arena/" -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'arena/attack' | head -n1 | awk -F\' '{ print $2 }') #/arena/attack/1/1234567*/
	EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep 'lab/wizard' | head -n1 | awk -F\' '{ print $2 }') #/lab/wizard/potion/1234567*/?ref=/arena/
	while [[ -z $EXIT && -n $ACCESS ]]; do
		SRC=$($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'arena/attack' | head -n1 | awk -F\' '{ print $2 }') #/arena/attack/1/1234567*/
		echo "$ACCESS"
		EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep 'lab/wizard' | head -n1 | awk -F\' '{ print $2 }') #/lab/wizard/potion/1234567*/?ref=/arena/
	done
	_AdeleteEnd
	unset SRC ACCESS EXIT
	echo -e "arena (✔)\n"
}
_fullmana () {
	ARENA=$($SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]")
	echo " ⚔ - 1 Attack..."
	ATK1=$($SOURCE "$URL/arena/attack/1/?r=$ARENA" -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "arena/lastPlayer" | head -n1 | awk -F\' '{ print $1 }' | tr -cd "[[:digit:]]")
	echo " ⚔ - Full Attack..."
	$DUMP "$URL/arena/lastPlayer/?r=$ATK1&fullmana=true" -o user_agent="$(shuf -n1 .ua)"
	unset ARENA ATK1
}
