_coliseum () {
# /enterFight
	SRC=$($PAGE $URL/settings/graphics/0 -o user_agent="$(shuf -n1 .ua)")
	HPER='30'
	RPER='10'
	ITVL='3.5'
	echo -e "\nColiseum"
	echo $URL
	$PAGE $URL/coliseum/ -o user_agent="$(shuf -n1 .ua)" | head -n11 | tail -n7 | sed "/\[2hit/d;/\[str/d;/combat/d"
	SRC=$($SOURCE -o accept_encoding=="*;q=0" $URL/coliseum -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/enterFight/' | head -n1 | awk -F\' '{ print $2 }')
	echo -e " 👣 Entering...\n$ACCESS"
	SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
# /wait
	echo " 😴 Waiting..."
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/coliseum/' | head -n1 | awk -F\' '{ print $2 }')
        EXIT=$(echo $SRC | grep -o '/leaveFight/' | head -n1)
	while [[ -n $EXIT ]] ; do
		echo -e " 💤	...\n$ACCESS"
		SRC=$($SOURCE -o accept_encoding=="*;q=0" $URL/coliseum -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/coliseum/' | head -n1 | awk -F\' '{ print $2 }')
		EXIT=$(echo $SRC | grep -o '/leaveFight/' | head -n1)
	done
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | awk -F\< '{ print $2 }' | awk -F\> '{ print $2 }' | tr -cd '[[:digit:]]')
	_access
	HP3=$HP1
	ddg=4
	grss=12
	hl=18
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
# /dodge
		echo $SRC | sed 's/href=/\n/g' | grep '/dodge' | grep 'timer' | awk -F\: '{ print $2 }' | awk -F\< '{ print $1 }' | tr -cd '[[:digit:]]';echo " ";
		if [[ $ddg -ge 4 && $hl -ne 18 && $HP3 -ne $HP1 ]] ; then
			echo '🛡️'
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)")
			ddg=0
			HP3=$HP1
			_access
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /heal
		elif [[ $hl -ge 18 && $HP1 -le $HLHP ]] ; then
			RPER='7'
			echo "🆘 HP < $HPER%"
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)")
			_access
			hl=0
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /grass
#		elif [[ $grss -ge 12 && $ddg != [34] && $hl != 1[78] && `expr $HP1 + $HP1 \* 90 \/ 100` -le $HP2 ]] ; then
#			HPER='30'
#			RPER='13'
#			echo '🙌'
#			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)")
#			_access
#			grss=0
#			sleep $ITVL
#			ddg=$[$ddg+1]
#			hl=$[$hl+1]
#			grss=$[$grss+1]
# /stone
#		[[ `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP2 ]]
#			echo '💪'
#			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$STONE" -o user_agent="$(shuf -n1 .ua)")
#			_access
#			sleep $ITVL
#			ddg=$[$ddg+1]
#			hl=$[$hl+1]
#			grss=$[$grss+1]
# /random
		elif [[ `expr $HP1 + $HP1 \* $RPER \/ 100` -le $HP2 && $ddg -ne 4 && $hl -ne 18 && $grss -ne 12 ]] ; then
			echo '🔁'
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ATKRND" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]

# /atk
		else
			if [[ -n $ALLIES && -n $ALLY && $USER -eq $ALLY ]] ; then
				echo "🔁"
				SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ATKRND" -o user_agent="$(shuf -n1 .ua)") ;
				_access
				sleep $ITVL
				ddg=$[$ddg+1]
				hl=$[$hl+1]
				grss=$[$grss+1]
			fi
			echo '🎯'
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ATK" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
		fi
	done
	unset HPER RPER ITVL SRC ACCESS EXIT FULL HP3 ddg hl grss
# /view
	echo ""
	$PAGE $URL/coliseum/ -o user_agent="$(shuf -n1 .ua)" | head -n11 | tail -n7 | sed "/\[2hit/d;/\[str/d;/combat/d" | grep --color $ACC
	_unset
	echo 'Coliseum (✔)'
	sleep 10
}
