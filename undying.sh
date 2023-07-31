undying_fight () {
 cd $TMP

 #/enterFight
 local LA=5 # hit interval

 cf_access () {
  grep -o -E '/undying/(hit|mana)/[?][r][=][0-9]+' $TMP/SRC|sed -n '1p' >HITMANA 2> /dev/null

  if grep -q -o 'out_gate' $TMP/SRC; then
   #/view
   printf "\n     🙇‍ "
   w3m -dump -T text/html "$TMP/SRC"|head -n 18|sed '0,/^\([a-z]\{2\}\)[[:space:]]\([0-9]\{1,6\}\)\([0-9]\{2\}\):\([0-9]\{2\}\)/s//\♥️\2 ⏰\3:\4/;s,\[0\],\🔴,g;s,\[1\]\ ,\🔵,g;s,\[stone\],\ 💪,;s,\[herb\],\ 🌿,;s,\[grass\],\ 🌿,g;s,\[hit\],🗡️,;s,\[2hit\],⚔️,;s,\[rage\],⚰️,;s,\[bot\],🧟‍,;s,\[vs\]\ ,🆚\ 👹,;s,\[rip\],💀,g'
  else
   echo 1 >BREAK_LOOP
   printf "${BLACK_YELLOW}Battle's over.${COLOR_RESET}\n"
   sleep 2s
  fi
 }
 cf_access

 >BREAK_LOOP
 echo $(( $(date +%s) - $LA )) >last_atk

 until [ -s "BREAK_LOOP" ]; do

  cf_access
  #/attack
  if awk -v latk="$(( $(date +%s) - $(cat last_atk) ))" -v atktime="$LA" 'BEGIN { exit !(latk > atktime) }'; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat HITMANA)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   date +%s >last_atk
  else
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/undying" -o user_agent="$(shuf -n1 userAgent.txt)" >$TMP/SRC
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   sleep 1s
  fi

 done

 #/end
 unset cf_access
 printf "Undying (✔)\n"
 sleep 15s
 apply_event undying

 #/clear bag
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug "$URL/inv/bag/sellAll/1/" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" &>/dev/null
 ) </dev/null &>/dev/null &
 time_exit 17
 printf "/inv/bag/sellAll/1/\n"
}

undying_start () {
 cd $TMP

 case $(date +%H:%M) in
  (09:5[5-9]|15:5[5-9]|21:5[5-9])
   printf "Valley of the Immortals will be started...\n$(date +%Hh:%Mm)"

   while [ $(date +%M) -gt "54" ] && [ $(date +%M) -lt "58" ]; do
    sleep 5s
    clear
   done

   arena_takeHelp
   arena_fullmana
   #/apply to fight
   apply_event undying
: ' #/undying/enterGame/?r=75053380
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/undying/enterGame/" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
   ) </dev/null &>/dev/null &
   time_exit 17
'
   printf "Valley of the Immortals will be started...\n$(date +%Hh:%Mm)\n"

   while awk -v minute="$(date +%M)" 'BEGIN { exit !(minute != 00) }' && [ $(date +%M) -gt "57" ]; do
    sleep 5s
   done

   #/undying/
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/undying/" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
   ) </dev/null &>/dev/null &
   time_exit 17
   #/undying/hit|mana/?r=???
   grep -o -E '/undying/(mana|hit)/[?][r][=][0-9]+' $TMP/SRC|head -n 1 >HITMANA 2> /dev/null

   >BREAK_LOOP
   local BREAK=$(( $(date +%s) + 11 ))

   until [ -s "BREAK_LOOP" ] || [ "$(date +%s)" -gt "$BREAK" ]; do
    #/undying/
    (
     w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/undying" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
    ) </dev/null &>/dev/null &
    time_exit 17

    grep -o -E '/undying/(mana|hit)/[?][r][=][0-9]+' $TMP/SRC|head -n 1 >HITMANA 2> /dev/null

    if grep -q -o -E '/undying/(hit|mana)' $TMP/SRC; then
     #/undying/hit|mana/?r=???
     (
      w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat HITMANA)" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
     ) </dev/null &>/dev/null &
     time_exit 17
     echo "1" >BREAK_LOOP

     #/view
     printf "\n     🙇‍ "
     w3m -dump -T text/html "$TMP/SRC"|head -n 18|sed '0,/^\([a-z]\{2\}\)[[:space:]]\([0-9]\{1,6\}\)\([0-9]\{2\}\):\([0-9]\{2\}\)/s//\♥️\2 ⏰\3:\4/;s,\[0\]\ ,\🔴,g;s,\[1\]\ ,\🔵,g;s,\[stone\],\ 💪,;s,\[herb\],\ 🌿,;s,\[grass\],\ 🌿,g;s,\[potio\],\ 💊,;s,\ \[health\]\ ,\ 🧡,;s,\ \[icon\]\ ,\ 🐾,g;s,\[rip\]\ ,\ 💀,g'
    fi
    sleep 0.3s
   done

   arena_fullmana
   arena_deleteEnd
   undying_fight
  ;;
 esac
}
