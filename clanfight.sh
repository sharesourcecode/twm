_clanfight () {
# /enterFight
	HPER='49'
	RPER='15'
	_show () {
		CLAN=$(cat SRC | grep -o -P "\p{Lu}{1}\p{Ll}{0,15}[\ ]{0,1}\p{L}{0,14}\s\(" | sed -n 's,\ [(],,;s,\ ,_,;2p')
		YOU=$(cat SRC | grep -o -P "\p{Lu}{1}\p{Ll}{0,15}[\ ]{0,1}\p{L}{0,14}\s\Ws" | sed -n 's,\ [<]s,,;s,\ ,_,;1p')
		USER=$(cat SRC | grep -o -P "\p{Lu}{1}\p{Ll}{0,15}[\ ]{0,1}\p{L}{0,14}\s\Ws" | sed -n 's,\ [<]s,,;s,\ ,_,;2p')
		HP1=$(cat SRC | grep -o -P "(hp)\W{1,4}\d{1,6}" | sed "s,hp[']\/[>],,;s,\ ,,")
		HP2=$(cat SRC | grep -o -P "(nbsp)\W{1,2}\d{1,6}" | sed 's,nbsp[;],,;s,\ ,,')
		if [[ -n $OUTGATE ]] ; then
			[[ $HP1 -gt 0 && $HP2 -gt 0 ]] && echo -e "$URL\n$YOU: $HP1 - $HP2 :$USER\n"
			[[ $HP1 -eq 0 ]] && echo -e "$URL\n$YOU: 💀 - $HP2 :$USER\n"
			[[ $HP2 -eq 0 ]] && echo -e "$URL\n$YOU: $HP1 - 💀 :$USER\n"
		fi
	}
	echo -e "\nClan fight"
	echo $URL
	echo $($SOURCE $URL/clanfight/?close=reward -o user_agent="$(shuf -n1 .ua)") >SRC &
	x=$! ; sleep 5 && kill -9 $x &> /dev/null
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep 'clanfight/enterFight' | head -n1 | awk -F\' '{ print $2 }')
	echo -e " 👣 Entering...\n$ACCESS"
# /wait
	echo " 😴 Waiting..."
        EXIT=$(cat SRC | grep -o 'clanfight/attack/')
	while [[ -z $EXIT ]] ; do
		[[ $(date +%M) = 00 && $(date +%S) > 19 ]] && break
		echo -e " 💤	...\n$ACCESS"
		echo $($SOURCE "$URL/clanfight/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)") >SRC &
		x=$! ; sleep 5 && kill -9 $x &> /dev/null
		ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/clanfight/' | head -n1 | awk -F\' '{ print $2 }')
		EXIT=$(cat SRC | grep -o 'clanfight/attack/')
	done
	FULL=$(cat SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | awk -F\< '{ print $2 }' | awk -F\> '{ print $2 }' | tr -cd '[[:digit:]]')
	_access
	HP3=$HP1
	ddg=9
	hl=40
	grss=27
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
		[[ $(date +%M) = 08 ]] && break
# /dodge
		if [[ $hl -ne 40 && $ddg -ge 9 && $HP3 -ne $HP1 ]] ; then
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
#		elif [[ $grss -ge 12 && $ddg != [34] && $hl != 1[78] ]] ; then
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
		elif [[ -n $(grep -o "$CLAN" $TMP/callies.txt) || `expr $HP1 + $HP1 \* $RPER \/ 100` -le $HP2 && $ddg -ne 9 && $hl -ne 40 ]] ; then
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
	$PAGE $URL/clanfight -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color $ACC &
	x=$! ; sleep 5 && kill -9 $x &> /dev/null
	_unset
	echo "ClanFight(✔)"
	sleep 30
}
