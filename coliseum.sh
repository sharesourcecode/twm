_coliseum () {
# /enterFight
	echo -e "\nColiseum ..."
	echo $($PAGE $URL/settings/graphics/0 -o user_agent="$(shuf -n1 .ua)") >SRC &
	x1=$! ; echo -e "$URL/settings/graphics/0\n" ; sleep 3
	HPER='30'
	RPER='20'
	_show () {
		YOU=$(cat SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | sed 's,\ ,_,g' | awk -F"_[<]" '{print $1}' | awk -F"[>]_" '{print $2}')
		USER=$(cat SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"[>] " '{print $4}' | awk -F" [<]" '{print $1}' | sed 's,\ ,_,')
		HP1=$(cat SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"[>] " '{ print $3 }' | awk -F"[<]" '{ print $1}')
		HP2=$(cat SRC | sed 's,/images/icon/race/,\n,' | sed -n -e 2p | awk -F"nbsp[;]" '{ print $2 }' | awk -F"[<]" '{ print $1}')
		if [[ -n $OUTGATE ]] ; then
			[[ $HP1 -gt 0 && $HP2 -gt 0 ]] && echo -e "$YOU: $HP1 - $HP2 :Opponent\n"
			[[ $HP1 -eq 0 ]] && echo -e "$YOU: 💀 - $HP2 :Opponent\n"
			[[ $HP2 -eq 0 ]] && echo -e "$YOU: $HP1 - 💀 :Opponent\n"
		fi
}
	$PAGE $URL/coliseum -o user_agent="$(shuf -n1 .ua)" | head -n11 | tail -n7 | sed "/\[2hit/d;/\[str/d;/combat/d" &
	x2=$! ; echo "$URL/coliseum" ; sleep 3
	echo $($SOURCE "$URL/coliseum/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)") >SRC &
	x3=$! ; echo -e "\n$URL/coliseum/?close_clan_msg=true" ; sleep 2
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/enterFight/' | head -n1 | awk -F\' '{ print $2 }')
	echo -e " 👣 Entering...\n$ACCESS"
	echo $($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
	x4=$! ; echo "$URL$ACCESS" ; sleep 3
	kill -9 $x1 $x2 $x3 $x4 2> /dev/null
# /wait
	echo "😴 Waiting..."
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/coliseum/' | head -n1 | awk -F\' '{ print $2 }')
        EXIT=$(cat SRC | grep -o '/leaveFight/' | head -n1)
	while [[ -n $EXIT ]] ; do
		echo $($SOURCE $URL/coliseum -o user_agent="$(shuf -n1 .ua)") >SRC &
		x=$! ; echo -e "💤 $ACCESS" ; sleep 2
		ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/coliseum/' | head -n1 | awk -F\' '{ print $2 }')
		EXIT=$(cat SRC | grep -o '/leaveFight/' | head -n1)
		kill -9 $x 2> /dev/null
	done
	FULL=$(cat SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | awk -F\< '{ print $2 }' | awk -F\> '{ print $2 }' | tr -cd '[[:digit:]]')
	_access
	HP3=$HP1
	ddg=9
	grss=27
	hl=40
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
# /dodge
#		echo $SRC | sed 's/href=/\n/g' | grep '/dodge' | grep 'timer' | awk -F"[:]" '{print $2}' | awk -F"[<]" '{print $1}' | tr -cd '[[:digit:]]';echo " ";
#		echo "$ddg $grss $hl"
		if [[ $ddg -ge 9 && $hl -ne 40 && $HP3 -ne $HP1 ]] ; then
			echo $($SOURCE "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x1=$! ; echo "🛡️ $URL$DODGE" ; sleep 1.45
			_access
			ddg=0
			HP3=$HP1
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /heal
		elif [[ $hl -ge 40 && $HP1 -le $HLHP ]] ; then
			echo $($SOURCE "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x2=$! ; echo -e "HP < $HPER%\n🆘 $URL$HEAL" ; sleep 1.35
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
#			SRC=$($SOURCE "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)")
#			_access
#			grss=0
#			sleep $ITVL
#			ddg=$[$ddg+1]
#			hl=$[$hl+1]
#			grss=$[$grss+1]
# /stone
#		[[ `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP2 ]]
#			echo '💪'
#			SRC=$($SOURCE "$URL$STONE" -o user_agent="$(shuf -n1 .ua)")
#			_access
#			sleep $ITVL
#			ddg=$[$ddg+1]
#			hl=$[$hl+1]
#			grss=$[$grss+1]
# /random
		elif [[ -n $(grep -o "$USER" $TMP/allies.txt) || `expr $HP1 + $HP1 \* $RPER \/ 100` -le $HP2 && $ddg -ne 9 && $hl -ne 40 ]] ; then
			echo $($SOURCE "$URL$ATKRND" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x3=$! ; echo -e "$USER\n🔁 $URL$ATKRND" ; sleep 1.15
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]

# /atk
		else
			echo $($SOURCE "$URL$ATK" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x4=$! ; echo "🎯 $URL$ATK" ; sleep 1.15
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
		fi
		kill -9 $x1 $x2 $x3 $x4 2> /dev/null
	done
	unset HPER RPER ITVL ACCESS EXIT FULL HP3 ddg hl grss
# /view
	echo ""
	$PAGE $URL/coliseum/ -o user_agent="$(shuf -n1 .ua)" | head -n11 | tail -n6 | sed "/\[2hit/d;/\[str/d;/combat/d" | grep --color "$ACC" &
	x=$! ; sleep 5
	_unset
	echo 'Coliseum (✔)'
	kill -9 $x 2> /dev/null
}
