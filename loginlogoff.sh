login_logoff () {
 if [ -f "$TMP/.cript_file" ] ; then
  cat $TMP/.cript_file | base64 -d >$TMP/cookie_file
  chmod 600 $TMP/cookie_file
  (
   w3m -cookie -o http_proxy=$PROXY -post $TMP/cookie_file -debug "$URL/?sign_in=1" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" &> /dev/null
  ) </dev/null &>/dev/null &
  time_exit 17
  echo 'Setting session cookie...'
  (
   w3m -cookie -o http_proxy=$PROXY -post $TMP/cookie_file -debug "$URL/?sign_in=1" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" &> /dev/null
  ) </dev/null &>/dev/null &
  time_exit 17
  echo 'Session configured.'
  rm $TMP/cookie_file &> /dev/null
 fi
 (
  w3m -cookie -o http_proxy=$PROXY -debug "$URL/user" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" | grep "\[level" | grep -o -E "[[:space:]][[:upper:]][[:lower:]]{0,15}[[:space:]]{0,1}[[:upper:]]{0,1}[[:lower:]]{0,14}[[:space:]]" >$TMP/acc_file
 ) </dev/null &>/dev/null &
 time_exit 17
 echo 'Checking if user matches...'
 sed -i 's/^[ \t]*//;s/[ \t]*$//' $TMP/acc_file
 ACC=$(cat $TMP/acc_file)
 if [ -n "$ACC" ] && [ -n "$URL" ] ; then
  local check=5
  until [ "$check" -lt 1 ] ; do
   clear
   echo "Please wait..."
   echo -e "[Wait to $ACC... (${check}s) - ENTER to other account] \n"
   local check=$((check - 1)) ; read -t1 && ACC="" && break
  done
 fi
 clear
 echo "Please wait..."
 while [ -z "$ACC" ] && [ -n "$URL" ] ; do
  log_in() {
   #/logoff
   (
    w3m -cookie -o http_proxy=$PROXY -debug "$URL/?exit" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" &> /dev/null
   ) </dev/null &>/dev/null &
   time_exit 17
   echo -e "\e[00;33m\e[01;07mIn case of error will repeat\e[00m\n"
   echo -ne "Username: "
   read username
   local prompt="Password: "
   local charcount=0
   while IFS= read -p "$prompt" -r -s -n 1 char ; do
    #/Enter - accept password
    if [ "$char" = $'\0' ] ; then
     break &> /dev/null
    fi
    #/Backspace
    if [ "$char" = $'\177' ] ; then
     if [ "$charcount" -gt 0 ] ; then
      local charcount=$((charcount - 1))
      local prompt=$(echo -n $'\b \b')
      local password=$(echo "$password" | sed 's/.$//')
     else
      local prompt=$(echo -n '')
     fi
    else
     local charcount=$((charcount + 1))
     local prompt=$(echo -n '*')
     local password="${password}${char}"
    fi
   done
   echo -e "\n	Please wait..."
   #/cryptography
   if [ -z "$ACC" ] ; then
#    echo "login=$username&pass=$password" | openssl enc -aes-256-cbc -md sha512 -a -pbkdf2 -iter 100000 -salt -pass pass:"　 　$username" > $TMP/.cript_file
    echo "login=$username&pass=$password" | base64 -w0 > $TMP/.cript_file
    chmod 600 $TMP/.cript_file
    #/decryption
#    cat $TMP/.cript_file | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -salt -pass pass:"　 　$username" >$TMP/cookie_file
    cat $TMP/.cript_file | base64 -d >$TMP/cookie_file
    chmod 600 $TMP/cookie_file
   else
#    cat $TMP/.cript_file | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -salt -pass pass:"　 　$ACC" >$TMP/cookie_file
    cat $TMP/.cript_file | base64 -d >$TMP/cookie_file
    chmod 600 $TMP/cookie_file
   fi
   #/login2x
   unset username password
   (
    w3m -cookie -o http_proxy=$PROXY -post $TMP/cookie_file -debug "$URL/?sign_in=1" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" &> /dev/null
   ) </dev/null &>/dev/null &
   time_exit 17
   echo 'Setting session cookie...'
   (
    w3m -cookie -o http_proxy=$PROXY -post $TMP/cookie_file -debug "$URL/?sign_in=1" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" &> /dev/null
   ) </dev/null &>/dev/null &
   time_exit 17
   echo 'Session configured.'
   rm $TMP/cookie_file &> /dev/null
  }
  log_in
  clear
  echo "Please wait..."
  (
   w3m -cookie -o http_proxy=$PROXY -debug "$URL/user" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" | grep "\[level" | grep -o -E "[[:space:]][[:upper:]][[:lower:]]{0,15}[[:space:]]{0,1}[[:upper:]]{0,1}[[:lower:]]{0,14}[[:space:]]" >$TMP/acc_file
  ) </dev/null &>/dev/null &
  time_exit 17
  echo 'Checking if user matches...'
  ACC=$(cat $TMP/acc_file)
  if [ -n "$ACC" ] ; then
   break &> /dev/null
  fi
 done
 messages_info
}
