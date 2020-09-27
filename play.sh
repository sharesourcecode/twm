_play () {
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
		_msgs
	}
# /game time
	L=$(echo {1..4} | sed 's, ,\n,g' | shuf -n1)
	case $(date +%H:%M) in
# /Valley of the Immortals 10:00:00 - 16:00:00 - 22:00:00
		(09:59|15:59|21:59)
			_msgs
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
			_crono ;;
# /Battle of banners 10:15:00 - 16:15:00
#		(10:14|16:14)
#			_msgs
#			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/flagfight/enterFight" -o user_agent="$(shuf -n1 .ua)")
#			until [[ $(date +%M:%S) = 14:5* ]] ; do
#				echo 'Battle of banners will be started...'
#				sleep 1
#				[[ $(date +%M) > 15 ]] && break
#			done
#			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/flagfight/enterFight" -o user_agent="$(shuf -n1 .ua)")
#			_flagfight
#			_crono ;;
# /Clan coliseum 10:30:00 - 15:00:00
		(10:29|14:59)
			_msgs
			until [[ $(date +%M:%S) = *9:5* ]] ; do
				echo 'Clan coliseum will be started...'
				sleep 1
				[[ $(date +%M) = 00 ]] && break
			done
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/clancoliseum/?close=reward" -o user_agent="$(shuf -n1 .ua)")
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/clancoliseum/enterFight" -o user_agent="$(shuf -n1 .ua)")
			_clancoliseum
			_crono ;;
# /Clan tournament 11:00:00 - 19:00:00
		(10:59|18:59)
			_msgs
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/clanfight/enterFight" -o user_agent="$(shuf -n1 .ua)")
			until [[ $(date +%M:%S) = 59:40 ]] ; do
				echo 'Clan tournament will be started...'
				sleep 1
				[[ $(date +%M) = 00 ]] && break
			done
			_clanfight
			_crono ;;
# /King of the Immortals 12:30:00 - 16:30:00 - 22:30:00
		(12:29|16:29|22:29)
			_msgs
			[[ -n $ALD ]] && {
			_alliesID
			_members
			}
			until [[ $(date +%M:%S) = 29:5* ]] ; do
				echo 'King of the Immortals will be started...'
				sleep 1
				[[ $(date +%M) > 30 ]] && break
			done
			SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/king/enterGame" -o user_agent="$(shuf -n1 .ua)")
			_king
			_arena
			_crono ;;
# /Ancient Altars 14:00:00 - 21:00:00
		(13:59|20:59)
			_msgs
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
			_crono ;;
		(0[0123456789]:[01234]$L|1[0248]:[01234]$L|20:[01234]$L|1[13579]:[234]$L|2[13]:[234]$L)
			_msgs ;
			_all ;
			_coliseum ;
			_crono ;;
		(*)
			_sleep ;
			_crono ;;
	esac
	unset L SRC
}
