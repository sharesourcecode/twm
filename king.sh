#/king/kingatk/?r=0
#/king/attack/?r=0
#/king/attackrandom/?r=0
#/king/?out_gate
king_fight () {
 #/enterFight
 cd $TMP
 local LA=3 # interval attack
 local HPER="38" # % to heal
 local RPER=5 # % to random
 local HLHP=$(( "$(cat FULL)" * "$HPER" / 100 ))
 cl_access () {
#  sed -n 's/.*\(\/[a-z]\{3,12\}\/[A-Za-z]\{3,12\}\/[^[:alnum:]][a-z]\{1,3\}[^[:alnum:]][0-9]\+\).*/\1/p'
#  sed -n 's/.*\(\/king\/attack\/[^A-Za-z0-9_]r[^A-Za-z0-9_][0-9]\+\).*/\1/p' $TMP/src.html | sed -n 1p >ATK 2> /dev/null
  grep -o -E '(/king/attack/[^A-Za-z0-9_]r[^A-Za-z0-9_][0-9]+)' $TMP/src.html | sed -n 1p >ATK 2> /dev/null
  grep -o -E '(/king/kingatk/[^A-Za-z0-9_]r[^A-Za-z0-9_][0-9]+)' $TMP/src.html | sed -n 1p >KINGATK 2> /dev/null
  grep -o -E '(/king/at[a-z]{0,3}k[a-z]{3,6}/[^A-Za-z0-9_]r[^A-Za-z0-9_][0-9]+)' $TMP/src.html >ATKRND 2> /dev/null
  grep -o -E '(/king/dodge/[^A-Za-z0-9_]r[^A-Za-z0-9_][0-9]+)' $TMP/src.html >DODGE 2> /dev/null
  grep -o -E '(/king/stone/[^A-Za-z0-9_]r[^A-Za-z0-9_][0-9]+)' $TMP/src.html >STONE 2> /dev/null
  grep -o -E '(/king/heal/[^A-Za-z0-9_]r[^A-Za-z0-9_][0-9]+)' $TMP/src.html >HEAL 2> /dev/null
  grep -o -E '([[:upper:]][[:lower:]]{0,15}( [[:upper:]][[:lower:]]{0,13})?)[[:space:]][^[:alnum:][:space:]]' $TMP/src.html | sed -n 's,\ [<]s,,;s,\ ,_,;2p' >USER 2> /dev/null
#  grep -o -P "\p{Lu}{1}\p{Ll}{0,15}[\ ]{0,1}\p{L}{0,14}\s\Ws" $TMP/src.html | sed -n 's,\ [<]s,,;s,\ ,_,;2p' >USER 2> /dev/null
  grep -o -E "(hp)[^A-Za-z0-9_]{1,4}[0-9]{1,6}" $TMP/src.html | sed "s,hp[']\/[>],,;s,\ ,," >HP 2> /dev/null
  grep -o -E "(nbsp)[^A-Za-z0-9_]{1,2}[0-9]{1,6}" $TMP/src.html | sed -n 's,nbsp[;],,;s,\ ,,;1p' >HP2 2> /dev/null
  if grep -q -o '/dodge/' $TMP/src.html; then
   echo -e -n "\n     🙇‍ "
   w3m -dump -T text/html "$TMP/src.html" | head -n 18 | sed '0,/^\([a-z]\{2\}\)[[:space:]]\([0-9]\{1,6\}\)\([0-9]\{2\}\):\([0-9]\{2\}\)/s//\♥️\2 ⏰\3:\4/;s,\[0\],\🔴,g;s,\[1\]\ ,\🔵,g;s,\[king\],👑,g;s,\[stone\],\ 💪,;s,\[herb\],\ 🌿,;s,\[grass\],\ 🌿,g;s,\[potio\],\ 💊,;s,\ \[health\]\ ,\ 🧡,;s,\ \[icon\]\ ,\ 🐾,g;s,\[rip\]\ ,\ 💀,g'
  else
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/king" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
   ) </dev/null &>/dev/null &
   time_exit 17
   #/king/unrip/?r=1682796653
   grep -o -E '(/king/unrip/[^A-Za-z0-9_]r[^A-Za-z0-9_][0-9]+)' $TMP/src.html >UNRIP 2> /dev/null
   if grep -q -o -E '(/king/unrip/[^A-Za-z0-9_]r[^A-Za-z0-9_][0-9]+)' $TMP/src.html; then
    (
     w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat UNRIP)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
    ) </dev/null &>/dev/null &
    time_exit 17
   else
    echo 1 >BREAK_LOOP
    echo -e "${BLACK_YELLOW}Battle's over.${COLOR_RESET}\n"
    sleep 3s
   fi
  fi
 }
 cl_access
 cat HP >old_HP
 echo $(( $(date +%s) - 20 )) >last_dodge
 echo $(( $(date +%s) - 90 )) >last_heal
 echo $(( $(date +%s) - $LA )) >last_atk
 >BREAK_LOOP
 until [ -s "BREAK_LOOP" ]; do
  >BREAK_LOOP
  #/dodge userAgent.txtndo o HP é alterado só pode ser re-acessado a cada 20 segundos
  if [ "$(cat old_HP)" -ne "$(cat HP)" ] && [ "$(cat HP2)" -ge 25 ] && [ $(( $(date +%s) - $(cat last_dodge) )) -ge 20 ]; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat DODGE)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
   ) </dev/null &>/dev/null &
   time_exit 17
   cl_access
   cat HP >old_HP; date +%s >last_dodge
  fi
  #/heal userAgent.txtndo o HP cair uma determinada porcentagem e só pode ser reutilizado a cada 90 segundos
  if [ -s "HEAL" ] && [ "$(cat HP)" -le "$HLHP" ] && [ $(( $(date +%s) - $(cat last_heal) )) -gt 90 ]; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat HEAL)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
   ) </dev/null &>/dev/null &
   time_exit 17
   cl_access
   cat HP >FULL; date +%s >last_heal
  fi
  sleep 0.3s
  #/attack_all
  if [ $(( $(date +%s) - $(cat last_atk) )) -ge $LA ]; then
   if grep -q -o -E '(king/kingatk/[^A-Za-z0-9_]r[^A-Za-z0-9_][0-9]+)' $TMP/src.html; then  #kingatk...
    (
     w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat KINGATK)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
    ) </dev/null &>/dev/null &
    time_exit 17
    cl_access
    #/stone...
#    if [ "$(cat HP2)" -le 25 ]; then
#     (
#      w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat STONE)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
#     ) </dev/null &>/dev/null &
#     time_exit 17
#     cl_access
#    fi #...stone
   else #...kingatk
    #/random
    if grep -q -o "$(cat USER)" $TMP/allies.txt || [ -s "ATKRND" ] && [ $(( "$(cat HP)" * "$RPER" / 100 + "$(cat HP)" )) -lt "$(cat HP2)" ]; then
     (
      w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat ATKRND)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
     ) </dev/null &>/dev/null &
     time_exit 17
     cl_access
     date +%s >last_atk
    fi
    #/atk...
    (
     w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat ATK)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
    ) </dev/null &>/dev/null &
    time_exit 17
    cl_access
   fi #...atk
   date +%s >last_atk
  fi #...attack_all
 done #
 unset cl_access _random
 func_unset
 echo -e "King (✔)"
 sleep 10s
 clear
}
king_start () {
 case $(date +%H:%M) in
 (12:2[5-9]|16:2[5-9]|22:2[5-9])
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/train" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" | grep -o -E '\(([0-9]+)\)' | sed 's/[()]//g' >$TMP/FULL
  ) </dev/null &>/dev/null &
  time_exit 17
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/king/enterGame" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
  ) </dev/null &>/dev/null &
  time_exit 17
  echo 'King of the Immortals will be started...'
  until $(case $(date +%M) in (2[5-9]) exit 1 ;; esac) ;
  do
   sleep 3
  done
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/king/enterGame" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
  ) </dev/null &>/dev/null &
  time_exit 17
  echo -e "\nKing"
  echo $URL
  cat $TMP/src.html | sed 's/href=/\n/g' | grep '/king/' | head -n1 | awk -F"[']" '{ print $2 }' >ACCESS 2> /dev/null
  echo -e " 👣 Entering...\n$(cat ACCESS)"
  #/wait
  echo " 😴 Waiting..."
  cat $TMP/src.html | grep -o 'king/kingatk/' >EXIT 2> /dev/null
  local BREAK=$(( $(date +%s) + 30 ))
  until [ -s "EXIT" ] || [ $(date +%s) -ge "$BREAK" ]; do
   echo -e " 💤	...\n$(cat ACCESS)"
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat ACCESS)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/src.html
   ) </dev/null &>/dev/null &
   time_exit 17
   cat $TMP/src.html | sed 's/href=/\n/g' | grep '/king/' | head -n1 | awk -F"[']" '{ print $2 }' >ACCESS 2> /dev/null
   cat $TMP/src.html | grep -o 'king/kingatk/' >EXIT 2> /dev/null
   sleep 2
  done
  king_fight ;;
 esac
}
