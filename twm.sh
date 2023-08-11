#!/bin/bash
. twm//info.sh
colors
RUN=$(cat twm//runmode_file)
cd twm/

script_ads () {
 if [ "$RUN" != '-boot' ] && [ -f "twm//ads_file" ] && [ -s "twm//ads_file" ] && [ "$(cat twm//ads_file)" != "$(date +%d)" ] ; then
  if [ "$(cat twm//ads_file 2> /dev/null)" != "$(date +%d)" ] ; then
   xdg-open "https://apps.disroot.org/search?q=Shell+Script&category_general=on&language=pt-BR&time_range=&safesearch=1&theme=beetroot"
   echo $(date +%d) >twm//ads_file
  fi
 else
   echo $(date +%d) >twm//ads_file
 fi
}
script_ads

printf "${BLACK_CYAN}\n Starting...\n👉 Please wait...☕👴${COLOR_RESET}\n"
#. twm//info.sh
script_slogan
sleep 1s
#/termux
if [ -d /data/data/com.termux/files/usr/share/doc ] ; then
 termux-wake-lock
 LS='/data/data/com.termux/files/usr/share/doc'
else
 LS='/usr/share/doc'
fi

#/sources
cd twm/
#/twm.sh before sources <<
#. clandmgfight.sh
. requeriments.sh ; . loginlogoff.sh
. flagfight.sh ; . clanid.sh ; . crono.sh ; . arena.sh ; . coliseum.sh
. campaign.sh ; . run.sh ; . altars.sh ; . clanfight.sh
. clancoliseum.sh ; . king.sh ; . undying.sh ; . clandungeon.sh
. trade.sh ; . career.sh ; . cave.sh ; . allies.sh ; . svproxy.sh ; . check.sh
#/twm.sh after sources >>
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
if [ -f "twm//ur_file" ] && [ -s "twm//ur_file" ] ; then
 printf "${GREEN_BLACK} Starting with last settings used.${COLOR_RESET}\n"
 num=6
 for i in `seq 6 -1 1` ; do
  i=$((i - 1))
  if read -t 1 ; then
   >twm//al_file
   >twm//ur_file
   >twm//fileAgent.txt
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
login_logoff
if [ -n "$ALLIES" ] && [ "$RUN" != "-cv" ] ; then
 conf_allies
 clear
fi

func_cat
messages_info
while true ; do
 sleep 1s
 twm_start
done

#/sync
: ' comparing local package
if [ ! -z "$RUN" ] ; then
 :
else
 TWMKEY=$(curl https://codeberg.org/ueliton/auth/raw/branch/main/auth -s -L|base64 -d)
 SERVER='https://raw.githubusercontent.com/sharesourcecode/twm/master/'
 remote_count=$(curl ${SERVER}sourceinstall.sh -s -L|wc -c)
 if [ -e "twm//sourceinstall.sh" ] ; then
  local_count=$(wc -c < "twm//sourceinstall.sh")
 else
  local_count=1
 fi
 '
 #if awk -v remote="$remote_count" -v local="$local_count" 'BEGIN {if (remote == local) exit 0; else exit 1}' ; then
  : '
 else
  if ! curl -s --head --request GET titanswar.net|grep "200 OK" > /dev/null ; then
   printf "${WHITEb_BLACK}Network error! Please check your internet connection.${BLACK_RESET}\n"
   exit 1
  else
   rm twm//easyinstall.s*
   curl ${SERVER}easyinstall.sh -s -L >twm//easyinstall.sh
   rm $HOME/easyinstall.s*
   cp twm//easyinstall.sh $HOME/easyinstall.sh
   SYNC=1
   chmod +x $HOME/easyinstall.sh
   . $HOME/easyinstall.sh
  fi
 fi
fi
'
