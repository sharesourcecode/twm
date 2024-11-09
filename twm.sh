#!/bin/bash

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

twm_dir="twm-master"

SERVER="https://raw.githubusercontent.com/sharesourcecode/twm/refs/heads/master/"
#SERVER="https://codeberg.org/ueliton/TitansWarMacro/raw/branch/master/"

UAGT='Mozilla/5.0 (SymbianOS/9.4; Series60/5.0 NokiaN97-1/20.0.019; Profile/MIDP-2.1 Configuration/CLDC-1.1) AppleWebKit/525 (KHTML, like Gecko) BrowserNG/7.1.18124'

# LANGUAGE.po
LANGUAGE="2";content=$(curl -H "${UAGT}" -s -L "${SERVER}/LANGUAGE.po")

#printf "\n• Loading remote software libraries...\n- - - - -	Please wait	- - - - -\n"
#LIBS=$(curl -H ${UAGT} -s -L ${SERVER}/info.lib; curl -H ${UAGT} -s -L ${SERVER}requeriments.lib; curl -H ${UAGT} -s -L ${SERVER}loginlogoff.lib; curl -H ${UAGT} -s -L ${SERVER}online.lib; curl -H ${UAGT} -s -L ${SERVER}flagfight.lib; curl -H ${UAGT} -s -L ${SERVER}clanid.lib; curl -H ${UAGT} -s -L ${SERVER}crono.lib; curl -H ${UAGT} -s -L ${SERVER}arena.lib; curl -H ${UAGT} -s -L ${SERVER}coliseum.lib; curl -H ${UAGT} -s -L ${SERVER}campaign.lib; curl -H ${UAGT} -s -L ${SERVER}run.lib; curl -H ${UAGT} -s -L ${SERVER}altars.lib; curl -H ${UAGT} -s -L ${SERVER}clanfight.lib; curl -H ${UAGT} -s -L ${SERVER}clancoliseum.lib; curl -H ${UAGT} -s -L ${SERVER}king.lib; curl -H ${UAGT} -s -L ${SERVER}undying.lib; curl -H ${UAGT} -s -L ${SERVER}clandungeon.lib; curl -H ${UAGT} -s -L ${SERVER}trade.lib; curl -H ${UAGT} -s -L ${SERVER}career.lib; curl -H ${UAGT} -s -L ${SERVER}cave.lib; curl -H ${UAGT} -s -L ${SERVER}allies.lib; curl -H ${UAGT} -s -L ${SERVER}svproxy.lib; curl -H ${UAGT} -s -L ${SERVER}check.lib)

printf "\n• Loading local software libraries...\n- - - - -	Please wait	- - - - -\n"
LIBS=$(cat $HOME/$twm_dir/info.lib; cat $HOME/$twm_dir/requeriments.lib; cat $HOME/$twm_dir/loginlogoff.lib; cat $HOME/$twm_dir/online.lib; cat $HOME/$twm_dir/flagfight.lib; cat $HOME/$twm_dir/clanid.lib; cat $HOME/$twm_dir/crono.lib; cat $HOME/$twm_dir/arena.lib; cat $HOME/$twm_dir/coliseum.lib; cat $HOME/$twm_dir/campaign.lib; cat $HOME/$twm_dir/run.lib; cat $HOME/$twm_dir/altars.lib; cat $HOME/$twm_dir/clanfight.lib; cat $HOME/$twm_dir/clancoliseum.lib; cat $HOME/$twm_dir/king.lib; cat $HOME/$twm_dir/undying.lib; cat $HOME/$twm_dir/clandungeon.lib; cat $HOME/$twm_dir/trade.lib; cat $HOME/$twm_dir/career.lib; cat $HOME/$twm_dir/cave.lib; cat $HOME/$twm_dir/allies.lib; cat $HOME/$twm_dir/svproxy.lib; cat $HOME/$twm_dir/check.lib) && \

eval "$LIBS" && \
unset LIBS UAGT SERVER

colors
RUN=$(cat $HOME/$twm_dir/runmode_file)
cd $HOME/$twm_dir

script_ads () {
 if [ "$RUN" != '-boot' ] && [ -f "$HOME/$twm_dir/ads_file" ] && [ -s "$HOME/$twm_dir/ads_file" ] && [ "$(cat $HOME/$twm_dir/ads_file)" != "$(date +%d)" ] ; then
  if [ "$(cat $HOME/$twm_dir/ads_file 2> /dev/null)" != "$(date +%d)" ] ; then
   xdg-open "https://masto.pt/invite/XzjEurkb" #xdg-open "https://apps.disroot.org/search?q=Shell+Script&category_general=on&language=pt-BR&time_range=&safesearch=1&theme=beetroot"
   echo $(date +%d) >$HOME/$twm_dir/ads_file
  fi
 else
   echo $(date +%d) >$HOME/$twm_dir/ads_file
 fi
}
script_ads

printf "${BLACK_CYAN}\n $(G_T "Starting")...\n👉 $(G_T "Please wait")...☕👴${COLOR_RESET}\n"
#. $HOME/$twm_dir/info.lib
script_slogan
sleep 1s
#/termux
if [ -d /data/data/com.termux/files/usr/share/doc ] ; then
 termux-wake-lock
 LS='/data/data/com.termux/files/usr/share/doc'
else
 LS='/usr/share/doc'
fi

cd $HOME/$twm_dir

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
if [ -f "$HOME/$twm_dir/ur_file" ] && [ -s "$HOME/$twm_dir/ur_file" ] ; then
 printf "${GREEN_BLACK} $(G_T "Starting with last settings used").${COLOR_RESET}\n"
 num=6
 for i in `seq 6 -1 1` ; do
  i=$((i - 1))
  if read -t "0.5" ; then
   >$HOME/$twm_dir/al_file
   >$HOME/$twm_dir/ur_file
   >$HOME/$twm_dir/fileAgent.txt
   unset UR
   unset UA
   unset AL
   break &>/dev/null
  fi
  printf "$(G_T "Hit")${GOLD_BLACK} [Enter]${COLOR_RESET} $(G_T "to")${GOLD_BLACK} $(G_T "reconfigure")${GREEN_BLACK} ${i}$(G_T "s")${COLOR_RESET}\n"
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

#User-agent testing. Use Q to close:
#w3m $(echo "aHR0cHM6Ly93d3cud2hhdHNteXVhLmluZm8=" | base64 -d) -o user_agent="$(sed -n "${random_agent}p" $TMP/userAgent.txt)"

while true ; do
 sleep 1s
 twm_start
done
