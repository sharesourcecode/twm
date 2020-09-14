_proxy () {
#Obtains proxy from the official server.
	SPROXY=$(dig $URL | grep -oP '(\d+.\d+.\d+.\d+.\d+)' | sed 's/^.*$/&:80/' | head -n1)
	PROXY="http://$SPROXY"
	unset SPROXY
	echo "Server: $URL|$PROXY"
	case $URL in
		(tiwar.net)
		URL='http://tiwar.net' ;;
	esac
#Use w3m -o http_proxy=$PROXY $URL...
}
