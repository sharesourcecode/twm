twm_play() {
 restart_script () {
  if [ "$(cat ~/twm/.runmode_file)" != '-boot' ]; then
   pidf=$(ps ax -o pid=,args= | grep 'twm/twm' | grep -v 'grep' | head -n1 | grep -o -E '([0-9]{3,5})')
   until [ -z "$pidf" ]; do
    kill -9 $pidf 2> /dev/null
    pidf=$(ps ax -o pid=,args= | grep 'twm/twm' | grep -v 'grep' | head -n1 | grep -o -E '([0-9]{3,5})')
    sleep 1s
   done
  fi
 }
 clan_id
 #/game time
 case $(date +%H:%M) in
 (00:00)
  arena_duel
  messages_info
  func_crono ;;
 (00:30)
  arena_duel
  messages_info
  func_crono ;;
 (01:00)
  arena_duel
  messages_info
  func_crono ;;
 (01:30)
  arena_duel
  messages_info
  func_crono ;;
 (02:00)
  arena_duel
  messages_info
  func_crono ;;
 (02:30)
  arena_duel
  messages_info
  func_crono ;;
 (03:00)
  arena_duel
  messages_info
  func_crono ;;
 (03:30)
  arena_duel
  messages_info
  func_crono ;;
 (04:00)
  arena_duel
  messages_info
  func_crono ;;
 (04:30)
  arena_duel
  coliseum_fight
  messages_info
  func_crono ;;
 (05:00)
  arena_duel
  messages_info
  func_crono ;;
 (05:30)
  arena_duel
  messages_info
  func_crono ;;
 (06:00)
  arena_duel
  messages_info
  func_crono ;;
 (06:30)
  arena_duel
  messages_info
  func_crono ;;
 (07:00)
  arena_duel
  messages_info
  func_crono ;;
 (07:30)
  arena_duel
  messages_info
  func_crono ;;
 (08:00)
  arena_duel
  messages_info
  func_crono ;;
 (08:30)
  arena_duel
  messages_info
  func_crono ;;
 (09:00)
  arena_duel
  messages_info
  func_crono ;;
# /Clan dmg  09:30:00 - 21:30:00
 (09:2[8-9])
  if [ -n $CLD ] ; then
   :
   #_clanmgfight
  else
   sleep 300s
  fi
  arena_duel
  messages_info
  func_crono ;;
# /Valley of the Immortals 10:00:00 - 16:00:00 - 22:00:00
 (09:5[5-9])
  undying_start
  clanDungeon
  messages_info
  func_crono ;;
# /Battle of banners 10:15:00 - 16:15:00
 (10:1[0-4])
  if [ -n $CLD ] ; then
   flagfight_start
  else
   sleep 300s
  fi
  messages_info
  func_crono ;;
# /Clan coliseum 10:30:00 - 15:00:00
 (10:2[5-9])
  if [ -n $CLD ] ; then
   clancoliseum_start
  else
   sleep 300s
  fi
  arena_duel
  messages_info
  func_crono ;;
# /Clan tournament 11:00:00 - 19:00:00
 (10:5[5-9])
  if [ -n $CLD ] ; then
   clanfight_start
  else
   sleep 300s
  fi
  arena_duel
  messages_info
  func_crono ;;
 (11:30)
  arena_duel
  messages_info
  func_crono ;;
 (12:00)
  arena_duel
  messages_info
  func_crono ;;
# /King of the Immortals 12:30:00 - 16:30:00 - 22:30:00
 (12:2[5-9])
  king_start
  arena_duel
  messages_info
  func_crono ;;
 (13:00)
  arena_duel
  messages_info
  func_crono ;;
 (13:30)
  arena_duel
  messages_info
  func_crono ;;
# /Ancient Altars 14:00:00 - 21:00:00
 (13:5[5-9])
  if [ -n $CLD ] ; then
   altars_start
  else
   sleep 300s
  fi
  arena_duel
  messages_info
  func_crono ;;
 (14:30)
  arena_duel
  messages_info
  func_crono ;;
# /Clan coliseum 10:30:00 - 15:00:00
 (14:5[8-9])
  if [ -n $CLD ] ; then
   clancoliseum_start
  else
   sleep 300s
  fi
  arena_duel
  messages_info
  func_crono ;;
 (15:30)
  arena_duel
  messages_info
  func_crono ;;
# /Valley of the Immortals 10:00:00 - 16:00:00 - 22:00:00
 (15:5[5-9])
  undying_start
  arena_duel
  messages_info
  func_crono ;;
# /Battle of banners 10:15:00 - 16:15:00
 (16:1[0-4])
  if [ -n $CLD ] ; then
   flagfight_start
  else
   sleep 300s
  fi
  messages_info
  func_crono ;;
# /King of the Immortals 12:30:00 - 16:30:00 - 22:30:00
 (16:2[5-9])
  king_start
  arena_duel
  messages_info
  func_crono ;;
 (17:00)
  arena_duel
  messages_info
  func_crono ;;
 (17:30)
  arena_duel
  messages_info
  func_crono ;;
 (18:00)
  arena_duel
  messages_info
  func_crono ;;
 (18:30)
  arena_duel
  messages_info
  func_crono ;;
# /Clan tournament 11:00:00 - 19:00:00
 (18:5[5-9])
  if [ -n $CLD ] ; then
   clanfight_start
  else
   sleep 300s
  fi
  arena_duel
  messages_info
  func_crono ;;
 (19:30)
  arena_duel
  messages_info
  func_crono ;;
 (20:00)
  arena_duel
  messages_info
  func_crono ;;
 (20:30)
  arena_duel
  messages_info
  func_crono ;;
# /Ancient Altars 14:00:00 - 21:00:00
 (20:5[5-9])
  if [ -n $CLD ] ; then
   altars_start
  else
   sleep 300s
  fi
  arena_duel
  messages_info
  func_crono ;;
# /Clan dmg  09:30:00 - 21:30:00
 (21:2[5-9])
  #_clanmgfight
  arena_duel
  messages_info
  func_crono ;;
# /Valley of the Immortals 10:00:00 - 16:00:00 - 22:00:00
 (21:5[5-9])
  undying_start
  arena_duel
  messages_info
  func_crono ;;
# /King of the Immortals 12:30:00 - 16:30:00 - 22:30:00
 (22:2[5-9])
  king_start
  arena_duel
  messages_info
  func_crono ;;
 (23:00)
  arena_duel
  messages_info
  func_crono ;;
 (23:30)
  arena_duel
  messages_info
  func_crono ;;
 (23:59)
  arena_duel
  messages_info
  func_crono ;;
 (*)
  func_crono
  if [ "$(cat $HOME/twm/.runmode_file)" = '-cl' ]; then
   arena_duel
#   sleep 150s
   coliseum_start
   messages_info
  fi
  func_sleep
  func_crono ;;
 esac
}
