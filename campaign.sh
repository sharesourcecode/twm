# /campaign
_campaign () {
	echo "campaign ..."
	echo $($SOURCE "$URL/campaign" -o user_agent="$(shuf -n1 .ua)") >SRC &
	sleep 5
	ENTER=$(cat SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }' | awk -F\/ '{ print $3 }')
	ACCESS=$(cat SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }')
	while [[ -n $ENTER && -n $ACCESS ]]; do
		echo $($SOURCE $URL$ACCESS -o user_agent="$(shuf -n1 .ua)") >SRC &
		sleep 3
		ENTER=$(cat SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }' | awk -F\/ '{ print $3 }')
		ACCESS=$(cat SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }')
		echo "$ACCESS"
		killall -q -9 w3m
	done
	unset ENTER ACCESS
	echo -e "campaign (✔)\n"
}
