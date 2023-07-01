altars_fight () {
 cd $TMP
 #/enterFight
 local LA=5 # interval attack
 echo "48" >HPER # % to heal
 echo "15" >RPER # % to random
 echo $(( "$(cat FULL)" * "$(cat HPER)" / 100 )) >HLHP 2> /dev/null
 cf_access () {
  grep -o -E '(/[a-z]+/[a-z]{0,4}at[a-z]{0,3}k/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/src.html | sed -n 1p >ATK 2> /dev/null
  grep -o -E '(/[a-z]+/at[a-z]{0,3}k[a-z]{3,6}/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/src.html >ATKRND 2> /dev/null
  grep -o -E '(/altars/dodge/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/src.html >DODGE 2> /dev/null
  grep -o -E '(/altars/heal/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/src.html >HEAL 2> /dev/null
  grep -o -E '([[:upper:]][[:lower:]]{0,20}( [[:upper:]][[:lower:]]{0,17})?)[[:space:]]\(' $TMP/src.html | sed -n 's,\ [(],,;s,\ ,_,;2p' >CLAN 2> /dev/null
#  grep -o -E '([[:upper:]][[:lower:]]{0,15}( [[:upper:]][[:lower:]]{0,13})?)[[:space:]][^[:alnum:]]s' $TMP/src.html | sed -n 's,\ [<]s,,;s,\ ,_,;2p' >USER 2> /dev/null
  grep -o -E "(hp)[^A-Za-z0-9]{1,4}[0-9]{1,6}" $TMP/src.html | sed "s,hp[']\/[>],,;s,\ ,," >HP 2> /dev/null
  grep -o -E "(nbsp)[^A-Za-z0-9]{1,2}[0-9]{1,6}" $TMP/src.html | sed -n 's,nbsp[;],,;s,\ ,,;1p' >HP2 2> /dev/null
  if grep -q -o '/dodge/' $TMP/src.html ; then
   printf "\n     🙇‍ "
   w3m -dump -T text/html "$TMP/src.html" | head -n 18 | sed '0,/^\([a-z]\{2\}\)[[:space:]]\([0-9]\{1,6\}\)\([0-9]\{2\}\):\([0-9]\{2\}\)/s//\♥️\2 ⏰\3:\4/;s,\[0\]\ ,\🔴,g;s,\[1\]\ ,\🔵,g;s,\[stone\],\ 💪,;s,\[herb\],\ 🌿,;s,\[grass\],\ 🌿,g;s,\[potio\],\ 💊,;s,\ \[health\]\ ,\ 🧡,;s,\ \[icon\]\ ,\ 🐾,g;s,\[rip\]\ ,\ 💀,g'
  else
   echo 1 >BREAK_LOOP
   printf "${BLACK_YELLOW}Battle's over.${COLOR_RESET}\n"
   sleep 2s
  fi
 }
 cf_access
 >BREAK_LOOP ; cat HP >old_HP
 echo $(( $(date +%s) - 20 )) >last_dodge
 echo $(( $(date +%s) - 90 )) >last_heal
 echo $(( $(date +%s) - $LA )) >last_atk
 until [ -s "BREAK_LOOP" ] ; do
  cf_access
  #/dodge/ userAgent.txtndo o HP cair 1% e só pode ser re-acessado a cada 20 segundos
  if [ $(cat last_dodge) -gt 20 ] && [ "$(cat old_HP)" -ne "$(cat HP)" ] ; then
#   sleep 3s
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat DODGE)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   cat HP >old_HP ; date +%s >last_dodge
  fi
  #/heal/ userAgent.txtndo o HP cair para 38% e só pode ser reutilizado a cada 90 segundos
  if [ -s "HEAL" ] && [ "$(cat HP)" -lt "$(cat HLHP)" ] && [ $(( $(date +%s) - $(cat last_heal) )) -gt 90 ] ; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat HEAL)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   cat HP >FULL ; cat HP >old_HP
   date +%s >last_heal
  fi
  #/random
  if grep -q -o "$(cat CLAN)" $TMP/callies.txt || [ -s "ATKRND" ] && [ $(( "$(cat HP)" * "$(cat RPER)" / 100 + "$(cat HP)" ))  -lt "$(cat HP2)" ] ; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat ATKRND)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   date +%s >last_atk
  fi
  sleep 0.3s
  #/attack
  if [ $(( $(date +%s) - $(cat last_atk) )) -gt $LA ] ; then
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
 printf "Altars (✔)\n"
 sleep 10s
 clear
}
altars_start () {
 case $(date +%H:%M) in
 (13:5[5-9]|20:5[5-9])
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/train" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" | grep -o -E '\(([0-9]+)\)' | sed 's/[()]//g' >$TMP/FULL
  ) </dev/null &>/dev/null &
  time_exit 17
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/altars/enterFight" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
  ) </dev/null &>/dev/null &
  time_exit 17
  printf "Ancient Altars will be started...\n"
  until $(case $(date +%M) in (55|56|57|58|59) exit 1 ;; esac) ;
  do
   sleep 2
  done
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/altars/enterFight" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
  ) </dev/null &>/dev/null &
  time_exit 17
  printf "\nAltars\n$URL\n"
  grep -o -E '(/altars(/[A-Za-z]+/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+|/))' $TMP/src.html | sed -n 1p >ACCESS 2> /dev/null
  printf " 👣 Entering...\n$(cat ACCESS)\n"
  #/wait
  printf " 😴 Waiting...\n"
  local BREAK=$(( $(date +%s) + 30 ))
  until grep -q -o 'altars/dodge/' ACCESS || [ "$(date +%s)" -gt "$BREAK" ] ; do
   printf "$URL\n 💤	...\n$(cat ACCESS)\n"
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/altars" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
   ) </dev/null &>/dev/null &
   time_exit 17
   grep -o -E '(/altars(/[A-Za-z]+/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+|/))' $TMP/src.html | sed -n 1p >ACCESS 2> /dev/null
   sleep 3
  done
  altars_fight ;;
 esac
}
