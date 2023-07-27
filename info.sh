#!/bin/bash
: '
The code used in this script is not compatible with the ISH app on the Iphone,
so it should not be used as an example for other scripts.
'
#/Colors - font(formatting)_background
colors() {
BLACK_BLACK='\033[00;30m'
BLACK_CYAN='\033[01;36m\033[01;07m'
BLACK_GREEN='\033[00;32m\033[01;07m'
BLACK_GRAY='\033[01;30m\033[01;07m'
BLACK_PINK='\033[01;35m\033[01;07m'
BLACK_RED='\033[01;31m\033[01;07m'
BLACK_YELLOW='\033[00;33m\033[01;07m'
CYAN_BLACK='\033[36m'
CYAN_CYAN='\033[01;36m\033[08;07m'
COLOR_RESET='\033[00m'
GOLD_BLACK='\033[33m'
GREEN_BLACK='\033[32m'
PURPLEi_BLACK='\033[03;34m\033[02;03m'
PURPLEis_BLACK='\033[03;34m\033[02;04m'
WHITE_BLACK='\033[37m'
WHITEb_BLACK='\033[01;38m\033[05;01m'
}

script_slogan () {
 colors=("10" "9" "8" "7" "6" "5" "4" "3" "2" "1")
 t=339
 w=59
 m=89
 author="ueliton@disroot.org 2019 - 2023"
 collaborator="@_hviegas"
  #Change this number for new version...........................................................
  version="Version 2.9.07"
 for (( i=0 ; i<${#colors[@]} ; i++ )) ; do
  clear
  t=$(($t - 27))
  w=$(($w + 1))
  m=$(($m - 2))
  # //⟨
  printf "\033[1;38;5;${t}m   ╔══╗╔╗╔══╗╔══╗╔══╗╔══╗
   ╚╗╔╝╠╣╚╗╔╝║╔╗║║╔╗║║══╣
   ${BLACK_BLACK}═\033[1;38;5;${t}m║║${BLACK_BLACK}═\033[1;38;5;${t}m║║${BLACK_BLACK}═\033[1;38;5;${t}m║║${BLACK_BLACK}═\033[1;38;5;${t}m║╔╗║║║║║╠══║
   ${BLACK_BLACK}═\033[1;38;5;${t}m╚╝${BLACK_BLACK}═\033[1;38;5;${t}m╚╝${BLACK_BLACK}═\033[1;38;5;${t}m╚╝${BLACK_BLACK}═\033[1;38;5;${t}m╚╝╚╝╚╝╚╝╚══╝\033[1;38;5;${w}m
        ╔╦═╦╗╔══╗╔══╗
        ║║║║║║╔╗║║╚╝╣
        ║║║║║║╔╗║║║╗║
        ╚═╩═╝╚╝╚╝╚╝╚╝\033[1;38;5;${m}m
    ╔═╦═╗╔══╗╔══╗╔══╗╔══╗
    ║║║║║║╔╗║║╔═╝║╚╝╣║╔╗║
    ║║║║║║╔╗║║╚═╗║║╗║║╚╝║
    ╚╩═╩╝╚╝╚╝╚══╝╚╝╚╝╚══╝
        ${COLOR_RESET}\n"
  # ⟩\\
  printf "\033[1;38;5;${colors[i]}m${author}\n${collaborator}\n${version}${COLOR_RESET}\n"
  sleep 0.3
 done
}
#message
messages_info () {
 echo " ⚔️  Titans War Macro - ${version}  ⚔️ " > $TMP/msg_file
 printf " ##### mail #####\n" >> $TMP/msg_file
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -dump "${URL}/mail" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tee $TMP/info_file|sed -n '/[|]\ mp/,/\[arrow\]/p'|sed '1,1d;$d;6q' >> $TMP/msg_file
 ) </dev/null &>/dev/null &
 time_exit 17
 printf " ##### chat titans #####\n" >> $TMP/msg_file
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -dump "${URL}/chat/titans/changeRoom" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|sed -n '/\(\»\)/,/\[chat\]/p'|sed '$d;4q' >> $TMP/msg_file
 ) </dev/null &>/dev/null &
 time_exit 17
 printf " ##### chat clan #####\n" >> $TMP/msg_file
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -dump "${URL}/chat/clan/changeRoom" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|sed -ne '/\[[^a-z]\]/,/\[chat\]/p'|sed '$d;4q' >> $TMP/msg_file
 ) </dev/null &>/dev/null &
 time_exit 17
# sed :a;N;s/\n//g;ta |
 printf "${GREEN_BLACK}${ACC}$(grep -o -E '(lvl [0-9]{1,2} \| g [0-9]{1,3}[^0-9]{0,1}[0-9]{0,3}[A-Za-z]{0,1} \| s [0-9]{1,3}[^0-9]{0,1}[0-9]{0,3}[A-Za-z]{0,1})' $TMP/info_file|sed 's/lvl/\ lvl/g;s/g/\ g/g;s/s/\ s/g')${COLOR_RESET}\n" >> $TMP/msg_file
}

#/time_exit
time_exit () {
 (
  local FPID=$(echo "$!"|grep -o -E '([0-9]{2,6})')
  for TE in $(seq "$@" -1 0) ; do
   local RPID=$(ps ax -o pid=|grep -o "$FPID")
   if [ -z "$RPID" ] ; then
    local TE=0
    break &>/dev/null
   elif [ "$TE" -lt 1 ] ; then
    kill -s PIPE $FPID &>/dev/null
    kill -15 $FPID &>/dev/null
    printf "${WHITEb_BLACK}Command execution was interrupted!${COLOR_RESET}\n"
    local TE=0
    break &>/dev/null
   fi
   sleep 1s
  done
 )
}