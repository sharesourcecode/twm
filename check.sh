#check cave...
#/cave/gather/?r=54426358 #new mine
#/cave/down/?r=54426358 #new search
#/cave/attack/?r=42724370 #attack cave
#/cave/runaway/?r=42724370 #runaway cave
condition_func () {
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/cave/" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
   ) </dev/null &>/dev/null &
   time_exit 17
   ACCESS1=$(cat $TMP/SRC|sed 's/href=/\n/g'|grep '/cave/'|head -n 1|awk -F\' '{ print $2 }')
   DOWN=$(cat $TMP/SRC|sed 's/href=/\n/g'|grep '/cave/down'|awk -F\' '{ print $2 }')
   ACCESS2=$(cat $TMP/SRC|sed 's/href=/\n/g'|grep '/cave/'|head -n 2|tail -n 1|awk -F\' '{ print $2 }')
   ACTION=$(cat $TMP/SRC|sed 's/href=/\n/g'|grep '/cave/'|awk -F\' '{ print $2 }'|tr -cd "[[:alpha:]]")
   MEGA=$(cat $TMP/SRC|sed 's/src=/\n/g'|grep '/images/icon/silver.png'|grep "'s'"|tail -n 1|grep -o 'M')
  }
  condition_func
check_cave () {
  local num=6
  case $ACTION in
    (cavechancercavegatherrcavedownr)
     (
      w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${ACCESS2}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
     ) </dev/null &>/dev/null &
     time_exit 17
     printf "${CYAN_BLACK}${ACCESS2}${COLOR_RESET}\n$(w3m -dump -T text/html $TMP/SRC | grep -o -E '(g [0-9]{1,3}[^0-9]{0,1}[0-9]{0,3}[A-Za-z]{0,1} \| s [0-9]{1,3}[^0-9]{0,1}[0-9]{0,3}[A-Za-z]{0,1})' | sed 's/g/\ g/g;s/s/\ s/g')\n"
     local num=$((num - 1))
     ;;
    (cavedownr|cavedownrclanbuiltprivateUpgradetruerrefcave)
     local num=$((num - 1))
     (
      w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${DOWN}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
     ) </dev/null &>/dev/null &
     time_exit 17
     printf "${GREEN_BLACK}${DOWN}${COLOR_RESET}\n$(w3m -dump -T text/html $TMP/SRC | grep -o -E '(g [0-9]{1,3}[^0-9]{0,1}[0-9]{0,3}[A-Za-z]{0,1} \| s [0-9]{1,3}[^0-9]{0,1}[0-9]{0,3}[A-Za-z]{0,1})' | sed 's/g/\ g/g;s/s/\ s/g')\n"
     ;;
    (caveattackrcaverunawayr)
     local num=$((num - 1))
     (
      w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${ACCESS1}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
     ) </dev/null &>/dev/null &
     time_exit 17
     printf "${GOLD_BLACK}${ACCESS1}${COLOR_RESET}\n$(w3m -dump -T text/html $TMP/SRC | grep -o -E '(g [0-9]{1,3}[^0-9]{0,1}[0-9]{0,3}[A-Za-z]{0,1} \| s [0-9]{1,3}[^0-9]{0,1}[0-9]{0,3}[A-Za-z]{0,1})' | sed 's/g/\ g/g;s/s/\ s/g')\n"
     (
      w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/cave/runaway" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
     ) </dev/null &>/dev/null &
     time_exit 17
     printf "${WHITEb_BLACK}/cave/runaway${COLOR_RESET}\n"
     ;;
    (*)
     local num=0
     ;;
  esac
printf "${BLACK_YELLOW}Cave Done (✔)${COLOR_RESET}\n"

}
