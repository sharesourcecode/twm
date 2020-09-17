_king () {
# /enterFight
	HPER='53'
	RPER='1'
	ITVL='3.5'
	_show () {
		YOU=$(echo $SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"[>] " '{ print $2 }' | awk -F" [<]" '{ print $1}' | sed 's,\ ,_,')
		USER=$(echo $SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"[>] " '{ print $4 }' | awk -F" [<]" '{ print $1}' | sed 's,\ ,_,')
		HP1=$(echo $SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"[>] " '{ print $3 }' | awk -F"[<]" '{ print $1}')
		HP2=$(echo $SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"nbsp[;]" '{ print $2 }' | awk -F"[<]" '{ print $1}' | tr -cd [[:digit:]])
		if [[ -n $OUTGATE ]] ; then
			[[ -n $HP1 && -n $HP2 ]] && echo -e "$URL\n$ACC: $HP1 - $HP2 :$USER\n"
			[[ -z $HP1 && -n $HP2 ]] && echo -e "$URL\n$ACC: 💀 - $HP2 :$USER\n"		else
#			[[ -n $HP1 && -n $HP2 ]] && echo -e "$URL\nYou: $HP1 - $HP2 :Opponent\n"
#			[[ -z $HP1 && -n $HP2 ]] && echo -e "$URL\nYou: 💀 - $HP2 :Opponent\n"
		fi
	}
	echo -e "\nKing"
	echo $URL
	SRC=$($SOURCE -o accept_encoding=="*;q=0" $URL/king/enterGame -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/king/' | head -n1 | awk -F\' '{ print $2 }')
	echo -e " 👣 Entering...\n$ACCESS"
# /wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | grep -o 'king/kingatk/')
	while [[ -z $EXIT ]] ; do
		[[ $(date +%M) = 30 && $(date +%S) > 19 ]] && break
		echo -e " 💤	...\n$ACCESS"
		SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/king/' | head -n1 | awk -F\' '{ print $2 }')
		EXIT=$(echo $SRC | grep -o 'king/kingatk/')
	done
# /game
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep "hp" | head -n1 | awk -F\< '{ print $2 }' | awk -F\> '{ print $2 }' | tr -cd "[[:digit:]]")
	_access
	HP3=$HP1
	ddg=4
	hl=18
	grss=12
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
		[[ $(date +%M) = 4[01] ]] && break
# /kingatk
		if [[ -n $KINGATK && $ddg -le 4 && $hl -ne 18 && $HP2 -gt 1 ]] ; then
			echo '👑'
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$KINGATK" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /dodge
		elif [[ $ddg -ge 4 && $hl -ne 18 && $HP3 -ne $HP1 ]] ; then
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
#		elif [[ $HP2 -le 25 || -z $KINGATK && $ddg != [34] && $hl != 1[78] && $grss -ge 12 ]] ; then
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
		elif [[ -n $(grep -o "$USER" $HOME/.tmp/allies.txt) || `expr $HP1 + $HP1 \* $RPER \/ 100` -le $HP2 && $ddg -ne 4 && $hl -ne 18 && $grss -ne 12 ]] ; then
			echo '🔁'
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ATTACKRANDOM" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep $ITVL
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]

# /atk
		else
			echo '🎯'
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ATTACK" -o user_agent="$(shuf -n1 .ua)")
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
	$PAGE $URL/king -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color $ACC
	_unset
	echo "King (✔)"
	sleep 30
}
