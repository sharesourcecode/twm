clancoliseum_fight () {
 cd $tmp_ram
 #apply to fight
(
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/clancoliseum/" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
) </dev/null &>/dev/null &
 time_exit 20
 if grep -o -E '/clancoliseum/enterGame/[?]r[=][0-9]+' $TMP/SRC ; then
APPLY=$(grep -o -E '/clancoliseum/enterGame/[?]r[=][0-9]+' $TMP/SRC|sed -n '1p')
(
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${APPLY}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
) </dev/null &>/dev/null &
time_exit 20
fi

 #/enterFight
 local LA=4 # interval attack
 local HPER=48 # % to heal
 local RPER=15 # % to random
 cf_access () {
  grep -o -E '(/clancoliseum/[a-z]{0,4}at[a-z]{0,3}k/[?]r[=][0-9]+)' $src_ram|sed -n 1p >ATK 2> /dev/null
  grep -o -E '(/clancoliseum/at[a-z]{0,3}k[a-z]{3,6}/[?]r[=][0-9]+)' $src_ram >ATKRND 2> /dev/null
  grep -o -E '(/clancoliseum/dodge/[?]r[=][0-9]+)' $src_ram >DODGE 2> /dev/null
  grep -o -E '(/clancoliseum/heal/[?]r[=][0-9]+)' $src_ram >HEAL 2> /dev/null
  grep -o -E '([[:upper:]][[:lower:]]{0,20}( [[:upper:]][[:lower:]]{0,17})?)[[:space:]]\(' $src_ram|sed -n 's,\ [(],,;s,\ ,_,;2p' >CLAN 2> /dev/null
#  grep -o -E '([[:upper:]][[:lower:]]{0,15}( [[:upper:]][[:lower:]]{0,13})?)[[:space:]][^[:alnum:]]s' $src_ram|sed -n 's,\ [<]s,,;s,\ ,_,;2p' >USER 2> /dev/null
  grep -o -E "(hp)[^A-Za-z0-9]{1,4}[0-9]{1,6}" $src_ram|sed "s,hp[']\/[>],,;s,\ ,," >USH 2> /dev/null
  grep -o -E "(nbsp)[^A-Za-z0-9]{1,2}[0-9]{1,6}" $src_ram|sed -n 's,nbsp[;],,;s,\ ,,;1p' >ENH 2> /dev/null
  awk -v ush="$(cat USH)" -v rper="$RPER" 'BEGIN { printf "%.0f", ush * rper / 100 + ush }' >RHP
  awk -v ush="$(cat $full_ram)" -v hper="$HPER" 'BEGIN { printf "%.0f", ush * hper / 100 }' >HLHP
  if grep -q -o '/dodge/' $src_ram ; then
   printf "\n     🙇‍ "
   w3m -dump -T text/html "$src_ram"|head -n 18|sed '0,/^\([a-z]\{2\}\)[[:space:]]\([0-9]\{1,6\}\)\([0-9]\{2\}\):\([0-9]\{2\}\)/s//\♥️\2 ⏰\3:\4/;s,\[0\]\ ,\🔴,g;s,\[1\]\ ,\🔵,g;s,\[stone\],\ 💪,;s,\[herb\],\ 🌿,;s,\[grass\],\ 🌿,g;s,\[potio\],\ 💊,;s,\ \[health\]\ ,\ 🧡,;s,\ \[icon\]\ ,\ 🐾,g;s,\[rip\]\ ,\ 💀,g'
  else
   echo 1 >BREAK_LOOP
   printf "${BLACK_YELLOW}Battle's over.${COLOR_RESET}\n"
   sleep 2s
  fi
 }
 cf_access
 >BREAK_LOOP
 cat USH >old_HP
 echo $(( $(date +%s) - 20 )) >last_dodge
 echo $(( $(date +%s) - 90 )) >last_heal
 echo $(( $(date +%s) - $LA )) >last_atk
 until [ -s "BREAK_LOOP" ] ; do
  #/heal
  if awk -v ush="$(cat USH)" -v hlhp="$(cat HLHP)" 'BEGIN { exit !(ush < hlhp) }' && [ "$(( $(date +%s) - $(cat last_heal) ))" -gt 90 -a "$(( $(date +%s) - $(cat last_heal) ))" -lt 300 ] ; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat HEAL)" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   cat USH >old_HP
   date +%s >last_heal
  #/dodge
  elif ! grep -q -o 'txt smpl grey' $src_ram && [ "$(( $(date +%s) - $(cat last_dodge) ))" -gt 20 -a "$(( $(date +%s) - $(cat last_dodge) ))" -lt 300 ] && awk -v ush="$(cat USH)" -v oldhp="$(cat old_HP)" 'BEGIN { exit !(ush < oldhp) }' ; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat DODGE)" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   cat USH >old_HP ; date +%s >last_dodge
  #/random
  elif awk -v latk="$(( $(date +%s) - $(cat last_atk) ))" -v atktime="$LA" 'BEGIN { exit !(latk != atktime) }' && ! grep -q -o 'txt smpl grey' $src_ram && awk -v rhp="$(cat RHP)" -v enh="$(cat ENH)" 'BEGIN { exit !(rhp < enh) }' || awk -v latk="$(( $(date +%s) - $(cat last_atk) ))" -v atktime="$LA" 'BEGIN { exit !(latk != atktime) }' && ! grep -q -o 'txt smpl grey' $src_ram && grep -q -o "$(cat CLAN)" $TMP/callies.txt ; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat ATKRND)" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   date +%s >last_atk
  #/attack
  elif awk -v latk="$(( $(date +%s) - $(cat last_atk) ))" -v atktime="$LA" 'BEGIN { exit !(latk > atktime) }' ; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat ATK)" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   date +%s >last_atk
  else
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/clancoliseum" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   sleep 1s
  fi
 done
 rm -rf $tmp_ram
 rm $src_ram $full_ram
 unset dir_ram tmp_ram src_ram full_ram ACCESS cf_access
 #/end
 func_unset
 printf "ClanColiseum(✔)\n"
 sleep 10s
 clear
}
clancoliseum_start () {
 if [ -d "/dev/shm" ] ; then
  dir_ram="/dev/shm/"
 else
  dir_ram="$PREFIX/tmp/"
 fi
 src_ram=$(mktemp -p $dir_ram data.XXXXXX)
 full_ram=$(mktemp -p $dir_ram data.XXXXXX)
 tmp_ram=$(mktemp -d -t twmdir.XXXXXX)
 cp -r $TMP/* $tmp_ram
 cd $tmp_ram
 case $(date +%H:%M) in
 (10:2[5-9]|14:5[5-9])
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/train" -o user_agent="$(shuf -n1 userAgent.txt)"|grep -o -E '\(([0-9]+)\)'|sed 's/[()]//g' >$full_ram
  ) </dev/null &>/dev/null &
  time_exit 17
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/clancoliseum/?close=reward" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
  ) </dev/null &>/dev/null &
  time_exit 17
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/clancoliseum/enterFight" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
  ) </dev/null &>/dev/null &
  time_exit 17
  printf "Clan coliseum will be started...\n"
  case $(date +%H:%M) in
  (10:2[5-9])
   while $(case $(date +%M:%S) in (29:[3-5][0-9]) exit 1 ;; esac) ; do
    sleep 3
   done
   ;;
  (14:5[5-9])
   while $(case $(date +%M:%S) in (59:[3-5][0-9]) exit 1 ;; esac) ; do
    sleep 3
   done
   ;;
  esac
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/clancoliseum/enterFight" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
  ) </dev/null &>/dev/null &
  time_exit 17
  printf "\nClanColiseum\n$URL\n"
  ACCESS=$(grep -o -E '(/clancoliseum(/[a-z]+/[?]r[=][0-9]+|/))' $src_ram|grep -v 'dodge'|sed -n 1p)
  printf " 👣 Entering...\n${ACCESS}\n"
  #/wait
  printf " 😴 Waiting...\n"
  local BREAK=$(( $(date +%s) + 30 ))
  until grep -q -o 'clancoliseum/dodge/' $src_ram || [ "$(date +%s)" -gt "$BREAK" ] ; do
   printf " 💤	...\n${ACCESS}\n"
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/clancoliseum/" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
   ) </dev/null &>/dev/null &
   time_exit 17
   ACCESS=$(grep -o -E '(/clancoliseum/[a-z]+/[?]r[=][0-9]+)' $src_ram|grep -v 'dodge'|sed -n 1p)
   sleep 3
  done
  if [ -n $ACCESS ] ; then
   clancoliseum_fight
  else
   rm -rf $tmp_ram
   rm $src_ram $full_ram
   unset dir_ram tmp_ram src_ram full_ram ACCESS
  fi
  ;;
 esac
}
