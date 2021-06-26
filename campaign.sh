# /campaign
_campaign () {
	echo $($SOURCE "$URL/campaign" -o user_agent="$(shuf -n1 .ua)") >SRC &
	x=$! ; sleep 5 && kill -9 $x &> /dev/null
	ENTER=$(cat SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }' | awk -F\/ '{ print $3 }')
	ACCESS=$(cat SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }')
	while [[ -n $ENTER && -n $ACCESS ]]; do
		echo $($SOURCE $URL$ACCESS -o user_agent="$(shuf -n1 .ua)") >SRC &
		x=$! ; sleep 3 && kill -9 $x &> /dev/null
		ENTER=$(cat SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }' | awk -F\/ '{ print $3 }')
		ACCESS=$(cat SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }')
		echo "$ACCESS"
	done
	unset ENTER ACCESS
}
