#!/bin/bash

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

twm_dir="twm-master"
cd $HOME/$twm_dir

SERVER="https://raw.githubusercontent.com/sharesourcecode/twm/refs/heads/master/"
#SERVER="https://codeberg.org/ueliton/TitansWarMacro/raw/branch/master/"

UAGT='Mozilla/5.0 (SymbianOS/9.4; Series60/5.0 NokiaN97-1/20.0.019; Profile/MIDP-2.1 Configuration/CLDC-1.1) AppleWebKit/525 (KHTML, like Gecko) BrowserNG/7.1.18124'

# LANGUAGE.po
content=$(curl -H "${UAGT}" -s -L "${SERVER}/LANGUAGE.po")

#printf "\n• Loading remote software libraries...\n- - - - -	Please wait	- - - - -\n"
#LIBS=$(curl -H ${UAGT} -s -L ${SERVER}/info.lib; curl -H ${UAGT} -s -L ${SERVER}requeriments.lib; curl -H ${UAGT} -s -L ${SERVER}loginlogoff.lib; curl -H ${UAGT} -s -L ${SERVER}online.lib; curl -H ${UAGT} -s -L ${SERVER}flagfight.lib; curl -H ${UAGT} -s -L ${SERVER}clanid.lib; curl -H ${UAGT} -s -L ${SERVER}crono.lib; curl -H ${UAGT} -s -L ${SERVER}arena.lib; curl -H ${UAGT} -s -L ${SERVER}coliseum.lib; curl -H ${UAGT} -s -L ${SERVER}campaign.lib; curl -H ${UAGT} -s -L ${SERVER}run.lib; curl -H ${UAGT} -s -L ${SERVER}altars.lib; curl -H ${UAGT} -s -L ${SERVER}clanfight.lib; curl -H ${UAGT} -s -L ${SERVER}clancoliseum.lib; curl -H ${UAGT} -s -L ${SERVER}king.lib; curl -H ${UAGT} -s -L ${SERVER}undying.lib; curl -H ${UAGT} -s -L ${SERVER}clandungeon.lib; curl -H ${UAGT} -s -L ${SERVER}trade.lib; curl -H ${UAGT} -s -L ${SERVER}career.lib; curl -H ${UAGT} -s -L ${SERVER}cave.lib; curl -H ${UAGT} -s -L ${SERVER}allies.lib; curl -H ${UAGT} -s -L ${SERVER}svproxy.lib; curl -H ${UAGT} -s -L ${SERVER}check.lib)

printf "\n• Loading local software libraries...\n- - - - -	Please wait	- - - - -\n"
LOADLIBS="info.lib requeriments.lib loginlogoff.lib online.lib flagfight.lib clanid.lib crono.lib arena.lib coliseum.lib campaign.lib run.lib altars.lib clanfight.lib clancoliseum.lib king.lib undying.lib clandungeon.lib trade.lib career.lib cave.lib allies.lib svproxy.lib check.lib"

for lib in $LOADLIBS; do
 lib_content=`< "$HOME/$twm_dir/$lib"` && \
 eval "$lib_content" && \
 unset lib lib_content
done

unset UAGT SERVER LOADLIBS

colors
RUN=`< "$HOME/$twm_dir/runmode_file"`

script_ads() {

 if [ -e "$HOME/$twm_dir/ads_file" ]; then

   if [ `< "$HOME/$twm_dir/ads_file"` != "$(date +%d)" ]; then
     xdg-open https://github.com/sharesourcecode/twm/blob/master/README.md
     echo $(date +%d) >$HOME/$twm_dir/ads_file
   fi

 else
   xdg-open https://github.com/sharesourcecode/twm/blob/master/README.md
   echo $(date +%d) >$HOME/$twm_dir/ads_file
 fi

}

script_ads

printf "${BLACK_CYAN}\n $(G_T "Starting")...\n👉 $(G_T "Please wait")...☕👴${COLOR_RESET}\n"
script_slogan
sleep 1s

#/termux
if [ -d /data/data/com.termux/files/usr/share/doc ]; then
 termux-wake-lock
 LS='/data/data/com.termux/files/usr/share/doc'
else
 LS='/usr/share/doc'
fi

twm_start() {

 if echo "$RUN"|grep -q -E '[-]cv'; then
   cave_start
 elif echo "$RUN"|grep -q -E '[-]cl'; then
   twm_play
 elif echo "$RUN"|grep -q -E '[-]boot'; then
   twm_play
 else
   twm_play
 fi

}

func_unset() {
 unset HP1 HP2 YOU USER CLAN ENTER ENTER ATK ATKRND DODGE HEAL BEXIT OUTGATE LEAVEFIGHT WDRED HLHP
}

if [ -f "$HOME/$twm_dir/ur_file" ] && [ -s "$HOME/$twm_dir/ur_file" ]; then
 printf "${GREEN_BLACK} $(G_T "Starting with last settings used").${COLOR_RESET}\n"
 num=6

 for i in `seq 6 -1 1`; do
   i=$((i - 1))

   if read -t "0.5"; then
     >$HOME/$twm_dir/lang_file
     >$HOME/$twm_dir/al_file
     >$HOME/$twm_dir/ur_file
     >$HOME/$twm_dir/fileAgent.txt
     unset LANGUAGE
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

#User-agent testing. Use Q to close:
#w3m $(echo "aHR0cHM6Ly93d3cud2hhdHNteXVhLmluZm8=" | base64 -d) -o user_agent="$user_agent"

login_logoff

if [ "$RUN" != "-cv" ]; then
 conf_allies
 clear
fi

func_cat
messages_info

while true; do
 sleep 1s
 twm_start
done
