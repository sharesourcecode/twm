_king () {
# /enterFight
	HPER='50'
	RPER='1'
	_show () {
		YOU=$(echo $SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F" [<]" '{ print $1 }' | awk -F"[>] " '{ print $2 }' | sed 's,\ ,_,')
		U=$(echo $SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"[>] " '{ print $4 }' | awk -F" [<]" '{ print $1 }' | sed 's,\ ,_,')
		HP1=$(echo $SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"[>] " '{ print $3 }' | awk -F"[<]" '{ print $1 }')
		HP2=$(echo $SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"nbsp[;]" '{ print $2 }' | awk -F"[<]" '{ print $1 }' | tr -cd [[:digit:]])
		if [[ -n $OUTGATE ]] ; then
			[[ $HP1 -gt 0 && $HP2 -gt 0 ]] && echo -e "$URL\n$YOU: $HP1 - $HP2 :$U\n"
			[[ $HP1 -eq 0 ]] && echo -e "$URL\n$YOU: 💀 - $HP2 :$U\n"
			[[ $HP2 -eq 0 ]] && echo -e "$URL\n$YOU: $HP1 - 💀 :$U\n"
		fi
	}
	echo -e "\nKing"
	echo $URL
	SRC=$($SOURCE -o accept_encoding=="*;q=0" $URL/king/enterGame -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/king/' | head -n1 | awk -F"[']" '{ print $2 }')
	echo -e " 👣 Entering...\n$ACCESS"
# /wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | grep -o 'king/kingatk/')
	while [[ -z $EXIT ]] ; do
		[[ $(date +%M) = 30 && $(date +%S) > 19 ]] && break
		echo -e " 💤	...\n$ACCESS"
		SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/king/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)")
		SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/king/' | head -n1 | awk -F"[']" '{ print $2 }')
		EXIT=$(echo $SRC | grep -o 'king/kingatk/')
	done
# /game
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep "hp" | head -n1 | awk -F\< '{ print $2 }' | awk -F\> '{ print $2 }' | tr -cd "[[:digit:]]")
	_access
	HP3=$HP1
	ddg=9
	grss=27
	hl=0
	until [[ -n $BEXIT && -z $OUTGATE ]]; do
#	until [[ $(date +%M) = 4[01] ]]; do
# /dodge
		if [[ $HP3 -lt $HP1 && $ddg -ge 9 ]]; then
			echo '🛡️'
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)")
			ddg=0
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
			HP3=$HP1
			sleep 1
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)")
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /kingatk
		elif [[ -n $KINGATK ]]; then
			sleep 0.9
			echo '👑'
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$KINGATK" -o user_agent="$(shuf -n1 .ua)")
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
			sleep 0.9
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$STONE" -o user_agent="$(shuf -n1 .ua)")
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /heal
		elif [[ $HP1 -le $HLHP && $hl -le 41 ]]; then
			echo "🆘 HP < $HPER%"
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)")
			hl=0
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)")
			_access
			sleep 0.9
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /random
		elif [[ $hl -le 41 && -n $(grep "$U" $TMP/allies.txt) ]]; then
			sleep 0.9
			echo "🔁$U"
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$ATTACKRANDOM" -o user_agent="$(shuf -n1 .ua)")
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /atk
		else
			sleep 0.9
			echo '🎯'
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL$STONE" -o user_agent="$(shuf -n1 .ua)")
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
		fi
	done
	unset HPER RPER ITVL SRC ACCESS EXIT FULL HP3 ddg hl grss
# /view
	echo ""
	$PAGE $URL/king -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | sed "/\[U\]/d;/\[arrow\]/d;/\ \[/d" | grep --color $ACC
	_unset
	echo "King (✔)"
	sleep 30
}
