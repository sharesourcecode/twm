#!/bin/bash
#/Colors - font(formatting)_background
colors () {
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
 colors="10 9 8 7 6 5 4 3 2 1"
 t=339
 w=59
 m=89
 author="ueliton@disroot.org 2019 - 2023"
 collaborator="@_hviegas"
 #Change this number for new version...........................................................
 version="Version 2.11.25"
 for i in $colors; do
  clear
  t=$((t - 27))
  w=$((w + 1))
  m=$((m - 2))
  # //⟨
  printf "\033[1;38;5;${t}m  ╔══╗╔╗╔══╗╔══╗╔══╗╔══╗
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
  printf "\033[1;38;5;${i}m${author}\n${collaborator}\n${version}${COLOR_RESET}\n"
  sleep 0.3s
 done
}

time_exit () {
 (
  local TEFPID=$(echo "$!"|grep -o -E '([0-9]{2,6})')
  for TELOOP in $(seq "$@" -1 0); do
   local TERPID=$(ps ax -o pid=|grep -o "$TEFPID")
   if [ -z "$TERPID" ]; then
    local TELOOP=0
    break &>/dev/null
   elif [ "$TELOOP" -lt 1 ]; then
    kill -s PIPE $TEFPID &>/dev/null
    kill -15 $TEFPID &>/dev/null
    printf "${WHITEb_BLACK}Command execution was interrupted!${COLOR_RESET}\n"
    local TELOOP=0
    break &>/dev/null
   fi
   sleep 1s
  done
 )
}
link() {
     (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/$1" -o user_agent="$(shuf -n1 userAgent.txt)" $2
  )  </dev/null &>/dev/null &
  time_exit 20
}

hpmp () {
 #/options: -fix or -now

 #/Go to /train page
 if [ "$@" != '-fix' ] || [ -z "$@" ]; then
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/train" -o user_agent="$(shuf -n1 userAgent.txt)" >$TMP/TRAIN
  )  </dev/null &>/dev/null &
  time_exit 20
 fi

 #/$STATUS can be obtained from any SRC file
 #/alt='hp'/> <span class='white'>19044</span> | <img src='/images/icon/mana.png' alt='mp'/> 1980</
 #local STATUS=$(grep -o -E 'hp(.*)[0-9]{1,6}(.*)\|(.*)mp(.*)[0-9]{1,6}[<][/]span' $TMP/TRAIN|grep -o -E '[0-9]+')
 #printf "$STATUS\n\n"

# Filtrar somente as linhas que contêm a <div> desejada usando o comando grep
local STATUS=$(grep -o -E "<img src='/images/icon/health.png' alt='hp'/> <span class='white'>[0-9]+</span> \| <img src='/images/icon/mana.png' alt='mp'/> [0-9]+</span>" $TMP/SRC)

# Extrair os números usando o comando sed
NOWHP=$(echo "$STATUS" | sed -n "s/.*<span class='white'>\([0-9]\+\)<\/span>.*/\1/p")
NOWMP=$(echo "$STATUS" | sed -n "s/.*<img src='\/images\/icon\/mana.png' alt='mp'\/> \([0-9]\+\)<\/span>.*/\1/p")

#/Fixed HP and MP.
 #/Needs to run -fix at least once before
 FIXHP=$(grep -o -E '\(([0-9]+)\)' $TMP/TRAIN|sed 's/[()]//g')
 FIXMP=$(grep -o -E ': [0-9]+' $TMP/TRAIN | sed -n '5s/: //p')
 #printf "$FIXHP e $FIXMP\n"
 #/Variable HP and MP
 
 #/Calculates percentage of HP and MP.
 #/Needs to run -fix at least once before
 HPPER=$(awk -v fixhp="$FIXHP" -v nowhp="$NOWHP" 'BEGIN { printf "%.0f", fixhp * nowhp / 100 }')
 MPPER=$(awk -v fixmp="$FIXMP" -v nowmp="$NOWMP" 'BEGIN { printf "%.0f", fixmp * nowmp / 100 }')
 #printf "$HPPER e $MPPER \n"
 #/e.g.
 printf "hp $NOWHP - ${HPPER} | mp $NOWMP - ${MPPER}\n"
 sleep 5s
}

messages_info () {
 echo " ⚔️ - Titans War Macro - ${version} ⚔️ " > $TMP/msg_file
 printf " -------- MAIL --------\n" >> $TMP/msg_file
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -dump "${URL}/mail" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tee $TMP/info_file|sed -n '/[|]\ mp/,/\[arrow\]/p'|sed '1,1d;$d;6q;s,\[0\],\🔴 ,g;s,\[1\]\ ,\🔵 ,g' >> $TMP/msg_file
 ) </dev/null &>/dev/null &
 time_exit 17
 printf " -------- CHAT TITANS --------\n" >> $TMP/msg_file
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -dump "${URL}/chat/titans/changeRoom" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|sed -n '/\(\»\)/,/\[chat\]/p'|sed '$d;4q;s,\[0\],\🔴 ,g;s,\[1\]\ ,\🔵 ,g' >> $TMP/msg_file
 ) </dev/null &>/dev/null &
 time_exit 17
 printf " -------- CHAT CLAN --------\n" >> $TMP/msg_file
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -dump "${URL}/chat/clan/changeRoom" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|sed -ne '/\[[^a-z]\]/,/\[chat\]/p'|sed '$d;4q;s,\[0\],\🔴 ,g;s,\[1\]\ ,\🔵 ,g' >> $TMP/msg_file
 ) </dev/null &>/dev/null &
 time_exit 17
# sed :a;N;s/\n//g;ta |
 printf "\n hp $NOWHP - ${HPPER}[%] | mp $NOWMP - ${MPPER}[%]\n" >> $TMP/msg_file
 printf "${GREEN_BLACK}${ACC}$(grep -o -E '(lvl [0-9]{1,2} \| g [0-9]{1,3}[^0-9]{0,1}[0-9]{0,3}[A-Za-z]{0,1} \| s [0-9]{1,3}[^0-9]{0,1}[0-9]{0,3}[A-Za-z]{0,1})' $TMP/info_file|sed 's/lvl/\ lvl/g;s/g/\ g/g;s/s/\ s/g')${COLOR_RESET}\n" >> $TMP/msg_file
}



