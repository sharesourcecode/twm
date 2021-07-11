_king () {
# /enterFight
	HPER='50'
	RPER='1'
	_show () {
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
	echo -e "\nKing"
	echo $URL
	echo $($SOURCE $URL/king/enterGame -o user_agent="$(shuf -n1 .ua)") >SRC &
	sleep 3
	ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/king/' | head -n1 | awk -F"[']" '{ print $2 }')
	echo -e " 👣 Entering...\n$ACCESS"
# /wait
	echo " 😴 Waiting..."
	echo $($SOURCE "$URL/king/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)") >SRC &
	sleep 3
        EXIT=$(cat SRC | grep -o 'king/kingatk/')
	while [[ -z $EXIT ]] ; do
		[[ $(date +%M) = 30 && $(date +%S) > 19 ]] && break
		echo -e " 💤	...\n$ACCESS"
		echo $($SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
		sleep 4
		ACCESS=$(cat SRC | sed 's/href=/\n/g' | grep '/king/' | head -n1 | awk -F"[']" '{ print $2 }')
		EXIT=$(cat SRC | grep -o 'king/kingatk/')
		killall -q -9 w3m
	done
# /game
	FULL=$(cat SRC | sed "s/alt/\\n/g" | grep "hp" | head -n1 | awk -F\< '{ print $2 }' | awk -F\> '{ print $2 }' | tr -cd "[[:digit:]]")
	_access
	HP3=$HP1
	ddg=9
	grss=27
	hl=0
	until [[ -z $OUTGATE && -z $ATK ]]; do
#	until [[ $(date +%M) = 4[01] ]]; do
# /dodge
		if [[ $HP3 -lt $HP1 && $ddg -ge 9 ]]; then
			echo '🛡️'
			echo $($SOURCE "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)") >SRC &
			sleep 1.20
			ddg=0
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
			HP3=$HP1
# /kingatk
#		elif [[ -n $KINGATK ]]; then
#			echo '👑'
#			echo $($SOURCE "$URL$KINGATK" -o user_agent="$(shuf -n1 .ua)") >SRC &
#			sleep 1.8
#			_access
#			ddg=$[$ddg+1]
#			hl=$[$hl+1]
#			grss=$[$grss+1]
# /heal
		elif [[ $HP1 -le $HLHP && $hl -le 41 ]]; then
			echo "🆘 HP < $HPER%"
			echo $($SOURCE "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)") >SRC &
			sleep 1.45
			hl=0
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /random
		elif [[ $hl -ne 41 && -n $(grep "$USER" $TMP/allies.txt) ]]; then
			echo "🔁$USER"
			echo $($SOURCE "$URL$ATKRND" -o user_agent="$(shuf -n1 .ua)") >SRC &
			sleep 1.20
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
# /atk
		else
			echo '🎯'
#			echo '👑'
			echo $($SOURCE "$URL$ATK" -o user_agent="$(shuf -n1 .ua)") >SRC &
			sleep 1.20
			_access
			ddg=$[$ddg+1]
			hl=$[$hl+1]
			grss=$[$grss+1]
		fi
		killall -q -9 w3m
	done
	unset HPER RPER ITVL ACCESS EXIT FULL HP3 ddg hl grss
# /view
	echo ""
	$PAGE $URL/king -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | sed "/\[U\]/d;/\[arrow\]/d;/\ \[/d" | grep --color $ACC &
	sleep 5
	_unset
	echo "King (✔)"
	killall -q -9 w3m
	sleep 25
}
