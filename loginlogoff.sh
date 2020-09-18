_loginlogoff () {
# /login/logoff
	ACC=$($PAGE -o accept_encoding=="*;q=0" "$URL/user" -o user_agent="$(shuf -n1 .ua)" | grep "\[level" | cut -d" " -f2)
	[[ -n $ACC && -n $URL ]] && i=5 && \
          until [[ $i -lt 1 ]]; do
		clear
		echo "Please wait..."
		echo -e "[Wait to $ACC... ("$i"s) - ENTER to other account] \n"
                i=$[$i-1]; read -t1 && \
		ACC="" && break
        done
	clear
	echo "Please wait..."
	while [[ -z $ACC && -n $URL ]]; do
		function _login () {
# /logoff2x
			$($PAGE -o accept_encoding=="*;q=0" "$URL/?exit" -o user_agent="$(shuf -n1 .ua)") 2&>-
			$($PAGE -o accept_encoding=="*;q=0" "$URL/?exit" -o user_agent="$(shuf -n1 .ua)") 2&>-
			unset username; unset password
			echo -e "\nIn case of error will repeat"
			echo -n 'Username: '
			read username
			echo -e "\n"
			prompt="Password: "
			charcount=0
			while IFS= read -p "$prompt" -r -s -n 1 char; do
# /Enter - accept password
			if [[ $char == $'\0' ]]; then
				break
			fi
# /Backspace
			if [[  $char  == $'\177' ]]; then
				if [ $charcount -gt 0 ]; then
					charcount=$((charcount - 1))
					prompt=$'\b \b'
					password="${password%?}"
				else
					prompt=''
				fi
			else
				charcount=$((charcount + 1))
				prompt='🔒'
				password+="$char"
			fi
			done
			echo -e "\n	Please wait..."
			echo -e "login=$username&pass=$password" >$TMP/login.txt
# /login2x
			unset username password
			$(w3m -debug -post $TMP/login.txt -o accept_encoding=="*;q=0" "$URL/?sign_in=1" -o user_agent="$(shuf -n1 .ua)") 2&>-
			$(w3m -debug -post $TMP/login.txt -o accept_encoding=="*;q=0'" "$URL/?sign_in=1" -o user_agent="$(shuf -n1 .ua)") 2&>-
		}
		_login
		rm $TMP/login.txt
		clear
		echo "Please wait..."
		ACC=$($PAGE -o accept_encoding=="*;q=0" "$URL/user" -o user_agent="$(shuf -n1 .ua)" | grep "\[level" | cut -d" " -f2)
	done
}
