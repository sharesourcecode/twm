# /clan id
_clanid () {
	echo $($SOURCE "$URL/clan" -o user_agent="$(shuf -n1 .ua)") >CLD &
	x=$! ; sleep 3 && kill -9 $x &> /dev/null
	CLD=$(cat CLD | sed "s/\/clan\//\\n/g" | grep 'built\/' | awk -F\/ '{ print $1 }')
}
