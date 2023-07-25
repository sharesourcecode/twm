#/arena
#http://furiadetitas.net/marathon/take/?r=41422587

arena_fault () {
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source  "$URL/fault" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
 ) </dev/null &>/dev/null &
 time_exit 17
 local BREAK=$(( $(date +%s) + 10 ))
 while grep -q -o '/fault/attack' $TMP/SRC || [ $(date +%s) -lt "$BREAK" ] ; do
  local ACCESS=$(grep -o -E '(/fault/attack/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/SRC|sed -n '1p')
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL$ACCESS" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
  ) </dev/null &>/dev/null &
  time_exit 17
  echo $ACCESS
  sleep 1s
 done
 echo -e "fault (✔)\n"
}
arena_collFight () {
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/collfight/enterFight" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
 ) </dev/null &>/dev/null &
 time_exit 17
 if grep -q -o '/collfight/' $TMP/SRC ; then
  echo "collfight ..."
  echo "/collfight/enterFight"
  local ACCESS=$(cat $TMP/SRC|sed 's/href=/\n/g'|grep 'collfight/take'|head -n1|awk -F\' '{ print $2 }')
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL$ACCESS" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n0
  ) </dev/null &>/dev/null &
  time_exit 17
  echo "$ACCESS"
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/collfight/enterFight" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n0
  ) </dev/null &>/dev/null &
  time_exit 17
  echo "/collfight/enterFight"
  echo -e "collfight (✔)\n"
 fi
}
arena_takeHelp () {
 clan_id
 if [ -n "$CLD" ] ; then
#  (
#   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump "$URL/clan/$CLD/quest/take/3" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n0
#  ) </dev/null &>/dev/null &
#  time_exit 17
#  echo "/clan/$CLD/quest/take/3"
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump "$URL/clan/$CLD/quest/help/3" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n0
  ) </dev/null &>/dev/null &
  time_exit 17
  echo "/clan/$CLD/quest/help/3"
#  (
#   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump "$URL/clan/$CLD/quest/take/4" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n0
#  ) </dev/null &>/dev/null &
#  time_exit 17
#  echo "/clan/$CLD/quest/take/4"
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump "$URL/clan/$CLD/quest/help/4" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n0
  ) </dev/null &>/dev/null &
  time_exit 17
  echo "/clan/$CLD/quest/help/4"
 else
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump "$URL/settings/claninvite/1" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n0
  ) </dev/null &>/dev/null &
  time_exit 17
 fi
}
arena_deleteEnd () {
 clan_id
 if [ -n "$CLD" ] ; then
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump "$URL/clan/$CLD/quest/deleteHelp/3" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n0
  ) </dev/null &>/dev/null &
  time_exit 17
  echo "/clan/$CLD/quest/deleteHelp/3"
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump "$URL/clan/$CLD/quest/end/3" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n0
  ) </dev/null &>/dev/null &
  time_exit 17
  echo "/clan/$CLD/quest/end/3"
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump "$URL/clan/$CLD/quest/deleteHelp/4" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n0
  ) </dev/null &>/dev/null &
  time_exit 17
  echo "/clan/$CLD/quest/deleteHelp/4"
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump "$URL/clan/$CLD/quest/end/4" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n0
  ) </dev/null &>/dev/null &
  time_exit 17
  echo "/clan/$CLD/quest/end/4"
 else
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump "$URL/clanrating/wantedToClan" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tail -n 0
  ) </dev/null &>/dev/null &
  time_exit 17
 fi
}
arena_duel () {
# arena_collFight
# arena_fault
 echo "arena ..."
 arena_takeHelp
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/arena/" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
 ) </dev/null &>/dev/null &
 time_exit 17
 local BREAK=$(( $(date +%s) + 60 ))
 until grep -q -o 'lab/wizard' $TMP/SRC || [ $(date +%s) -gt "$BREAK" ] ; do
  icon=$(grep -q -o -A 1 "/images/icon/race/0.png" $TMP/SRC|sed -n '1p')
  local ACCESS=$(grep -o -E '(/arena/attack/1/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/SRC|sed -n '1p') #/arena/attack/1/1234567*/
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${ACCESS}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
  ) </dev/null &>/dev/null &
  time_exit 17
  echo " ⚔ $icon"
  sleep 1s
 done
 arena_deleteEnd
 echo -e "${GREEN_BLACK}arena (✔)\n${COLOR_RESET}\n"
}
arena_fullmana () {
 echo "energy arena ..."
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source ${URL}/arena/quit -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|sed "s/href='/\n/g"|grep 'attack/1'|head -n1|awk -F\/ '{ print $5 }'|tr -cd "[[:digit:]]" >ARENA
 ) </dev/null &>/dev/null &
 time_exit 17
 echo " ⚔ - 1 Attack..."
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/arena/attack/1/?r=`cat ARENA`" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|sed "s/href='/\n/g"|grep 'arena/lastPlayer'|head -n1|awk -F\' '{ print $1 }'|tr -cd "[[:digit:]]" >ATK1
 ) </dev/null &>/dev/null &
 time_exit 17
 echo " ⚔ - Full Attack..."
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump "${URL}/arena/lastPlayer/?r=`cat ATK1`&fullmana=true" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|head -n5|tail -n4
 ) </dev/null &>/dev/null &
 time_exit 17
 echo -e "${GREEN_BLACK}energy arena (✔)${COLOR_RESET}\n"
}
