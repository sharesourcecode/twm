_proxy () {
#Obtains proxy from the official server.
	SPROXY=$(dig $URL | grep -oP '(\d+.\d+.\d+.\d+.\d+)' | sed 's/^.*$/&:443/' | head -n1)
	PROXY="https://$SPROXY"
	unset SPROXY
	echo -e "\e[01;30m\e[01;07m Server: $URL|$PROXY \e[00m"
	sleep 3
#Use w3m -o http_proxy=$PROXY $URL...
}
