#!/bin/bash
. $HOME/info.sh
colors
RUN=$(cat $HOME/twm/runmode_file)
cd $HOME/twm

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

printf "${BLACK_CYAN}\n Starting...\n👉 Please wait...☕👴${COLOR_RESET}\n"
. $HOME/info.sh
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
cd ~/twm
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

if [ -f "$HOME/twm/ur_file" ] && [ -s "$HOME/twm/ur_file" ] ; then
 printf "${GREEN_BLACK} Starting with last settings used.${COLOR_RESET}\n"
 num=6
 for i in `seq 4 -1 1` ; do
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
login_logoff
if [ -f "$HOME/twm/al_file" ] && [ -s "$HOME/twm/al_file" ] ; then
  ALLIES=$(cat $HOME/twm/al_file)
fi
if [ -n "$ALLIES" ] && [ "$RUN" != "-cv" ] ; then
 conf_allies
 clear
fi

func_cat
hpmp -fix
messages_info
while true ; do
 sleep 1s
 twm_start
done