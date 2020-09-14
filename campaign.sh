# /campaign
_campaign () {
	SRC=$($SOURCE -o accept_encoding=="*;q=0" "$URL/campaign" -o user_agent="$(shuf -n1 .ua)")
	ENTER=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }' | awk -F\/ '{ print $3 }')
	ACCESS=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }')
	while [[ -n $ENTER && -n $ACCESS ]]; do
		SRC=$($SOURCE -o accept_encoding=="*;q=0" $URL$ACCESS -o user_agent="$(shuf -n1 .ua)")
		ENTER=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }' | awk -F\/ '{ print $3 }')
		ACCESS=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }')
		echo "$ACCESS"
	done
	unset SRC ENTER ACCESS
}
