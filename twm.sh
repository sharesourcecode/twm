#!/bin/bash
RUN=$(cat $HOME/twm/runmode_file)
cd $HOME/twm
#/Colors - font(formatting)_background
BLACK_BLACK='\033[00;30m'
BLACK_CYAN='\033[01;36m\033[01;07m'
BLACK_GRAY='\033[01;30m\033[01;07m'
BLACK_GREEN='\033[00;32m\033[01;07m'
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
#/script ads
script_ads () {
 if [ "$RUN" != '-boot' ] && [ -f "$HOME/twm/ads_file" ] && [ -s "$HOME/twm/ads_file" ] && [ "$(cat $HOME/twm/ads_file)" != "$(date +%d)" ] ; then
  if [ "$(cat $HOME/twm/ads_file 2> /dev/null)" != "$(date +%d)" ] ; then
   xdg-open "https://apps.disroot.org/search?q=Shell+Script&category_general=on&language=pt-BR&time_range=&safesearch=1&theme=beetroot"
   echo $(date +%d) >$HOME/twm/ads_file
  fi
 else
   echo $(date +%d) >$HOME/twm/ads_file
 fi
}
script_ads
#/sync
if [ ! -z "$RUN" ] ; then
 :
else
 TWMKEY=$(curl https://codeberg.org/ueliton/auth/raw/branch/main/auth -s -L|base64 -d)
 SERVER='https://raw.githubusercontent.com/sharesourcecode/twm/master/'
 remote_count=$(curl ${SERVER}sourceinstall.sh -s -L|wc -c)
 if [ -e "$HOME/twm/sourceinstall.sh" ] ; then
  local_count=$(wc -c < "$HOME/twm/sourceinstall.sh")
 else
  local_count=1
 fi
 if awk -v remote="$remote_count" -v local="$local_count" 'BEGIN {if (remote == local) exit 0; else exit 1}' ; then
  :
 else
  if ! curl -s --head --request GET titanswar.net|grep "200 OK" > /dev/null ; then
   printf "${WHITEb_BLACK}Network error! Please check your internet connection.${BLACK_RESET}\n"
   exit 1
  else
   rm $HOME/twm/easyinstall.s*
   curl ${SERVER}easyinstall.sh -s -L >$HOME/twm/easyinstall.sh
   rm $HOME/easyinstall.s*
   cp $HOME/twm/easyinstall.sh $HOME/easyinstall.sh
   SYNC=1
   chmod +x $HOME/easyinstall.sh
   . $HOME/easyinstall.sh
  fi
 fi
fi
printf "${BLACK_CYAN}\n Starting...\n👉 Please wait...☕👴${COLOR_RESET}\n"
script_slogan () {
 colors="10 9 8 7 6 5 4 3 2 1"
 t=339
 w=59
 m=89
 author="ueliton@disroot.org 2019 - 2023"
 collaborator="@_hviegas"
 version="Version: 1.0"
 for i in $colors ; do
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
  printf "\033[1;38;5;${i}m${author}\n${collaborator}${COLOR_RESET}\n"
  sleep 0.3s
 done
}
script_slogan
sleep 1s
#/termux
if [ -d /data/data/com.termux/files/usr/share/doc ] ; then
 termux-wake-lock
 LS='/data/data/com.termux/files/usr/share/doc'
else
 LS='/usr/share/doc'
fi
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
#/sources
cd ~/twm
#sed -n 1,126 /remove sources to easyinstall.sh
#. clandmgfight.sh
. requeriments.sh ; . loginlogoff.sh
. flagfight.sh ; . clanid.sh ; . crono.sh ; . arena.sh ; . coliseum.sh
. campaign.sh ; . run.sh ; . altars.sh ; . clanfight.sh
. clancoliseum.sh ; . king.sh ; . undying.sh ; . clandungeon.sh
. trade.sh ; . career.sh ; . cave.sh ; . allies.sh ; . svproxy.sh
#sed -n 133,196 /remove sources to easyinstall.sh
#/functions
twm_start () {
 if echo "$RUN"|grep -q -E '[-]cv' ; then
  cave_start
 elif echo "$RUN"|grep -q -E '[-]cl' ; then
  twm_play
 elif echo "$RUN"|grep -q -E '[-]boot' ; then
  twm_play
 else
  twm_play
 fi
}
func_unset () {
 unset HP1 HP2 YOU USER CLAN ENTER ENTER ATK ATKRND DODGE HEAL BEXIT OUTGATE LEAVEFIGHT WDRED HLHP
}
if [ -f "$HOME/twm/ur_file" ] && [ -s "$HOME/twm/ur_file" ] ; then
 printf "${GREEN_BLACK} Starting with last settings used.${COLOR_RESET}\n"
 num=6
 for i in `seq 6 -1 1` ; do
  i=$((i - 1))
  if read -t 1 ; then
   >$HOME/twm/al_file
   >$HOME/twm/ur_file
   >$HOME/twm/fileAgent.txt
   unset UR
   unset UA
   unset AL
   break &>/dev/null
  fi
  printf " Hit${GOLD_BLACK} [Enter]${COLOR_RESET} to${GOLD_BLACK} reconfigure${GREEN_BLACK} ${i}s${COLOR_RESET}\n"
 done
fi
requer_func
func_proxy
messages_info () {
  printf " ##### Titan #####\n" > $TMP/msg_file
    #mana= "/images/icon/mana[.]png"
    (
        w3m -cookie -o -A 1 http_proxy=$PROXY -o accept_encoding=UTF-8 -dump "${url}/images/icon/mana[.]png{1,4}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tee $TMP/info_file|sed -n '/[|]\ mp/,/\[arrow\]/p'|sed '1,1d;$d;6q' >> $TMP/msg_file
    ) </dev/null &>/dev/null &
    time_exit 17

  #health= "/images/icon/health[.]png"
    (
        w3m -cookie -o -A 1 http_proxy=$PROXY -o accept_encoding=UTF-8 -dump "${url}/images/icon/health[.]png{1,4}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tee $TMP/info_file|sed -n '/[|]\ mp/,/\[arrow\]/p'|sed '1,1d;$d;6q' >> $TMP/msg_file
    ) </dev/null &>/dev/null &
    time_exit 17
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
 printf "${ACC}$(grep -o -E '(lvl [0-9]{1,2} \| g [0-9]{1,3}[^0-9]{0,1}[0-9]{0,3}[A-Za-z]{0,1} \| s [0-9]{1,3}[^0-9]{0,1}[0-9]{0,3}[A-Za-z]{0,1})' $TMP/info_file|sed 's/lvl/\ lvl/g;s/g/\ g/g;s/s/\ s/g')\n" >> $TMP/msg_file
}
login_logoff
if [ -n "$ALLIES" ] && [ "$RUN" != "-cv" ] ; then
 conf_allies
fi
messages_info
while true ; do
 sleep 1s
 twm_start
done
