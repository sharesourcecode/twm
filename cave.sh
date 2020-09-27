# /cave
function _cave () {
	_clanid
#	if [[ -n $CLD ]]; then
#		$PAGE "$URL/clan/$CLD/quest/take/5" -o user_agent="$(shuf -n1 .ua)" | head -n15
#		$PAGE "$URL/clan/$CLD/quest/help/5" -o user_agent="$(shuf -n1 .ua)" | head -n15
#	fi
	_condition () {
		SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/cave/" -o user_agent="$(shuf -n1 .ua)")
		ACCESS1=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n1 | awk -F\' '{ print $2 }')
		DOWN=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/down' | awk -F\' '{ print $2 }')
		ACCESS2=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n2 | tail -n1 | awk -F\' '{ print $2 }')
		ACTION=$(echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | awk -F\' '{ print $2 }' | tr -cd "[[:alpha:]]")
		MEGA=$(echo $SRC | sed 's/src=/\n/g' | grep '/images/icon/silver.png' | grep "'s'" | tail -n1 | grep -o 'M')
	}
	_condition
	num=4
	until [[ $num -eq 0 ]]; do
		_condition
		case $ACTION in
			(cavechancercavegatherrcavedownr)
				SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ACCESS2" -o user_agent="$(shuf -n1 .ua)") ;
				num=$[$num-1] ;
				echo $num ;;
			(cavespeedUpr)
#				SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ACCESS2" -o user_agent="$(shuf -n1 .ua)") ;
				num=$[$num-1] ;
				echo $num ;;
			(cavedownr|cavedownrclanbuiltprivateUpgradetruerrefcave)
				num=$[$num-1] ;
				SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$DOWN" -o user_agent="$(shuf -n1 .ua)") ;
				echo $num ;;
			(caveattackrcaverunawayr)
				num=$[$num-1] ;
				SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ACCESS1" -o user_agent="$(shuf -n1 .ua)") ;
				SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/cave/runaway" -o user_agent="$(shuf -n1 .ua)") ;
				echo $num ;;
			(*) num=0 ;;
		esac
		echo $SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n2 | tail -n1 | awk -F\' '{ print $2 }'
	done
#	if [[ -n $CLD ]]; then
#		$PAGE "$URL/clan/$CLD/quest/end/5" -o user_agent="$(shuf -n1 .ua)" | head -n15
#		$PAGE "$URL/clan/$CLD/quest/deleteHelp/5" -o user_agent="$(shuf -n1 .ua)" | head -n15
#	fi
	unset CLD SRC ACCESS1 DOWN ACCESS2 ACTION MEGA num
	echo -e "cave (✔)\n"
}
