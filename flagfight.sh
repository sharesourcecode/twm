_flagfight () {
# /enterFight
	HPER='48'
	RPER='15'
	_show () {
		YOU=$(cat SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F" [<]" '{print $1}' | awk -F"[>] " '{print $2}' | sed 's,\ ,_,')
		USER=$(cat SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"[>] " '{ print $5 }' | awk -F" [<]" '{ print $1 }' | sed 's,\ ,_,')
		CLAN=$(cat SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"[>] " '{ print $6 }' | awk -F" [(]" '{ print $1}' | sed 's,\ ,_,')
		HP1=$(cat SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"[>] " '{ print $3 }' | awk -F"[<]" '{ print $1}')
		HP2=$(cat SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"nbsp[;]" '{ print $2 }' | awk -F"[<]" '{ print $1}')
		if [[ -n $OUTGATE ]] ; then
			[[ $HP1 -gt 0 && $HP2 -gt 0 ]] && echo -e "$URL\n$YOU: $HP1 - $HP2 :$USER\n"
			[[ $HP1 -eq 0 ]] && echo -e "$URL\n$YOU: 💀 - $HP2 :$USER\n"
			[[ $HP2 -eq 0 ]] && echo -e "$URL\n$YOU: $HP1 - 💀 :$USER\n"
		fi
	}
	echo -e "\nFlag Fight"
	echo $URL
	echo $($SOURCE $URL/flagfight/?close=reward -o user_agent="$(shuf -n1 .ua)") >SRC &
	x=$! ; sleep 5 && kill -9 $x &> /dev/null
	echo $($SOURCE "$URL/flagfight/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)") >SRC &
	x=$! ; sleep 5 && kill -9 $x &> /dev/null
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep 'flagfight/enterFight' | head -n1 | awk -F\' '{ print $2 }')
	echo -e " 👣 Entering...\n$ACCESS"
# /wait
	echo " 😴 Waiting..."
        EXIT=$(cat SRC | sed 's/href=/\n/g' | grep -o 'flagfight/attack/')
	while [[ -z $EXIT ]] ; do
		[[ $(date +%M) = 15 && $(date +%S) > 19 ]] && break
		echo -e " 💤	...\n$ACCESS"
		echo $($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
		x=$! ; sleep 5 && kill -9 $x &> /dev/null
		ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/flagfight/' | head -n1 | awk -F\' '{ print $2 }')
		EXIT=$(cat SRC | sed 's/href=/\n/g' | grep -o 'flagfight/attack/')
	done
	FULL=$(cat SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | awk -F\< '{ print $2 }' | awk -F\> '{ print $2 }' | tr -cd '[[:digit:]]')
	_access
	HP3=$HP1
	ddg=9
	hl=40
	grss=27
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
		[[ $(date +%M) = 2[67] ]] && break
# /dodge
		if [[ $ddg -ge 9 && $hl -ne 40 && $HP3 -ne $HP1 ]] ; then
			echo '🛡️'
			echo $($SOURCE "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x=$! ; sleep 1.45 && kill -9 $x &> /dev/null
			ddg=0
			HP3=$HP1
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /heal
		elif [[ $hl -ge 40 && $HP1 -le $HLHP ]] ; then
			echo "🆘 HP < $HPER%"
			echo $($SOURCE "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x=$! ; sleep 1.35 && kill -9 $x &> /dev/null
			_access
			hl=0
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /grass
#		elif [[ $grss -ge 12 && $ddg != [34] && $hl != 1[78] && `expr $HP1 + $HP1 \* 90 \/ 100` -le $HP2 ]] ; then
#			HPER='30'
#			RPER='13'
#			echo '🙌'
#			echo $($SOURCE "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)")
#			_access
#			grss=0
#			sleep $ITVL
#			ddg=$[$ddg+1]
#			hl=$[$hl+1]
#			grss=$[$grss+1]
# /stone
#		[[ `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP2 ]]
#			echo '💪'
#			echo $($SOURCE "$URL$STONE" -o user_agent="$(shuf -n1 .ua)")
#			_access
#			sleep $ITVL
#			ddg=$[$ddg+1]
#			hl=$[$hl+1]
#			grss=$[$grss+1]
# /random
		elif [[ -n $(grep -o "$CLAN" $TMP/callies.txt) || `expr $HP1 + $HP1 \* $RPER \/ 100` -le $HP2 && $ddg -ne 9 && $hl -lt 40 ]] ; then
			echo "🔁$CLAN"
			echo $($SOURCE "$URL$ATTACKRANDOM" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x=$! ; sleep 1.20 && kill -9 $x &> /dev/null
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]

# /atk
		else
			echo '🎯'
			echo $($SOURCE "$URL$ATTACK" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x=$! ; sleep 1.20 && kill -9 $x &> /dev/null
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
		fi
	done
	unset HPER RPER ITVL ACCESS EXIT FULL HP3 ddg hl grss
# /view
	echo ""
	$PAGE $URL/flagfight -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color $ACC &
	x=$! ; sleep 5 && kill -9 $x &> /dev/null
	_unset
	echo "Flag Fight (✔)"
	_AtakeHelp
	_fullmana
	_AdeleteEnd
}
