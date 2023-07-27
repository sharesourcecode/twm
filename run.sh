twm_play () {
 restart_script () {
  if [ "$RUN" != '-boot' ] ; then
   pidf=$(ps ax -o pid=,args=|grep "sh.*twm/twm.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
   until [ -z "$pidf" ] ; do
    kill -9 $pidf 2> /dev/null
    pidf=$(ps ax -o pid=,args=|grep "sh.*twm/twm.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
    sleep 1s
   done
  fi
 }
 if [ ! -s $TMP/CLD ] ; then
  clan_id
 fi
 #/game time
 TIME=$(date +%H:%M)
 case $TIME in
 (*00:00*|*00:30*|*01:00*|*01:30*|*02:00*|*02:30*|*03:00*|*03:30*) #no events time with coliseum
  standard_crono
  coliseum_start
  ;;
  
  (*04:00*|*04:30*|*05:00*|*05:30*|*06:00*|*06:30*|*07:00*|*08:30*|*09:00*|*09:30*|*11:30*|*12:00*|*13:00*|*13:30*|*14:30*|*15:30*|*17:00*|*17:30*|*18:00*|*18:30*|*19:30*|*20:00*|*20:30*|*23:00*|*23:30*) #no events time
  standard_crono
  ;;
 (09:2[8-9]) #/Clan dmg  09:30:00 - 21:30:00
  if [ -n $CLD ] ; then
   :
   #_clanmgfight
  fi
  standard_crono
  ;;
# /Valley of the Immortals 10:00:00 - 16:00:00 - 22:00:00
 (*09:5[5-9]*|*15:5[5-9]*|*21:5[5-9]*)
  undying_start
  standard_crono
  ;;
# /Battle of banners 10:15:00 - 16:15:00
 '
 (10:1[0-4])
  if [ -n $CLD ] ; then
   flagfight_start
  fi
  sleep 300s
  ;;
  '
 (*10:2[8-9]*|*14:5[8-9]*|*) # /Clan coliseum 10:30:00 - 15:00:00
  if [ -n $CLD ] ; then
   clancoliseum_start
  fi
  sleep 300s
  standard_crono
  ;;
# /Clan tournament 11:00:00 - 19:00:00
 (*10:5[5-9]*|*18:5[5-9]*)
  if [ -n $CLD ] ; then
   clanfight_start
  fi
  sleep 300s
  standard_crono
  ;;
# /King of the Immortals 12:30:00 - 16:30:00 - 22:30:00
 (*12:2[5-9]*|*16:2[5-9]*|*22:2[5-9]*)
  king_start
  standard_crono
  ;;
 
# /Ancient Altars 14:00:00 - 21:00:00
 (*13:5[5-9]*|*20:5[5-9]*)
  if [ -n $CLD ] ; then
   altars_start
  fi
  sleep 300s
  standard_crono
  ;;
 
 (21:30) # /Clan dmg  09:30:00 - 21:30:00
  #_clanmgfight
  standard_crono
  ;;

 (*)
  if echo "$RUN"|grep -q -E '[-]cl' ; then
   printf "Running in coliseum mode: $RUN\n"
   sleep 5s
   arena_duel
   coliseum_start
   messages_info
  fi
  func_sleep
  func_crono
  ;;
 esac
}
