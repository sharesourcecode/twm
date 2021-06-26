# /trade
_trade () {
	echo "Checking for gold exchange..."
	echo $($SOURCE "$URL/trade/exchange" -o user_agent="$(shuf -n1 .ua)") >SRC &
	x=$! ; sleep 5 && kill -9 $x &> /dev/null
	ACCESS=$(cat SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| grep 'silver/1' | head -n1 | awk -F\= '{ print $2 }' | awk -F\' '{ print $1 }')
	EXIST=$(cat SRC | sed "s/\/trade/\\n/g" | grep 'exchange' | grep 'silver/1' | head -n1 | awk -F\/ '{ print $3 }')
	while [[ -n $EXIST ]]; do
		echo $($SOURCE "$URL/trade/exchange/silver/1?r=$ACCESS" -o user_agent="$(shuf -n1 .ua)") >SRC &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
		ACCESS=$(cat SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| grep 'silver/1' | head -n1 | awk -F\= '{ print $2 }' | awk -F\' '{ print $1 }')
		EXIST=$(cat SRC | sed "s/\/trade/\\n/g" | grep 'exchange' | grep 'silver/1' | head -n1 | awk -F\/ '{ print $3 }')
		echo -e "/trade/exchange/silver/1?r=$ACCESS"
	done
	unset ACCESS EXIST
	echo -e "Exchange (✔)\n"
}
_money () {
	if [[ -n $CLD ]] ; then
		echo $($SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]") >CODE &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
		echo -e "/clan/$CLD/money/?r=`cat CODE`&silver=1000&gold=2&confirm=true&type=limit"
		$DUMP "$URL/clan/$CLD/money/?r=`cat CODE`&silver=1000&gold=1&confirm=true&type=limit" -o user_agent="$(shuf -n1 .ua)" &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
		echo $($SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]") >CODE &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
		echo -e "/clan/$CLD/money/?r=`cat CODE`&silver=0&gold=1&confirm=true&type=limit"
		$DUMP "$URL/clan/$CLD/money/?r=`cat CODE`&silver=1000&gold=1&confirm=true&type=limit" -o user_agent="$(shuf -n1 .ua)" &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
		echo -e "Clan Money (✔)\n"
	fi
}
_built () {
	if [[ -n $CLD ]] ; then
		echo $($SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]") >CODE &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
		echo -e "/clan/$CLD/built/?goldUpgrade=true&r=`cat CODE`"
		$DUMP "$URL/clan/$CLD/built/?goldUpgrade=true&r=`cat CODE`" -o user_agent="$(shuf -n1 .ua)" &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
		echo $($SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]") >CODE &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
		echo -e "/clan/$CLD/built/?silverUpgrade=true&r=`cat CODE`"
		$DUMP "$URL/clan/$CLD/built/?silverUpgrade=true&r=`cat CODE`" -o user_agent="$(shuf -n1 .ua)" &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
		echo -e "Clan Built upgrade (✔)\n"
	fi
}
