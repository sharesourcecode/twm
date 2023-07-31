check_missions () {
  #https://furiadetitas.net/quest/openChest/2/?r=13772863
 printf "Checking Missions...\n"
 (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/quest" -o user_agent="$(shuf -n1 userAgent.txt)" >$TMP/SRC
  )  </dev/null &>/dev/null &
  time_exit 20
 #open chests
  if grep -o -E "/quest/openChest/(1|2)/[?]r[=][0-9]+" $TMP/SRC ; then
   click=$(grep -o -E "/quest/openChest/(1|2)/[?]r[=][0-9]+" $TMP/SRC| sed -n '1p')
   printf "${URL}$click"
   (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/quest/openChest/(1|2)/[?]r[=][0-9]+" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
 ) </dev/null &>/dev/null &
 time_exit 17
   printf "${GREEN_BLACK}Chest opened (✔)${COLOR_RESET}\n"
  fi
  (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/quest/$click" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
  )  </dev/null &>/dev/null &
   time_exit 20
#collect quests
MISSIONS= grep -o -E "/quest/end/" $TMP/SRC
NUM_MISSIONS=${#MISSIONS[@]}
for (( i=0 ; i<$NUM_MISSIONS ; i++ )) ; do
   MISSIONS=${MISSIONS[i]}
 #until [ $i -lt 1 ] ; do
  if grep -o -E "/quest/end/${i}[?]r[=][0-9]+" $TMP/SRC ; then
   click=$(grep -o -E "/quest/end/${i}[?]r[=][0-9]+" $TMP/SRC| sed -n '1p')
   (
     w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${click}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
   ) </dev/null &>/dev/null &
   time_exit 20
   #check=$((check - 1))
   printf "${GREEN_BLACK}Mission $i Completed (✔)${COLOR_RESET}\n"
  fi
 done
#collect rewards
 (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/relic/reward/" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
 ) </dev/null &>/dev/null &
 time_exit 20
 i=0
 while [ $i -lt 11 ] ; do
  if grep -o -E "/relic/reward/${i}/[?]r[=][0-9]+" $TMP/SRC ; then
   click=$(grep -o -E "/relic/reward/${i}/[?]r[=][0-9]+" $TMP/SRC| sed -n '1p')
   (
     w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${click}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
   ) </dev/null &>/dev/null &
   time_exit 20
   printf "${GREEN_BLACK}Relic collected (✔)${COLOR_RESET}\n"
  fi
  i=$((i+1))
 done
#collect collections
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

apply_event () {
 #/apply to fight
 event="$@"
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/$event/" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
 ) </dev/null &>/dev/null &
 time_exit 20
 if grep -o -E "/$event/enter(Game|Fight)/[?]r[=][0-9]+" $TMP/SRC ; then
  APPLY=$(grep -o -E "/$event/enter(Game|Fight)/[?]r[=][0-9]+" $TMP/SRC)
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${APPLY}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
  ) </dev/null &>/dev/null &
  time_exit 20
  printf "${BLACK_YELLOW}Applied for battle (✔)${COLOR_RESET}\n"
 fi
}
