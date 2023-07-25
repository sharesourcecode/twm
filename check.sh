check_missions () {
  printf "Checking Missions...\n"
  (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/quest/" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
  ) </dev/null &>/dev/null &
 time_exit 20
 for (( i=0 ; i<10 ; i++ )) ; do
  if grep -o -E "/quest/end/${i}[?]r=[0-9]+" $TMP/SRC ; then
    click=$(grep -o -E "/quest/end/${i}[?]r=[0-9]+" $TMP/SRC)
    (
      w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${click}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
    ) </dev/null &>/dev/null &
    time_exit 20
    printf "${GREEN_BLACK}Mission Completed (✔)${COLOR_RESET}\n"
  fi
done

  (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/relic/reward/" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
  ) </dev/null &>/dev/null &
 time_exit 20
 for (( i=0 ; i<11 ; i++ )) ; do
  if grep -o -E "/relic/reward/${i}/[?]r=[0-9]+" $TMP/SRC ; then
    click=$(grep -o -E "/relic/reward/${i}/[?]r=[0-9]+" $TMP/SRC)
    (
      w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${click}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
    ) </dev/null &>/dev/null &
    time_exit 20
    printf "${GREEN_BLACK}Relic collected (✔)${COLOR_RESET}\n"
  fi
done

  (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/collector/" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
  ) </dev/null &>/dev/null &
 time_exit 20
  if grep -o -E "/collector/reward/element/[?]r=[0-9]+" $TMP/SRC ; then
    click=$(grep -o -E '/collector/reward/element/[?]r=[0-9]+' $TMP/SRC)
    (
      w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${click}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
    ) </dev/null &>/dev/null &
    time_exit 20
    printf "${GREEN_BLACK}Collection collected (✔)${COLOR_RESET}\n"
  fi
  printf "${GREEN_BLACK}Missions (✔)${COLOR_RESET}\n"
}

sageQuest_openchest () {
 echo "openChest ..."
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source  "${URL}/quest" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
 ) </dev/null &>/dev/null &
 time_exit 17
 local ACCESS=$(cat $TMP/SRC|sed 's/href=/\n/g'|grep 'quest/openChest'|head -n1|awk -F\' '{ print $2 }')
 local BREAK=$(( $(date +%s) + 15 ))
 while [ -n "$ACCESS" ] || [ $(date +%s) -lt "$BREAK" ] ; do
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${ACCESS}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
  ) </dev/null &>/dev/null &
  time_exit 17
  echo $ACCESS
  local ACCESS=$(cat $TMP/SRC|sed 's/href=/\n/g'|grep 'quest/openChest'|head -n1|awk -F\' '{ print $2 }')
  sleep 1s
 done
 echo -e "openChest (✔)\n"
}