campaign_func () {
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/quest/" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
 ) </dev/null &>/dev/null &
 time_exit 20
 if grep -q -o -E '/campaign/[?]quest_t[=]quest&quest_id[=]5&qz[=][a_z0-9]+' $TMP/SRC ; then
  echo "campaign..."
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/campaign" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
  ) </dev/null &>/dev/null &
  time_exit 20
  #/'=\\\&apos
  local CAMPAIGN=$(grep -o -E '/campaign/(go|fight|attack|end)/[?]r[=][0-9]+' $TMP/SRC|head -n 1)
  local BREAK=$(( $(date +%s) + 60 ))
  while [ -n "$CAMPAIGN" ] && [ $(date +%s) -lt "$BREAK" ] ; do
   case $CAMPAIGN in
   (*go*|*fight*|*attack*|*end*)
    (
     w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$CAMPAIGN" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
    ) </dev/null &>/dev/null &
    time_exit 20
    echo "$CAMPAIGN"
    local CAMPAIGN=$(grep -o -E '/campaign/(go|fight|attack|end)/[?]r[=][0-9]+' $TMP/SRC|head -n 1)
    ;;
   esac
  done
  echo -e "campaign (✔)\n"
 fi
}
