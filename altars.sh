_altars () {
# /enterFight
	HPER='49'
	RPER='15'
	_show () {
		YOU=$(echo $SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F" [<]" '{print $1}' | awk -F"[>] " '{print $2}' | sed 's,\ ,_,')
		USER=$(echo $SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"[>] " '{ print $5 }' | awk -F" [<]" '{ print $1 }' | sed 's,\ ,_,')
		CLAN=$(echo $SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"[>] " '{ print $6 }' | awk -F" [(]" '{ print $1}' | sed 's,\ ,_,')
		HP1=$(echo $SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"[>] " '{ print $3 }' | awk -F"[<]" '{ print $1}')
		HP2=$(echo $SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"nbsp[;]" '{ print $2 }' | awk -F"[<]" '{ print $1}')
		if [[ -n $OUTGATE ]] ; then
			[[ $HP1 -gt 0 && $HP2 -gt 0 ]] && echo -e "$URL\n$YOU: $HP1 - $HP2 :$USER\n"
			[[ $HP1 -eq 0 ]] && echo -e "$URL\n$YOU: 💀 - $HP2 :$USER\n"
			[[ $HP2 -eq 0 ]] && echo -e "$URL\n$YOU: $HP1 - 💀 :$USER\n"
		fi
	}
	echo -e "\nAltars"
	echo $URL
	SRC=$($SOURCE -o accept_encoding=="*;q=0" $URL/altars/enterFight -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'altars/enterFight' | head -n1 | awk -F\' '{ print $2 }')
	echo -e " 👣 Entering...\n$ACCESS"
# /wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'altars/attack/')
	while [[ -z $EXIT ]] ; do
                [[ $(date +%M) =  {00..09} && $(date +%S) > 19 ]] && break
		echo -e "$URL\n 💤	...\n$ACCESS"
		SRC=$($SOURCE -o accept_encoding=="*;q=0" $URL/altars/?close=reward -o user_agent="$(shuf -n1 .ua)")
		SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/altars/enterFight/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/altars/' | head -n1 | awk -F\' '{ print $2 }')
		EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'altars/attack/')
	done
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | awk -F\< '{ print $2 }' | awk -F\> '{ print $2 }' | tr -cd '[[:digit:]]')
	_access
	HP3=$HP1
	ddg=9
	hl=40
	grss=27
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
                [[ $(date +%M) = 0[98] ]] && break
# /dodge
		if [[ $ddg -ge 9 && $hl -ne 40 && $HP3 -ne $HP1 ]] ; then
			sleep 0.45
			echo '🛡️'
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)")
			ddg=0
			HP3=$HP1
			_access
			sleep 1
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /heal
		elif [[ $hl -ge 40 && $HP1 -le $HLHP ]] ; then
			sleep 0.45
			echo "🆘 HP < $HPER%"
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)")
			_access
			hl=0
			sleep 0.9
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
		elif [[ -n $(grep -o "$CLAN" $TMP/callies.txt) || `expr $HP1 + $HP1 \* $RPER \/ 100` -le $HP2 && $ddg -ne 9 && $hl -ne 40 ]] ; then
			echo "🔁$CLAN"
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ATTACKRANDOM" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep 0.9
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]

# /atk
		else
			echo '🎯'
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ATTACK" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep 0.9
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
		fi
	done
	unset HPER RPER ITVL SRC ACCESS EXIT FULL HP3 ddg hl grss
# /view
	$PAGE $URL/altars -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color $ACC
	_unset
	echo "Altars (✔)"
	sleep 30
}
