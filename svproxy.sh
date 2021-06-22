_proxy () {
#Obtains proxy from the official server.
	SPROXY=$(dig $URL | grep -oP '(\d+.\d+.\d+.\d+.\d+)' | sed 's/^.*$/&:443/' | head -n1)
	PROXY="https://$SPROXY"
	unset SPROXY
	echo "Server: $URL|$PROXY"
#	case $URL in
#		(tiwar.net)
#		URL='http://tiwar.net' ;;
#	esac
#Use w3m -o http_proxy=$PROXY $URL...
}
