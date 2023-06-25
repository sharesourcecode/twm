campaign_func () {
 echo "campaign..."
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/campaign" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
 ) </dev/null &>/dev/null &
 time_exit 17
 #/'=\\\&apos
 local CAMPAIGN=$(grep -o -E '/campaign/(go|fight|attack|end)/[?][r][=][0-9]+' $TMP/SRC | head -n 1)
 local BREAK=$(( $(date +%s) + 60 ))
 while [ -n "$CAMPAIGN" ] && [ $(date +%s) -le "$BREAK" ]; do
  case $CAMPAIGN in
  (*go*|*fight*|*attack*|*end*)
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$CAMPAIGN" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
   ) </dev/null &>/dev/null &
   time_exit 17
   echo "$CAMPAIGN"
   local CAMPAIGN=$(grep -o -E '/campaign/(go|fight|attack|end)/[?][r][=][0-9]+' $TMP/SRC | head -n 1) ;;
  esac
 done
 echo -e "campaign (✔)\n"
}
