func_trade () {
 printf "trade ...\n"
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/trade/exchange" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
 ) &
 time_exit 17
 #/trade/exchange/silver/4?r=26272047
 local ACCESS=$(grep -o -E '/trade/exchange/silver/[0-9]+[?]r[=][0-9]+' $TMP/SRC|head -n 1)
 local BREAK=$(( $(date +%s) + 30 ))
 until [ -z "$ACCESS" ] || [ "$(date +%s)" -gt "$BREAK" ] ; do
  printf "$ACCESS\n"
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$ACCESS" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
  ) &
  time_exit 17
  local ACCESS=$(grep -o -E '/trade/exchange/silver/[0-9]+[?]r[=][0-9]+' $TMP/SRC|head -n 1)
 done
 printf "${GREEN_BLACK}trade (✔)${COLOR_RESET}\n"
}
clan_money () {
 clan_id
 if [ -n "$CLD" ] ; then
  printf "clan money ...\n"
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/arena/quit" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|sed "s/href='/\n/g"|grep "attack/1"|head -n 1|awk -F\/ '{ print $5 }'|tr -cd "[[:digit:]]" >$TMP/CODE
  ) &
  time_exit 17
  printf "/clan/${CLD}/money/?r=`cat $TMP/CODE`&silver=1000&gold=0&confirm=true&type=limit\n"
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug "${URL}/clan/${CLD}/money/?r=`cat $TMP/CODE`&silver=1000&gold=0&confirm=true&type=limit" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n 0
  ) &
  time_exit 17
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/arena/quit" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|sed "s/href='/\n/g"|grep "attack/1"|head -n 1|awk -F\/ '{ print $5 }'|tr -cd "[[:digit:]]" >$TMP/CODE
  ) &
  time_exit 17
  printf "/clan/${CLD}/money/?r=`cat $TMP/CODE`&silver=1000&gold=0&confirm=true&type=limit\n"
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug "${URL}/clan/${CLD}/money/?r=`cat $TMP/CODE`&silver=1000&gold=0&confirm=true&type=limit" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n 0
  ) &
  time_exit 17
  printf "clan money (✔)\n"
 fi
}
clan_statue () {
 clan_id
 if [ -n "$CLD" ] ; then
  printf "clan built ...\n"
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/arena/quit" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|sed "s/href='/\n/g"|grep "attack/1"|head -n 1|awk -F\/ '{ print $5 }'|tr -cd "[[:digit:]]" >$TMP/CODE
  ) &
  time_exit 17
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug "${URL}/clan/${CLD}/built/?goldUpgrade=true&r=`cat $TMP/CODE`" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n 0
  ) &
  time_exit 17
  printf "/clan/${CLD}/built/?goldUpgrade=true&r=`cat $TMP/CODE`\n"
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/arena/quit" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|sed "s/href='/\n/g"|grep "attack/1"|head -n 1|awk -F\/ '{ print $5 }'|tr -cd "[[:digit:]]" >$TMP/CODE
  ) &
  time_exit 17
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug "${URL}/clan/${CLD}/built/?silverUpgrade=true&r=`cat $TMP/CODE`" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n 0
  ) &
  time_exit 17
  printf "/clan/${CLD}/built/?silverUpgrade=true&r=`cat $TMP/CODE`\n"
  printf "clan built (✔)\n"
 fi
}
