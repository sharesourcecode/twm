# /clan id
_clanid () {
	SRC=$($SOURCE "$URL/clan" -o user_agent="$(shuf -n1 .ua)")
	CLD=$(echo $SRC | sed "s/\/clan\//\\n/g" | grep 'built\/' | awk -F\/ '{ print $1 }')
	unset SRC
}
