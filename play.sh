_play () {
	_all () {
#		_AtakeHelp
		echo Arena & _arena
		sleep 3
		echo "Open Chest..." & _openChest
		sleep 3
#		_AdeleteEnd
		echo "Cave..." & _cave
		sleep 3
		echo "Campaign..." & _campaign
		sleep 3
		echo "Career..." & _career
		sleep 3
		echo "Clan Dungeon..." & _clandungeon
		sleep 3
		echo "Trade..." &_trade
		sleep 3
		echo "Clan Money..." & _money
		sleep 3
#		_built
		echo "" & _msgs
		sleep 5
	}
# /game time
	L=$(echo {1..4} | sed 's, ,\n,g' | shuf -n1)
	case $(date +%H:%M) in
# /Valley of the Immortals 10:00:00 - 16:00:00 - 22:00:00
		(09:59|15:59|21:59)
			echo "" & _msgs
			sleep 3
#			_AtakeHelp
			_fullmana
#			_AdeleteEnd
			until [[ $(date +%M:%S) = 59:5* ]] ; do
				echo 'Valley of the Immortals will be started...'
				sleep 1
				[[ $(date +%M) > 00 ]] && break
			done
			echo $($SOURCE "$URL/undying/enterGame" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x=$! ; sleep 5 && kill -9 $x &> /dev/null
			echo "Undying..." & _undying
			sleep 30
			_crono ;;
# /Battle of banners 10:15:00 - 16:15:00
		(10:14|16:14)
#			_msgs
			echo $($SOURCE "$URL/flagfight/enterFight" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x=$! ; sleep 5 && kill -9 $x &> /dev/null
			until [[ $(date +%M:%S) = 14:5* ]] ; do
				echo 'Battle of banners will be started...'
				sleep 1
				[[ $(date +%M) > 15 ]] && break
			done
			echo $($SOURCE "$URL/flagfight/enterFight" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x=$! ; sleep 5 && kill -9 $x &> /dev/null
			_flagfight
			_crono ;;
# /Clan coliseum 10:30:00 - 15:00:00
		(10:29|14:59)
			echo "" & _msgs
			sleep 3
			until [[ $(date +%M:%S) = *9:5* ]] ; do
				echo 'Clan coliseum will be started...'
				sleep 1
				[[ $(date +%M) = 00 ]] && break
			done
			echo $($SOURCE "$URL/clancoliseum/?close=reward" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x=$! ; sleep 5 && kill -9 $x &> /dev/null
			echo $($SOURCE "$URL/clancoliseum/enterFight" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x=$! ; sleep 5 && kill -9 $x &> /dev/null
			echo "Clan Coliseum..." & _clancoliseum
			sleep 30
			_crono ;;
# /Clan tournament 11:00:00 - 19:00:00
		(10:59|18:59)
			echo "" & _msgs
			sleep 3
			echo $($SOURCE "$URL/clanfight/enterFight" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x=$! ; sleep 5 && kill -9 $x &> /dev/null
			until [[ $(date +%M:%S) = 59:40 ]] ; do
				echo 'Clan tournament will be started...'
				sleep 1
				[[ $(date +%M) = 00 ]] && break
			done
			echo "Clan Fight..." & _clanfight
			sleep 30
			_crono ;;
# /King of the Immortals 12:30:00 - 16:30:00 - 22:30:00
		(12:29|16:29|22:29)
			echo "" & _msgs
			sleep 3
			until [[ $(date +%M:%S) = 29:5* ]] ; do
				echo 'King of the Immortals will be started...'
				sleep 1
				[[ $(date +%M) > 30 ]] && break
			done
			echo $($SOURCE "$URL/king/enterGame" -o user_agent="$(shuf -n1 .ua)") >SRC &
			x=$! ; sleep 5 && kill -9 $x &> /dev/null
			echo "King..." & _king
			sleep 30
			echo "Arena..." & _arena
			sleep 30
			_crono ;;
# /Ancient Altars 14:00:00 - 21:00:00
		(13:59|20:59)
			echo "" & _msgs
			sleep 3
			if [[ $(date +%H) = 13 ]] ; then
#				_AtakeHelp
				echo "" & _fullmana
#				_AdeleteEnd
			fi
			until [[ $(date +%M:%S) = 59:5* ]] ; do
				echo 'Ancient Altars will be started...'
				sleep 1
				[[ $(date +%M) = 00 ]] && break
			done
			echo $($SOURCE "$URL/altars/enterFight" -o user_agent="$(shuf -n1 .ua)") >SRC &
			echo "Altars..." & _altars
			sleep 30
			_crono ;;
		(0[0123456789]:[01234]$L|1[0248]:[01234]$L|20:[01234]$L|1[13579]:[234]$L|2[13]:[234]$L)
			echo "" & _msgs
			sleep 3
			_all ;
			echo "Coliseum..." & _coliseum
			sleep 30
			_crono ;;
		(*)
			_sleep ;
			_crono ;;
	esac
	unset L
}
