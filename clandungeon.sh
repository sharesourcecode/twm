# /clandungeon
function _clandungeon () {
	_clanid
	if [[ -n $CLD ]]; then
		echo "Checking Clan Dungeon..."
		echo $($SOURCE "$URL/clandungeon/?close" -o user_agent="$(shuf -n1 .ua)") >SRC &
		x=$! ; sleep 5 && kill -9 $x &> /dev/null
		ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/clandungeon/attack/' | head -n1 | awk -F\' '{ print $2 }')
		EXIST=$(cat SRC | sed 's/href=/\n/g' | grep -o 'clandungeon/attack')
		until [[ -z $EXIST ]]; do
			echo =$($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x=$! ; sleep 5 && kill -9 $x &> /dev/null
			ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/clandungeon/attack/' | head -n1 | awk -F\' '{ print $2 }')
			EXIST=$(cat SRC | sed 's/href=/\n/g' | grep -o 'clandungeon/attack')
			echo " ⚔ $ACCESS"
		done
		echo -e "Clan Dungeon (✔)\n"
	fi
	unset CLD ACCESS EXIST
}
