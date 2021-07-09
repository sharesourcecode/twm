_coliseum () {
# /enterFight
	echo -e "\nColiseum ..."
	echo $($PAGE $URL/settings/graphics/0 -o user_agent="$(shuf -n1 .ua)") >SRC &
	echo -e "/settings/graphics/0\n" ; sleep 3
	HPER='30'
	RPER='20'
	_show () {
		YOU=$(cat SRC | grep -o -P "\p{Lu}{1}\p{Ll}{0,15}[\ ]{0,1}\p{L}{0,14}\s\Ws" | sed -n 's,\ [<]s,,;s,\ ,_,;1p')
		USER=$(cat SRC | grep -o -P "\p{Lu}{1}\p{Ll}{0,15}[\ ]{0,1}\p{L}{0,14}\s\Ws" | sed -n 's,\ [<]s,,;s,\ ,_,;2p')
		HP1=$(cat SRC | grep -o -P "(hp)\W{1,4}\d{1,6}" | sed "s,hp[']\/[>],,;s,\ ,,")
		HP2=$(cat SRC | grep -o -P "(nbsp)\W{1,2}\d{1,6}" | sed 's,nbsp[;],,;s,\ ,,')
		[[ -n $OUTGATE ]] && {
			[[ $HP1 -gt 0 && $HP2 -gt 0 ]] && echo -e "$YOU: $HP1 - $HP2 :$USER\n"
			[[ $HP1 -eq 0 ]] && echo -e "$YOU: 💀 - $HP2 :$USER\n"
			[[ $HP2 -eq 0 ]] && echo -e "$YOU: $HP1 - 💀 :$USER\n"
		}
}
	$PAGE $URL/coliseum -o user_agent="$(shuf -n1 .ua)" | head -n11 | tail -n7 | sed "/\[2hit/d;/\[str/d;/combat/d" &
	echo "/coliseum" ; sleep 3
	echo $($SOURCE "$URL/coliseum/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)") >SRC &
	echo '/coliseum/?close_clan_msg=true' ; sleep 2
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/enterFight/' | head -n1 | awk -F\' '{ print $2 }')
	echo -e " 👣 Entering...\n$ACCESS"
	echo $($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
	echo "$ACCESS" ; sleep 3
	killall -q -9 w3m
# /wait
	echo "😴 Waiting..."
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/coliseum/' | head -n1 | awk -F\' '{ print $2 }')
        EXIT=$(cat SRC | grep -o '/leaveFight/' | head -n1)
	while [[ -n $EXIT ]] ; do
		echo $($SOURCE $URL/coliseum -o user_agent="$(shuf -n1 .ua)") >SRC &
		echo -e "💤 $ACCESS" ; sleep 2
		ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/coliseum/' | head -n1 | awk -F\' '{ print $2 }')
		EXIT=$(cat SRC | grep -o '/leaveFight/' | head -n1)
		killall -q -9 w3m
	done
	FULL=$(cat SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | awk -F\< '{ print $2 }' | awk -F\> '{ print $2 }' | tr -cd '[[:digit:]]')
	_access
	HP3=$HP1
	ddg=9
#	grss=27
	hl=40
	until [[ -n "$BEXIT" && -z "$OUTGATE" ]] ; do
# /dodge
#		echo $SRC | sed 's/href=/\n/g' | grep '/dodge' | grep 'timer' | awk -F"[:]" '{print $2}' | awk -F"[<]" '{print $1}' | tr -cd '[[:digit:]]';echo " ";
#		echo "$ddg $grss $hl"
		if [[ $ddg -ge 9 && $hl -ne 40 && $HP3 -ne $HP1 ]] ; then
			echo $($SOURCE "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)") >SRC &
			echo "🛡️ $DODGE" ; sleep 1.45
			_access
			ddg=0
			HP3=$HP1
			ddg=$[$ddg+1]
			hl=$[$hl+1]
#			grss=$[$grss+1]
# /heal
		elif [[ "$hl" -ge 40 && "$HP1" -le "$HLHP" ]] ; then
			echo $($SOURCE "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)") >SRC &
			echo -e "HP < $HPER%\n🆘 $HEAL" ; sleep 1.35
			_access
			hl=0
			ddg=$[$ddg+1]
			hl=$[$hl+1]
#			grss=$[$grss+1]
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
		elif [[ -n $(grep -o "$USER" $TMP/allies.txt) || `expr "$HP1" + "$HP1" \* "$RPER" \/ 100` -le "$HP2" && "$ddg" -ne 9 && "$hl" -ne 40 ]] ; then
			echo $($SOURCE "$URL$ATKRND" -o user_agent="$(shuf -n1 .ua)") >SRC &
			echo -e "$USER\n🔁 $ATKRND" ; sleep 1.15
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
#			grss=$[$grss+1]

# /atk
		else
			echo $($SOURCE "$URL$ATK" -o user_agent="$(shuf -n1 .ua)") >SRC &
			echo "🎯 $ATK" ; sleep 1.15
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
#			grss=$[$grss+1]
		fi
		killall -q -9 w3m
	done
	unset HPER RPER ITVL ACCESS EXIT FULL HP3 ddg hl grss
# /view
	echo ""
	$PAGE $URL/coliseum/ -o user_agent="$(shuf -n1 .ua)" | head -n11 | tail -n6 | sed "/\[2hit/d;/\[str/d;/combat/d" | grep --color "$ACC" &
	sleep 5
	_unset
	echo 'Coliseum (✔)'
	killall -q -9 w3m
}
