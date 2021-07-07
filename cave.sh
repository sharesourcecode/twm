# /cave
function _cave () {
	_clanid
	if [[ -n $CLD ]]; then
		$PAGE "$URL/clan/$CLD/quest/take/5" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 &
		echo "/clan/$CLD/quest/take/5"
		sleep 3
		$PAGE "$URL/clan/$CLD/quest/help/5" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 &
		echo "/clan/$CLD/quest/help/5"
		sleep 3
		killall -q -9 w3m
	fi
	_condition () {
		echo $($SOURCE "$URL/cave/" -o user_agent="$(shuf -n1 .ua)") >SRC &
		echo "cave ..."
		sleep 3
		ACCESS1=$(cat SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n1 | awk -F\' '{ print $2 }')
		DOWN=$(cat SRC | sed 's/href=/\n/g' | grep '/cave/down' | awk -F\' '{ print $2 }')
		ACCESS2=$(cat SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n2 | tail -n1 | awk -F\' '{ print $2 }')
		ACTION=$(cat SRC | sed 's/href=/\n/g' | grep '/cave/' | awk -F\' '{ print $2 }' | tr -cd "[[:alpha:]]")
		MEGA=$(cat SRC | sed 's/src=/\n/g' | grep '/images/icon/silver.png' | grep "'s'" | tail -n1 | grep -o 'M')
	}
	_condition
	num=2
	until [[ $num -eq 0 ]]; do
		_condition
		case $ACTION in
			(cavechancercavegatherrcavedownr)
				echo $($SOURCE "$URL$ACCESS2" -o user_agent="$(shuf -n1 .ua)") >SRC &
				sleep 3
				num=$[$num-1] ;
				echo $num ;;
			(cavespeedUpr)
				echo $($SOURCE "$URL$ACCESS2" -o user_agent="$(shuf -n1 .ua)") >SRC &
				sleep 3
				num=$[$num-1] ;
				echo $num ;;
			(cavedownr|cavedownrclanbuiltprivateUpgradetruerrefcave)
				num=$[$num-1] ;
				echo $($SOURCE "$URL$DOWN" -o user_agent="$(shuf -n1 .ua)") >SRC &
				sleep 3
				echo $num ;;
			(caveattackrcaverunawayr)
				num=$[$num-1] ;
				echo $($SOURCE "$URL$ACCESS1" -o user_agent="$(shuf -n1 .ua)") >SRC &
				sleep 3
				echo $($SOURCE "$URL/cave/runaway" -o user_agent="$(shuf -n1 .ua)") >SRC &
				sleep 3
				echo $num ;;
			(*) num=0 ;;
		esac
		cat SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n2 | tail -n1 | awk -F\' '{ print $2 }'
		killall -q -9 w3m
	done
	if [[ -n $CLD ]]; then
		$PAGE "$URL/clan/$CLD/quest/deleteHelp/5" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 &
		echo "/clan/$CLD/quest/deleteHelp/5"
		sleep 3
		$PAGE "$URL/clan/$CLD/quest/end/5" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 &
		echo "/clan/$CLD/quest/end/5"
		sleep 3
		killall -q -9 w3m
	fi
	unset CLD ACCESS1 DOWN ACCESS2 ACTION MEGA num
	echo -e "cave (✔)\n"
}
