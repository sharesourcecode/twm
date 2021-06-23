# /clandungeon
function _clandungeon () {
	_clanid
	if [[ -n $CLD ]]; then
		echo "Checking Clan Dungeon..."
		SRC=$($SOURCE "$URL/clandungeon/?close" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/clandungeon/attack/' | head -n1 | awk -F\' '{ print $2 }')
		EXIST=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'clandungeon/attack')
		until [[ -z $EXIST ]]; do
			SRC=$($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
			ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/clandungeon/attack/' | head -n1 | awk -F\' '{ print $2 }')
			EXIST=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'clandungeon/attack')
			echo " ⚔ $ACCESS"
		done
		echo -e "Clan Dungeon (✔)\n"
	fi
	unset CLD SRC ACCESS EXIST
}
