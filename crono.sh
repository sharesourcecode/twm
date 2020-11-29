# /time
_crono () {
	HOUR=`date +%H`
	[[ $HOUR = 00 ]] && HOUR=0
	[[ $HOUR = 01 ]] && HOUR=1
	[[ $HOUR = 02 ]] && HOUR=2
	[[ $HOUR = 03 ]] && HOUR=3
	[[ $HOUR = 04 ]] && HOUR=4
	[[ $HOUR = 05 ]] && HOUR=5
	[[ $HOUR = 06 ]] && HOUR=6
	[[ $HOUR = 07 ]] && HOUR=7
	[[ $HOUR = 08 ]] && HOUR=8
	[[ $HOUR = 09 ]] && HOUR=9
	MIN=`date +%M`
	[[ $MIN = 00 ]] && MIN=0
	[[ $MIN = 01 ]] && MIN=1
	[[ $MIN = 02 ]] && MIN=2
	[[ $MIN = 03 ]] && MIN=3
	[[ $MIN = 04 ]] && MIN=4
	[[ $MIN = 05 ]] && MIN=5
	[[ $MIN = 06 ]] && MIN=6
	[[ $MIN = 07 ]] && MIN=7
	[[ $MIN = 08 ]] && MIN=8
	[[ $MIN = 09 ]] && MIN=9
	echo -e "\n $URL ⏰ $HOUR:$MIN\n"
}
_cat () {
	_crono
	[[ $HOUR -lt 6 ||  $HOUR -ge 18 ]] && \
	echo -ne "\033[33m\033" || \
	echo -ne "\033[36m\033"
	cat $TMP/msgs.txt
	echo -ne "\033[37m\033"
}
_sleep () {
	if [[ $(date +%d) = 01 && $(date +%H) = 0[012345678] ]] ; then
		echo Arena & _arena
		sleep 30
		echo Coliseum & _coliseum
		sleep 300
		reset
		clear
		_cat
		sleep 290
	elif [[ $(date +%M) = [25][89] ]] ; then
		reset
		clear
		_cat
		echo ' No battles now, waiting 15s' && sleep 15
	elif [[ $(date +%M) = [012345]7 ]] ; then
		reset
		clear
		_cat
		echo ' No battles now, waiting 1m' && sleep 1m
	elif [[ $(date +%M) = [012345]6 ]] ; then
		reset
		clear
		_cat
		echo ' No battles now, waiting 2m' && sleep 2m
	elif [[ $(date +%M) = [012345]5 ]] ; then
		reset
		clear
		_cat
		echo ' No battles now, waiting 3m' && sleep 3m
	elif [[ $(date +%M) = [012345]4 ]] ; then
		reset
		clear
		_cat
		echo ' No battles now, waiting 4m' && sleep 4m
	else
		reset
		clear
		_cat
		echo ' No battles now, waiting 30s' && sleep 29
		break &> /dev/null
	fi
}
