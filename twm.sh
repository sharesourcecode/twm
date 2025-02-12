#!/bin/bash

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

twm_dir="twm"
cd $HOME/$twm_dir

SERVER="https://git.disroot.org/BourneShell/twm/raw/branch/master/"

UAGT='Mozilla/5.0 (SymbianOS/9.4; Series60/5.0 NokiaN97-1/20.0.019; Profile/MIDP-2.1 Configuration/CLDC-1.1) AppleWebKit/525 (KHTML, like Gecko) BrowserNG/7.1.18124'

# LANGUAGE.po
content=$(curl -H "${UAGT}" -s -L "${SERVER}/LANGUAGE.po")

#printf "\n• Loading remote software libraries...\n- - - - -	Please wait	- - - - -\n"
#LIBS=$(curl -H ${UAGT} -s -L ${SERVER}/info.lib; curl -H ${UAGT} -s -L ${SERVER}requeriments.lib; curl -H ${UAGT} -s -L ${SERVER}loginlogoff.lib; curl -H ${UAGT} -s -L ${SERVER}online.lib; curl -H ${UAGT} -s -L ${SERVER}flagfight.lib; curl -H ${UAGT} -s -L ${SERVER}clanid.lib; curl -H ${UAGT} -s -L ${SERVER}crono.lib; curl -H ${UAGT} -s -L ${SERVER}arena.lib; curl -H ${UAGT} -s -L ${SERVER}coliseum.lib; curl -H ${UAGT} -s -L ${SERVER}campaign.lib; curl -H ${UAGT} -s -L ${SERVER}run.lib; curl -H ${UAGT} -s -L ${SERVER}altars.lib; curl -H ${UAGT} -s -L ${SERVER}clanfight.lib; curl -H ${UAGT} -s -L ${SERVER}clancoliseum.lib; curl -H ${UAGT} -s -L ${SERVER}king.lib; curl -H ${UAGT} -s -L ${SERVER}undying.lib; curl -H ${UAGT} -s -L ${SERVER}clandungeon.lib; curl -H ${UAGT} -s -L ${SERVER}trade.lib; curl -H ${UAGT} -s -L ${SERVER}career.lib; curl -H ${UAGT} -s -L ${SERVER}cave.lib; curl -H ${UAGT} -s -L ${SERVER}allies.lib; curl -H ${UAGT} -s -L ${SERVER}svproxy.lib; curl -H ${UAGT} -s -L ${SERVER}check.lib)

printf "\n• Loading local software libraries...\n- - - - -	Please wait	- - - - -\n"
LOADLIBS="info.lib requeriments.lib loginlogoff.lib online.lib flagfight.lib clanid.lib crono.lib arena.lib coliseum.lib campaign.lib run.lib altars.lib clanfight.lib clancoliseum.lib king.lib undying.lib clandungeon.lib trade.lib career.lib cave.lib allies.lib svproxy.lib check.lib"

for lib in $LOADLIBS; do
 lib_content=`dd if=$HOME/$twm_dir/$lib 2>/dev/null` && \
 eval "$lib_content" && \
 unset lib lib_content
done

unset UAGT SERVER LOADLIBS

colors
RUN=`dd if=$HOME/$twm_dir/runmode_file 2>/dev/null`

script_ads() {

 if [ -e "$HOME/$twm_dir/ads_file" ]; then

   if [ `dd if=$HOME/$twm_dir/ads_file 2>/dev/null` != "$(date +%d)" ]; then
     xdg-open https://git.disroot.org/BourneShell/twm/src/branch/master/README.md
     echo $(date +%d) >$HOME/$twm_dir/ads_file
   fi

 else
   xdg-open https://git.disroot.org/BourneShell/twm/src/branch/master/README.md
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

 if [ "$RUN" = "acv" ]; then
   cave_start
 elif [ "$RUN" = "acl" ]; then
   twm_play
 elif [ "$RUN" = "aboot" ]; then
   twm_play
 else
   twm_play
 fi

}

func_unset() {
 unset HP1 HP2 YOU USER CLAN ENTER ENTER ATK ATKRND DODGE HEAL BEXIT OUTGATE LEAVEFIGHT WDRED HLHP
}

files="$HOME/$twm_dir/lang_file $HOME/$twm_dir/al_file $HOME/$twm_dir/ur_file $HOME/$twm_dir/fileAgent.txt"

for file in $files; do

 if test -e "$file"; then
   status=0

   if test -s "$file"; then
     status=0
   else
     status=1
   fi

 else
   status=1
 fi

done

if [ "$status" -eq 0 ]; then
  printf "${GREEN_BLACK} $(G_T "Starting with last settings used").${COLOR_RESET}\n"
  printf "$(G_T "Hit")${GOLD_BLACK} [Enter]${COLOR_RESET} $(G_T "to reconfigure, or wait")${GREEN_BLACK} 5$(G_T "s")${COLOR_RESET}\n"
  ( sleep 5s && pkill -SIGTERM -s 0 dd ) </dev/null &>/dev/null &
  input=$(dd bs=512 count=1 2>/dev/null) || input=3
fi

if [ -z "$input" ] || [ "$status" -eq 1 ]; then
  >$HOME/$twm_dir/lang_file
  >$HOME/$twm_dir/al_file
  >$HOME/$twm_dir/ur_file
  >$HOME/$twm_dir/fileAgent.txt
  unset LANGUAGE
  unset UR
  unset UA
  unset AL
fi

requer_func
func_proxy

#User-agent testing. Use Q to close:
#w3m $(echo "aHR0cHM6Ly93d3cud2hhdHNteXVhLmluZm8=" | base64 -d) -o user_agent="$user_agent"

login_logoff

if [ "$RUN" != "acv" ]; then
 conf_allies
 clear
fi

func_cat
messages_info

while true; do
 sleep 1s
 twm_start
done
