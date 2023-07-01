#/clanfight/dodge/?r=0
#/clanfight/attack/?r=0
#/clanfight/attackrandom/?r=0
#/clanfight/heal/?r=0
#/clanfight/stone/?r=0
#/clanfight/grass/?r=0
#/clanfight/?out_gate
clanfight_fight () {
 cd $TMP
 #/enterFight
 local LA=5 # interval attack
 local HPER=48 # % to heal
 local RPER=15 # % to random
 echo $(($(cat FULL) * HPER / 100)) >HLHP 2> /dev/null
 cf_access () {
  grep -o -E '(/[a-z]+/[a-z]{0,4}at[a-z]{0,3}k/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/src.html | sed -n 1p >ATK 2> /dev/null
  grep -o -E '(/[a-z]+/at[a-z]{0,3}k[a-z]{3,6}/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/src.html >ATKRND 2> /dev/null
  grep -o -E '(/clanfight/dodge/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/src.html >DODGE 2> /dev/null
  grep -o -E '(/clanfight/heal/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/src.html >HEAL 2> /dev/null
  grep -o -E '([[:upper:]][[:lower:]]{0,20}( [[:upper:]][[:lower:]]{0,17})?)[[:space:]]\(' $TMP/src.html | sed -n 's,\ [(],,;s,\ ,_,;2p' >CLAN 2> /dev/null
#  grep -o -E '([[:upper:]][[:lower:]]{0,15}( [[:upper:]][[:lower:]]{0,13})?)[[:space:]][^[:alnum:]]s' $TMP/src.html | sed -n 's,\ [<]s,,;s,\ ,_,;2p' >USER 2> /dev/null
  grep -o -E "(hp)[^A-Za-z0-9]{1,4}[0-9]{1,6}" $TMP/src.html | sed "s,hp[']\/[>],,;s,\ ,," >HP 2> /dev/null
  grep -o -E "(nbsp)[^A-Za-z0-9]{1,2}[0-9]{1,6}" $TMP/src.html | sed -n 's,nbsp[;],,;s,\ ,,;1p' >HP2 2> /dev/null
  if grep -q -o '/dodge/' $TMP/src.html; then
   echo -e -n "\n     🙇‍ "
   w3m -dump -T text/html "$TMP/src.html" | head -n 18 | sed '0,/^\([a-z]\{2\}\)[[:space:]]\([0-9]\{1,6\}\)\([0-9]\{2\}\):\([0-9]\{2\}\)/s//\♥️\2 ⏰\3:\4/;s,\[0\]\ ,\🔴,g;s,\[1\]\ ,\🔵,g;s,\[stone\],\ 💪,;s,\[herb\],\ 🌿,;s,\[grass\],\ 🌿,g;s,\[potio\],\ 💊,;s,\ \[health\]\ ,\ 🧡,;s,\ \[icon\]\ ,\ 🐾,g;s,\[rip\]\ ,\ 💀,g'
  else
   echo 1 >BREAK_LOOP
   echo -e "${BLACK_YELLOW}Battle's over.${COLOR_RESET}\n"
   sleep 2s
  fi
 }
 cf_access
 >BREAK_LOOP
 cat HP >old_HP
 echo $(( $(date +%s) - 20 )) >last_dodge
 echo $(( $(date +%s) - 90 )) >last_heal
 echo $(( $(date +%s) - $LA )) >last_atk
 until [ -s "BREAK_LOOP" ]; do
  cf_access
  #/dodge/ userAgent.txtndo o HP cair 1% e só pode ser re-acessado a cada 20 segundos
  if [ "$(cat old_HP)" -ne "$(cat HP)" ] && [ $(( $(date +%s) - $(cat last_dodge) )) -ge 20 ]; then
#   sleep 3.5s
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat DODGE)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   cat HP >old_HP; date +%s >last_dodge
  fi
  #/heal/ userAgent.txtndo o HP cair para 38% e só pode ser reutilizado a cada 90 segundos
  if [ -s "HEAL" ] && [ "$(cat HP)" -le "$(cat HLHP)" ] &&  [ $(( $(date +%s) - $(cat last_heal) )) -gt 90 ]; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat HEAL)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   cat HP >FULL; cat HP >old_HP
   date +%s >last_heal
  fi
  #/random
  if grep -q -o "$(cat CLAN)" $TMP/callies.txt || [ -s "ATKRND" ] && [ $(( "$(cat HP)" * RPER / 100 + "$(cat HP)" )) -lt "$(cat HP2)" ]; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat ATKRND)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   date +%s >last_atk
  fi
  #/attack
  sleep 0.3s
  if [ $(( $(date +%s) - $(cat last_atk) )) -ge $LA ]; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat ATK)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   date +%s >last_atk
  fi
 done
 unset cf_access _random
 #/end
 func_unset
 echo "ClanFight(✔)"
 sleep 10s
 clear
}
clanfight_start () {
 cd $TMP
 case $(date +%H:%M) in
 (10:5[5-9]|18:5[5-9])
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/train" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" | grep -o -E '\(([0-9]+)\)' | sed 's/[()]//g' >$TMP/FULL
  ) </dev/null &>/dev/null &
  time_exit 17
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/clanfight/?close=reward" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
  ) </dev/null &>/dev/null &
  time_exit 17
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/clanfight/enterFight" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
  ) </dev/null &>/dev/null &
  time_exit 17
  echo 'Clan tournament will be started...'
  while $(case $(date +%M:%S) in (59:[3-5][0-9]) exit 1 ;; esac) ;
  do
   sleep 3
  done
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/clanfight/enterFight" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
  ) </dev/null &>/dev/null &
  time_exit 17
  echo -e "\nClan fight"
  echo $URL
  grep -o -E '(/[a-z]+(/[a-z]+/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+|/))' $TMP/src.html | sed -n 1p >ACCESS 2> /dev/null
  echo -e " 👣 Entering...\n$(cat ACCESS)"
  #/wait
  echo " 😴 Waiting..."
  local BREAK=$(( $(date +%s) + 60 ))
  until grep -q -o 'clanfight/dodge/' ACCESS || [ "$(date +%s)" -ge "$BREAK" ]; do
   echo -e " 💤	...\n$(cat ACCESS)"
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/clanfight/" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
   ) </dev/null &>/dev/null &
   time_exit 17
   grep -o -E '(/clanfight(/[a-z]+/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+|/))' $TMP/src.html | sed -n 1p >ACCESS 2> /dev/null
   sleep 3
  done
  clanfight_fight ;;
 esac
}
