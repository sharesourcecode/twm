#!/bin/bash
FUNC=$(cat $HOME/twm/.runmode_file)
cd $HOME/twm
#/Definindo variáveis de cores
COLOR_BLUE='\033[01;36m\033[01;07m'
COLOR_BLACK='\033[00;30m'
COLOR_CYAN='\033[01;36m\033[01;07m'
COLOR_GREEN='\033[00;32m\033[01;07m'
COLOR_RED='\033[01;38m\033[05;01m'
COLOR_RESET='\033[00m'
COLOR_YELLOW='\033[00;33m\033[01;07m'
LETTER_YELLOW='\033[33m'
#/script ads
script_ads () {
 if [ "$FUNC" != '-boot' ] && [ -f "$HOME/twm/.ads_file" ] && [ -s "$HOME/twm/.ads_file" ] && [ "$(cat $HOME/twm/.ads_file)" != "$(date +%d)" ] ; then
  if [ "$(cat $HOME/twm/.ads_file 2> /dev/null)" != "$(date +%d)" ] ; then
   xdg-open "https://apps.disroot.org/search?q=Shell+Script&category_general=on&language=pt-BR&time_range=&safesearch=1&theme=beetroot"
   echo $(date +%d) >$HOME/twm/.ads_file
  fi
 else
   echo $(date +%d) >$HOME/twm/.ads_file
 fi
}
script_ads
#/sync
if [ ! -z "$FUNC" ] ; then
 :
else
 TWMKEY=$(curl https://codeberg.org/ueliton/auth/raw/branch/main/auth -s -L | base64 -d)
 SERVER='https://gitea.com/api/v1/repos/Ueliton/twm/raw/master/'
 remote_count=$(curl -H "Authorization: token $TWMKEY" ${SERVER}sourceinstall.sh -s -L | wc -c)
 if [ -e "$HOME/twm/sourceinstall.sh" ] ; then
  local_count=$(wc -c < "$HOME/twm/sourceinstall.sh")
 else
  local_count=1
 fi
 if awk -v remote="$remote_count" -v local="$local_count" 'BEGIN {if (remote == local) exit 0; else exit 1}' ; then
  :
 else
  if ! curl -s --head --request GET titanswar.net | grep "200 OK" > /dev/null ; then
   echo -e "${COLOR_RED}Network error! Please check your internet connection.${COLOR_RESET}"
   exit 1
  else
   rm $HOME/twm/easyinstall.s*
   curl -H "Authorization: token $TWMKEY" ${SERVER}easyinstall.sh -s -L >$HOME/twm/easyinstall.sh
   rm $HOME/easyinstall.s*
   cp $HOME/twm/easyinstall.sh $HOME/easyinstall.sh
   SYNC=1
   chmod +x $HOME/easyinstall.sh
   . $HOME/easyinstall.sh
  fi
 fi
fi
printf "${COLOR=CYAN}\n Starting...\n👉 Please wait...☕👴${COLOR=RESET}\n"
script_slogan () {
 colors="10 9 8 7 6 5 4 3 2 1"
 t=339
 w=59
 m=89
 author="ueliton@disroot.org 2019 - 2023"
 for i in $colors ; do
  clear
  t=$((t - 27))
  w=$((w + 1))
  m=$((m - 2))
  # //⟨
  printf "\033[1;38;5;${t}m  ╔══╗╔╗╔══╗╔══╗╔══╗╔══╗
  ╚╗╔╝╠╣╚╗╔╝║╔╗║║╔╗║║══╣
  ${COLOR_BLACK}═\033[1;38;5;${t}m║║${COLOR_BLACK}═\033[1;38;5;${t}m║║${COLOR_BLACK}═\033[1;38;5;${t}m║║${COLOR_BLACK}═\033[1;38;5;${t}m║╔╗║║║║║╠══║
  ${COLOR_BLACK}═\033[1;38;5;${t}m╚╝${COLOR_BLACK}═\033[1;38;5;${t}m╚╝${COLOR_BLACK}═\033[1;38;5;${t}m╚╝${COLOR_BLACK}═\033[1;38;5;${t}m╚╝╚╝╚╝╚╝╚══╝\033[1;38;5;${w}m
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
  printf "\033[1;38;5;${i}m${author}${COLOR_RESET}\n"
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
  local FPID=$(echo $! | grep -o -E '([0-9]{2,6})')
  for TE in $(seq "$@" -1 0) ; do
   local RPID=$(ps ax -o pid= | grep -o "$FPID")
   if [ -z "$RPID" ] ; then
    local TE=0
    break &>/dev/null
   elif [ "$TE" -lt 1 ] ; then
    kill -s PIPE $FPID &>/dev/null
    kill -15 $FPID &>/dev/null
    printf "${COLOR_RED}Command execution was interrupted!${COLOR_RESET}\n"
    local TE=0
    break &>/dev/null
   fi
   sleep 1s
  done
 )
}
#/+colors
ww_='\033[01;36m\033[01;07m'
_w_='\033[01;36m\033[08;07m'
rr_='\033[01;31m\033[01;07m'
gg_='\033[01;32m\033[01;07m'
y_='\033[33m\033'
yy_='\033[00;33m\033[01;07m'
bi_='\033[03;34m\033[02;03m'
b__='\033[03;34m\033[02;04m'
pp_='\033[01;35m\033[01;07m'
b_='\033[36m\033'
c_='\033[37m\033'
#cc_='\033[00m'
#/sources
cd ~/twm
#sed -n 1,129 /remove sources to easyinstall.sh
#. clandmgfight.sh
. requeriments.sh ; . loginlogoff.sh
. flagfight.sh ; . clanid.sh ; . crono.sh ; . arena.sh ; . coliseum.sh
. campaign.sh ; . run.sh ; . altars.sh ; . clanfight.sh
. clancoliseum.sh ; . king.sh ; . undying.sh ; . clandungeon.sh
. trade.sh ; . career.sh ; . cave.sh ; . allies.sh ; . svproxy.sh
#sed -n 136,last /remove sources to easyinstall.sh
#/functions
twm_start () {
 case $FUNC in
 (-cv)
  PLAY='cv' && cave_start ;;
 (-cl)
  PLAY='cl'
  twm_play ;;
 (-boot|""|*)
  PLAY='boot'
  twm_play ;;
 esac
}
#func_access () {
# HLHP=$((FULL * HPER / 100))
# ATK=$(grep -o -E '(/[a-z]+/[a-z]{0,4}at[a-z]{0,3}k/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/SRC | sed -n 1p)
# ATKRND=$(grep -o -E '(/[a-z]+/at[a-z]{0,3}k[a-z]{3,6}/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/SRC)
# DODGE=$(grep -o -E '(/[a-z]+/dodge/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/SRC)
# HEAL=$(grep -o -E '(/[a-z]+/heal/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/SRC)
# stone=$(grep -o -E '(/[a-z]+/stone/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/SRC)
# GRASS=$(grep -o -E '(/[a-z]+/grass/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/SRC)
# SHIELD=$(grep -o -E '(/[a-z]+/shield/[^A-Za-z0-9]r[^A-Za-z0-9][0-9]+)' $TMP/SRC)
# DT=$(grep -o -E 'dodge(.*)dgreen medium[^0-9]{2}00:(0|1|2)[0-9]{1}(.*)/at' $TMP/SRC | grep -o -E '[0-9]{2}:[0-9]{2}' | tail -n1)
# HT=$(grep -o -E '[^A-Za-z0-9]heal[^A-Za-z0-9](.*)[0-9]{1,2}:[0-9]{2}(.*)/stone/' $TMP/SRC | grep -m1 -o -E '[0-9]{2}:[0-9]{2}' | tail -n1)
# ST=$(grep -o -E '/stone/(.*)00:[0-9]{2}(.*)/grass/' $TMP/SRC | grep -o -E '[0-9]{2}:[0-9]{2}' | tail -n1)
# GT=$(grep -o -E '/grass/(.*)00:[0-9]{2}(.*)/[A-Za-z]+/' $TMP/SRC | grep -o -E '[0-9]{2}:[0-9]{2}' | tail -n1)
# CT=$(grep -o -E '/images/icon/health.png(.*)(0|1)[0-9]{1}:[0-9]{2}(.*)/images/icon/health.png' $TMP/SRC | grep -o -E '[0-9]{2}:[0-9]{2}' | head -n1)
# BEXIT=$(grep -o 'user.png' $TMP/SRC)
# OUTGATE=$(grep -o 'out_gate' $TMP/SRC)
# LEAVEFIGHT=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/leaveFight/' | head -n1 | awk -F"[']" '{ print $2 }')
# WDRED=$(cat $TMP/SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | awk -F"[']" '{ print $4 }') #white/dred
# twm_show
#}
func_unset () {
 unset HP1 HP2 YOU USER CLAN ENTER ENTER ATK ATKRND DODGE HEAL BEXIT OUTGATE LEAVEFIGHT WDRED HLHP
}
if [ -f "$HOME/twm/.ur_file" ] && [ -s "$HOME/twm/.ur_file" ] ; then
 printf "\033[32m\033\ Starting with last settings used.\033[00m\n"
 num=6
 for i in `seq 6 -1 1` ; do
  i=$((i - 1))
  if read -t1 ; then
   >$HOME/twm/.al_file
   >$HOME/twm/.ur_file
   >$HOME/twm/fileAgent.txt
   unset UR
   unset UA
   unset AL
   break &> /dev/null
  fi
  printf " Hit\033[33m\033\ [Enter]\033[00m to\033[33m\033\ reconfigure\033[32m\033\ "$i"s\e[00m\n"
 done
fi
requer_func
func_proxy
messages_info () {
 printf "\ ##### mail #####\n" > $TMP/msg_file
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug ${URL}/mail -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" | tee $TMP/info_file | sed -n '/[|]\ mp/,/\[arrow\]/p' | sed '1,1d;$d;6q' >> $TMP/msg_file
 ) </dev/null &>/dev/null &
 time_exit 17
 printf "##### chat titans #####\n" >> $TMP/msg_file
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug ${URL}/chat/titans/changeRoom -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" | sed -n '/\(\»\)/,/\[chat\]/p' | sed '$d;4q' >> $TMP/msg_file
 ) </dev/null &>/dev/null &
 time_exit 17
 printf "##### chat clan #####\n" >> $TMP/msg_file
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug ${URL}/chat/clan/changeRoom -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" | sed -ne '/\[[^a-z]\]/,/\[chat\]/p' | sed '$d;4q' >> $TMP/msg_file
 ) </dev/null &>/dev/null &
 time_exit 17
# lvl | g | s
# sed ':a;N;s/\n//g;ta' |
 printf "${ACC}$(grep -o -E '(lvl [0-9]{1,2} \| g [0-9]{1,3}[^0-9]{0,1}[0-9]{0,3}[A-Za-z]{0,1} \| s [0-9]{1,3}[^0-9]{0,1}[0-9]{0,3}[A-Za-z]{0,1})' $TMP/info_file | sed 's/lvl/\ lvl/g;s/g/\ g/g;s/s/\ s/g')\n" >> $TMP/msg_file
}
login_logoff
if [ -n "$ALLIES" ] && [ "$FUNC" != "-cv" ] ; then
 conf_allies
fi
messages_info
while true ; do
 sleep 1s
 twm_start
done
