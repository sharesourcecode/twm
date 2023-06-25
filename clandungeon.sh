clanDungeon () {
 clan_id
 if [ -n "$CLD" ]; then
  echo "Checking Clan Dungeon..."
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/clandungeon/?close" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
  ) </dev/null &>/dev/null &
  time_exit 17
  local CLANDUNGEON=$(grep -o -E '/clandungeon/(attack/[?][r][=][0-9]+|[?]close)' $TMP/SRC | head -n1)
  local BREAK=$(( `date +%s` + 60 ))
  until [ -z "$CLANDUNGEON" ] || [ $(date +%s) -ge "$BREAK" ]; do
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${CLANDUNGEON}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
   ) </dev/null &>/dev/null &
   time_exit 17
   echo " ⚔ $CLANDUNGEON"
   local CLANDUNGEON=$(grep -o -E '/clandungeon/(attack/[?][r][=][0-9]+|[?]close)' $TMP/SRC | head -n1)
  done
  echo -e "Clan Dungeon (✔)\n"
 fi
}
