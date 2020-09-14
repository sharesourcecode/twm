_play () {
#	_coliseum #for test
	_msgs () {
		echo -e "# Latest posts:" >msgs.txt
		$PAGE $URL -o user_agent="$(shuf -n1 .ua)" | head -n3 | sed "/\[/d;/\|/d" >> msgs.txt
		$PAGE $URL/mail -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 >> msgs.txt
		$PAGE $URL -o user_agent="$(shuf -n1 .ua)" | grep -oP '(lvl\s\d+|g\s\d\S+|s\s\d\S+$)' | sed ':a;N;s/\n//g;ta' | sed 's/lvl/\n\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ lvl/g;s/g/\ g/g;s/s/\ s/g' >> msgs.txt
	}
	_msgs
	_all () {
#		_AtakeHelp
		_arena
		_openChest
#		_AdeleteEnd
		_cave
		_campaign
		_career
		_clandungeon
		_trade
		_money
#		_built
	}
# /game time
	L=$(echo {0..3} | sed 's, ,\n,g' | shuf -n1)
	case $(date +%H:%M) in
# /Valley of the Immortals 10:00:00 - 16:00:00 - 22:00:00
		(09:59|15:59|21:59)
#			_AtakeHelp
			_fullmana
#			_AdeleteEnd
			until [[ $(date +%M:%S) = 59:5* ]] ; do
				echo 'Valley of the Immortals will be started...'
				sleep 1
				[[ $(date +%M) > 00 ]] && break
			done
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/undying/enterGame" -o user_agent="$(shuf -n1 .ua)")
			_undying
			_msgs
			_crono ;;
# /Battle of banners 10:15:00 - 16:15:00
#		(10:14|16:14)
#			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/flagfight/enterFight" -o user_agent="$(shuf -n1 .ua)")
#			until [[ $(date +%M:%S) = 14:5* ]] ; do
#				echo 'Battle of banners will be started...'
#				sleep 1
#				[[ $(date +%M) > 15 ]] && break
#			done
#			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/flagfight/enterFight" -o user_agent="$(shuf -n1 .ua)")
#			_flagfight
#			_msgs
#			_crono ;;
# /Clan coliseum 10:30:00 - 15:00:00
		(10:29|14:59)
			until [[ $(date +%M:%S) = *9:5* ]] ; do
				echo 'Clan coliseum will be started...'
				sleep 1
				[[ $(date +%M) = 00 ]] && break
			done
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/clancoliseum/?close=reward" -o user_agent="$(shuf -n1 .ua)")
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/clancoliseum/enterFight" -o user_agent="$(shuf -n1 .ua)")
			_clancoliseum
			_msgs
			_crono ;;
# /Clan tournament 11:00:00 - 19:00:00
		(10:59|18:59)
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/clanfight/enterFight" -o user_agent="$(shuf -n1 .ua)")
			until [[ $(date +%M:%S) = 59:40 ]] ; do
				echo 'Clan tournament will be started...'
				sleep 1
				[[ $(date +%M) = 00 ]] && break
			done
			_clanfight
			_msgs
			_crono ;;
# /King of the Immortals 12:30:00 - 16:30:00 - 22:30:00
		(12:29|16:29|22:29)
			until [[ $(date +%M:%S) = 29:5* ]] ; do
				echo 'King of the Immortals will be started...'
				sleep 1
				[[ $(date +%M) > 30 ]] && break
			done
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/king/enterGame" -o user_agent="$(shuf -n1 .ua)")
			_king
			_arena
			_msgs
			_crono ;;
# /Ancient Altars 14:00:00 - 21:00:00
		(13:59|20:59)
			if [[ $(date +%H) = 13 ]] ; then
#				_AtakeHelp
				_fullmana
#				_AdeleteEnd
			fi
			until [[ $(date +%M:%S) = 59:5* ]] ; do
				echo 'Ancient Altars will be started...'
				sleep 1
				[[ $(date +%M) = 00 ]] && break
			done
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/altars/enterFight" -o user_agent="$(shuf -n1 .ua)")
			_altars
			_msgs
			_crono ;;
		(0[02468]:[04]$L|0[13579]:2$L|1[048]:4$L|20:[04]$L|1[13579]:2$L|2[13]:2$L|1[28]:0$L)
			_all ;
			_coliseum ;
			_msgs
			_crono ;;
		(*)
			_sleep ;
			_crono ;;
	esac
	unset L SRC
}
