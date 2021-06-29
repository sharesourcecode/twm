# /trade
_trade () {
	echo "trade"
	echo $($SOURCE "$URL/trade/exchange" -o user_agent="$(shuf -n1 .ua)") >SRC &
	sleep 5
	ACCESS=$(cat SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| grep 'silver/1' | head -n1 | awk -F\= '{ print $2 }' | awk -F\' '{ print $1 }')
	EXIST=$(cat SRC | sed "s/\/trade/\\n/g" | grep 'exchange' | grep 'silver/1' | head -n1 | awk -F\/ '{ print $3 }')
	while [[ -n $EXIST ]]; do
		echo -e "/trade/exchange/silver/1?r=$ACCESS"
		echo $($SOURCE "$URL/trade/exchange/silver/1?r=$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
		sleep 3
		ACCESS=$(cat SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| grep 'silver/1' | head -n1 | awk -F\= '{ print $2 }' | awk -F\' '{ print $1 }')
		EXIST=$(cat SRC | sed "s/\/trade/\\n/g" | grep 'exchange' | grep 'silver/1' | head -n1 | awk -F\/ '{ print $3 }')
		killall -q -9 w3m
	done
	unset ACCESS EXIST
	echo -e "trade (✔)\n"
}
_money () {
	if [[ -n $CLD ]] ; then
		echo -e "clan money"
		echo $($SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]") >CODE &
		sleep 3
		echo -e "/clan/$CLD/money/?r=`cat CODE`&silver=1000&gold=2&confirm=true&type=limit"
		$PAGE "$URL/clan/$CLD/money/?r=`cat CODE`&silver=1000&gold=1&confirm=true&type=limit" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 &
		sleep 3
		echo $($SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]") >CODE &
		sleep 4
		echo -e "/clan/$CLD/money/?r=`cat CODE`&silver=0&gold=1&confirm=true&type=limit"
		$PAGE "$URL/clan/$CLD/money/?r=`cat CODE`&silver=1000&gold=1&confirm=true&type=limit" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 &
		sleep 4
		echo -e "clan money (✔)\n"
		killall -q -9 w3m
	fi
}
_built () {
	if [[ -n $CLD ]] ; then
		echo -e "clan built upgrade"
		echo $($SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]") >CODE &
		sleep 3
		echo -e "/clan/$CLD/built/?goldUpgrade=true&r=`cat CODE`"
		$PAGE "$URL/clan/$CLD/built/?goldUpgrade=true&r=`cat CODE`" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 &
		sleep 3
		echo $($SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]") >CODE &
		sleep 3
		echo -e "/clan/$CLD/built/?silverUpgrade=true&r=`cat CODE`"
		$PAGE "$URL/clan/$CLD/built/?silverUpgrade=true&r=`cat CODE`" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 &
		sleep 3
		echo -e "clan built upgrade (✔)\n"
		killall -q -9 w3m
	fi
}
