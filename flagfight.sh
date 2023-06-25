flagfight_fight () {
 cd $tmp_ram
 #/enterFight
 local LA=5 # interval attack
 local HPER=48 # % to heal
 local RPER=15 # % to random
 cf_access () {
  grep -o -E '(/[a-z]+/[a-z]{0,4}at[a-z]{0,3}k/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $src_ram | sed -n 1p >ATK 2> /dev/null
  grep -o -E '(/[a-z]+/at[a-z]{0,3}k[a-z]{3,6}/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $src_ram >ATKRND 2> /dev/null
  grep -o -E '(/flagfight/dodge/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $src_ram >DODGE 2> /dev/null
  grep -o -E '(/flagfight/heal/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $src_ram >HEAL 2> /dev/null
  grep -o -E '(/[a-z]+/shield/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $src_ram >SHIELD 2> /dev/null
  grep -o -E '([[:upper:]][[:lower:]]{0,20}( [[:upper:]][[:lower:]]{0,17})?)[[:space:]]\(' $src_ram | sed -n 's,\ [(],,;s,\ ,_,;2p' >CLAN 2> /dev/null
  grep -o -E '([[:upper:]][[:lower:]]{0,15}( [[:upper:]][[:lower:]]{0,13})?)[[:space:]][^[:alnum:]]s' $src_ram | sed -n 's,\ [<]s,,;s,\ ,_,;2p' >USER 2> /dev/null
  grep -o -E "(hp)[^A-Za-z0-9]{1,4}[0-9]{1,6}" $src_ram | sed "s,hp[']\/[>],,;s,\ ,," >USH 2> /dev/null
  grep -o -E "(nbsp)[^A-Za-z0-9]{1,2}[0-9]{1,6}" $src_ram | sed -n 's,nbsp[;],,;s,\ ,,;1p' >ENH 2> /dev/null
  awk -v ush="$(cat USH)" -v rper="$RPER" 'BEGIN { printf "%.0f", ush * rper / 100 + ush }' >RHP
  awk -v ush="$(cat $full_ram)" -v hper="$HPER" 'BEGIN { printf "%.0f", ush * hper / 100 }' >HLHP
  if grep -q -o '/dodge/' $src_ram; then
   echo -e -n "\n     🙇‍ "
   w3m -dump -T text/html "$src_ram" | head -n 18 | sed '0,/^\([a-z]\{2\}\)[[:space:]]\([0-9]\{1,6\}\)\([0-9]\{2\}\):\([0-9]\{2\}\)/s//\♥️\2 ⏰\3:\4/;s,\[0\]\ ,\🔴,g;s,\[1\]\ ,\🔵,g;s,\[stone\],\ 💪,;s,\[herb\],\ 🌿,;s,\[grass\],\ 🌿,g;s,\[potio\],\ 💊,;s,\ \[health\]\ ,\ 🧡,;s,\ \[icon\]\ ,\ 🐾,g;s,\[rip\]\ ,\ 💀,g'
  else
   echo 1 >BREAK_LOOP
   echo -e "${COLOR_YELLOW}Battle's over.${COLOR_RESET}\n"
   sleep 2s
  fi
 }
 cf_access
 >BREAK_LOOP
 cat USH >old_HP
 echo $(( $(date +%s) - 20 )) >last_dodge
 echo $(( $(date +%s) - 90 )) >last_heal
 echo $(( $(date +%s) - $LA )) >last_atk
 until [ -s "BREAK_LOOP" ]; do
  #/heal/ userAgent.txtndo o USH cair para 38% e só pode ser reutilizado a cada 90 segundos
  if awk -v ush="$(cat USH)" -v hlhp="$(cat HLHP)" 'BEGIN { exit !(ush <= hlhp) }' &&  [ $(( $(date +%s) - $(cat last_heal) )) -gt 90 ] ; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat SHIELD)" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   cat USH >$full_ram; cat USH >old_HP
   date +%s >last_heal
  #/dodge/ userAgent.txtndo o USH cair 1% e só pode ser re-acessado a cada 20 segundos
  elif awk -v ush="$(cat USH)" -v oldhp="$(cat old_HP)" 'BEGIN { exit !(ush < oldhp) }' && [ $(( $(date +%s) - $(cat last_dodge) )) -ge 20 ] ; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat DODGE)" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   cat USH >old_HP; date +%s >last_dodge
  #/random
  elif grep -q -o "$(cat USER)" allies.txt || grep -q -o "$(cat CLAN)" callies.txt || awk -v rhp="$(cat RHP)" -v enh="$(cat ENH)" 'BEGIN { exit !(rhp < enh) }' ; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat ATKRND)" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   date +%s >last_atk
  #/attack
  elif [ $(( $(date +%s) - $(cat last_atk) )) -ge $LA ] ; then
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}$(cat ATK)" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
   ) </dev/null &>/dev/null &
   time_exit 17
   cf_access
   date +%s >last_atk
  else
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/flagfight" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
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
 echo "flagfight(✔)"
 sleep 10s
 clear
}
flagfight_start () {
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
 (10:1[0-4]|16:1[0-4])
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/train" -o user_agent="$(shuf -n1 userAgent.txt)" | grep -o -E '\(([0-9]+)\)' | sed 's/[()]//g' >$full_ram
  ) </dev/null &>/dev/null &
  time_exit 17
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/flagfight/?close=reward" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
  ) </dev/null &>/dev/null &
  time_exit 17
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/flagfight/enterFight" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
  ) </dev/null &>/dev/null &
  time_exit 17
  echo 'Flag fight will be started...'
  until $(case $(date +%M:%S) in (14:[5][5-9]) exit 1 ;; esac) ; do
   sleep 3
  done
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/flagfight/enterFight" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
  ) </dev/null &>/dev/null &
  time_exit 17
  echo -e "\nFlag fight"
  echo $URL
  grep -o -E '(/[a-z]+/[a-z]+/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $src_ram | sed -n 1p >ACCESS 2> /dev/null
  echo -e " 👣 Entering...\n$(cat ACCESS)"
  #/wait
  echo " 😴 Waiting..."
  local BREAK=$(( $(date +%s) + 60 ))
  until grep -q -o 'flagfight/dodge/' ACCESS || [ "$(date +%s)" -ge "$BREAK" ]; do
   echo -e " 💤	...\n$(cat ACCESS)"
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/flagfight/" -o user_agent="$(shuf -n1 userAgent.txt)" >$src_ram
   ) </dev/null &>/dev/null &
   time_exit 17
   grep -o -E '(/flagfight/[a-z]+/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $src_ram | sed -n 1p >ACCESS 2> /dev/null
   sleep 3
  done
  if [ -s ACCESS ] ; then
   flagfight_fight
  else
   rm -rf $tmp_ram
   rm $src_ram $full_ram
   unset dir_ram tmp_ram src_ram full_ram
  fi ;;
 esac
}
