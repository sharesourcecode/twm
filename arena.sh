# /arena
_openChest () {
	echo $($SOURCE  "$URL/quest" -o user_agent="$(shuf -n1 .ua)") >SRC &
	x=$! ; sleep 3 && kill -9 $x &> /dev/null
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep 'quest/openChest' | head -n1 | awk -F\' '{ print $2 }')
	while [[ -n $ACCESS ]]; do
		echo $ACCESS
		cat $($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
		ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep 'quest/openChest' | head -n1 | awk -F\' '{ print $2 }')
	done
	unset ACCESS
	echo -e "openChest (✔)\n"
}
_colifight () {
	echo $($SOURCE "$URL/collfight/enterFight" -o user_agent="$(shuf -n1 .ua)") >SRC &
	x=$! ; sleep 3 && kill -9 $x &> /dev/null
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep 'collfight/take' | head -n1 | awk -F\' '{ print $2 }') #/arena/attack/1/1234567*/
	SRC=$($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") &
	x=$! ; sleep 3 && kill -9 $x &> /dev/null
	SRC=$($SOURCE "$URL/collfight/enterFight" -o user_agent="$(shuf -n1 .ua)") &
	x=$! ; sleep 3 && kill -9 $x &> /dev/null
	unset SRC ACCESS
}
_AtakeHelp () {
	_clanid
	if [[ -n $CLD ]]; then
		$DUMP "$URL/clan/$CLD/quest/take/3" -o user_agent="$(shuf -n1 .ua)" | head -n5 | tail -n4 &
		x=$! ; sleep 3 ; kill -9 $x &> /dev/null ; echo ""
		$DUMP "$URL/clan/$CLD/quest/help/3" -o user_agent="$(shuf -n1 .ua)" | head -n5 | tail -n4 &
		x=$! ; sleep 3 ; kill -9 $x &> /dev/null ; echo ""
		$DUMP "$URL/clan/$CLD/quest/take/4" -o user_agent="$(shuf -n1 .ua)" | head -n5 | tail -n4 &
		x=$! ; sleep 3 ; kill -9 $x &> /dev/null ; echo ""
		$DUMP "$URL/clan/$CLD/quest/help/4" -o user_agent="$(shuf -n1 .ua)" | head -n5 | tail -n4 &
		x=$! ; sleep 3 ; kill -9 $x &> /dev/null ; echo ""
	fi
	unset CLD
}
_AdeleteEnd () {
	_clanid
	if [[ -n $CLD ]]; then
		$DUMP "$URL/clan/$CLD/quest/deleteHelp/3" -o user_agent="$(shuf -n1 .ua)" | head -n5 | tail -n4 &
		x=$! ; sleep 3 ; kill -9 $x &> /dev/null ; echo ""
		$DUMP "$URL/clan/$CLD/quest/end/3" -o user_agent="$(shuf -n1 .ua)" | head -n5 | tail -n4 &
		x=$! ; sleep 3 ; kill -9 $x &> /dev/null ; echo ""
		$DUMP "$URL/clan/$CLD/quest/deleteHelp/4" -o user_agent="$(shuf -n1 .ua)" | head -n5 | tail -n4 &
		x=$! ; sleep 3 ; kill -9 $x &> /dev/null ; echo ""
		$DUMP "$URL/clan/$CLD/quest/end/4" -o user_agent="$(shuf -n1 .ua)" | head -n5 | tail -n4 &
		x=$! ; sleep 3 ; kill -9 $x &> /dev/null ; echo ""
	fi
	unset CLD
}
_arena () {
	_AtakeHelp
	echo $($SOURCE "$URL/arena/" -o user_agent="$(shuf -n1 .ua)") >SRC &
	x=$! ; sleep 3 && kill -9 $x &> /dev/null
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep 'arena/attack' | head -n1 | awk -F\' '{ print $2 }') #/arena/attack/1/1234567*/
	EXIT=$(cat SRC | sed 's/href=/\n/g' | grep 'lab/wizard' | head -n1 | awk -F\' '{ print $2 }') #/lab/wizard/potion/1234567*/?ref=/arena/
	while [[ -z $EXIT && -n $ACCESS ]]; do
		echo $($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
		x=$! ; sleep 3 ; kill -9 $x &> /dev/null
		ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep 'arena/attack' | head -n1 | awk -F\' '{ print $2 }') #/arena/attack/1/1234567*/
		echo "$ACCESS"
		EXIT=$(cat SRC | sed 's/href=/\n/g' | grep 'lab/wizard' | head -n1 | awk -F\' '{ print $2 }') #/lab/wizard/potion/1234567*/?ref=/arena/
	done
	_AdeleteEnd
	unset ACCESS EXIT
	echo -e "arena (✔)\n"
}
_fullmana () {
	echo $($SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]") >ARENA &
	x=$! ; sleep 3 && kill -9 $x &> /dev/null
	echo " ⚔ - 1 Attack..."
	echo $($SOURCE "$URL/arena/attack/1/?r=`cat ARENA`" -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "arena/lastPlayer" | head -n1 | awk -F\' '{ print $1 }' | tr -cd "[[:digit:]]") >ATK1 &
	x=$! ; sleep 3 && kill -9 $x &> /dev/null
	echo " ⚔ - Full Attack..."
	$DUMP "$URL/arena/lastPlayer/?r=`cat ATK1`&fullmana=true" -o user_agent="$(shuf -n1 .ua)" | head -n5 | tail -n4 &
	x=$! ; sleep 3 && kill -9 $x &> /dev/null
}
