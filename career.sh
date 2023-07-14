career_func () {
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/career" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
 ) </dev/null &>/dev/null &
 time_exit 17
 local GOQUEST=$(grep -o -E '/career/[?]quest_t[=]quest&quest_id[=]16&qz[=][a-z0-9]+' $TMP/SRC)
 if [ -n $GOQUEST ] ; then
  echo "career ..."
  clan_id
  if [ -n "$CLD" ] ; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug "$URL/clan/$CLD/quest/help/6" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" &>/dev/null
   ) </dev/null &>/dev/null &
   time_exit 17
   echo "/clan/$CLD/quest/help/6"
  fi
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/career" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
  ) </dev/null &>/dev/null &
  time_exit 17
  echo '/career/'
  local CAREER=$(grep -o -E '/career/(attack|take)/[?][r][=][0-9]+' $TMP/SRC|head -n 1)
  local ATTACK=0
  local BREAK=$(( $(date +%s) + 30 ))
  until [ -z "$CAREER" ] || [ $(date +%s) -gt "$BREAK" ] ; do
   case $CAREER in
   (*attack*)
    (
     w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${CAREER}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
    ) </dev/null &>/dev/null &
    time_exit 17
    echo " ⚔ $CAREER"
    local CAREER=$(grep -o -E '/career/(attack|take)/[?][r][=][0-9]+' $TMP/SRC|head -n 1)
    local ATTACK=$((ATTACK + 1))
    ;;
   (*take*)
    if [ "$ATTACK" -gt 8 ] && [ "$ATTACK" -lt 13 ] ; then
     (
      w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${CAREER}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
     ) </dev/null &>/dev/null &
     time_exit 17
     echo " ⚔ $CAREER"
    fi
    if [ "$ATTACK" -gt 13 ]b; then
     (
      w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${CAREER}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
     ) </dev/null &>/dev/null &
     time_exit 17
     echo " ⚔ $CAREER"
     (
      w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${CAREER}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
     ) </dev/null &>/dev/null &
     time_exit 17
     echo " ⚔ $CAREER"
    fi
    unset CAREER
    ;;
   esac
  done
  if [ -n "$CLD" ] ; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug "$URL/clan/$CLD/quest/deleteHelp/6" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" &>/dev/null
   ) </dev/null &>/dev/null &
   time_exit 17
   printf "/clan/$CLD/quest/deleteHelp/6\n"
#   (
#   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug "$URL/clan/$CLD/quest/end/6" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" &>/dev/null
#   ) </dev/null &>/dev/null &
#   time_exit 17
#   printf "/clan/$CLD/quest/end/6\n"
  fi
  printf "career (✔)\n"
  sleep 2s
 fi
}
