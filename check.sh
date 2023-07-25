check_missions () {
for (( i=0 ; i<10 ; i++ )) ; do
  (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/quest/end/${i}[?]r=[0-9]+" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
  ) </dev/null &>/dev/null &
 time_exit 20
  if grep -o -E '/quest/end/${i}[?]r=[0-9]+' $TMP/SRC ; then
    click=$(grep -o -E '/quest/end/${i}[?]r=[0-9]+' $TMP/SRC)
    (
      w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${click}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
    ) </dev/null &>/dev/null &
    time_exit 20
    printf "${BLACK_YELLOW}Mission Completed (✔)${COLOR_RESET}\n"
  fi
done

for (( i=0 ; i<11 ; i++ )) ; do
  (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/relic/reward/${i}/[?]r=[0-9]+" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
  ) </dev/null &>/dev/null &
 time_exit 20
  if grep -o -E '/relic/reward/${i}/[?]r=[0-9]+' $TMP/SRC ; then
    click=$(grep -o -E '/relic/reward/${i}/[?]r=[0-9]+' $TMP/SRC)
    (
      w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${click}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
    ) </dev/null &>/dev/null &
    time_exit 20
    printf "${BLACK_YELLOW}Mission Completed (✔)${COLOR_RESET}\n"
  fi
done
}

/relic/reward/5/?r=34009907