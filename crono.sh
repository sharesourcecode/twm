# /time
func_crono () {
 HOUR=`date +%H`
 if [ $HOUR = 00 ] ; then HOUR=0 ; fi
 if [ $HOUR = 01 ] ; then HOUR=1 ; fi
 if [ $HOUR = 02 ] ; then HOUR=2 ; fi
 if [ $HOUR = 03 ] ; then HOUR=3 ; fi
 if [ $HOUR = 04 ] ; then HOUR=4 ; fi
 if [ $HOUR = 05 ] ; then HOUR=5 ; fi
 if [ $HOUR = 06 ] ; then HOUR=6 ; fi
 if [ $HOUR = 07 ] ; then HOUR=7 ; fi
 if [ $HOUR = 08 ] ; then HOUR=8 ; fi
 if [ $HOUR = 09 ] ; then HOUR=9 ; fi
 MIN=`date +%M`
 if [ $MIN = 00 ] ; then MIN=0 ; fi
 if [ $MIN = 01 ] ; then MIN=1 ; fi
 if [ $MIN = 02 ] ; then MIN=2 ; fi
 if [ $MIN = 03 ] ; then MIN=3 ; fi
 if [ $MIN = 04 ] ; then MIN=4 ; fi
 if [ $MIN = 05 ] ; then MIN=5 ; fi
 if [ $MIN = 06 ] ; then MIN=6 ; fi
 if [ $MIN = 07 ] ; then MIN=7 ; fi
 if [ $MIN = 08 ] ; then MIN=8 ; fi
 if [ $MIN = 09 ] ; then MIN=9 ; fi
 printf "\n $URL ⏰ $(date +%H):$(date +%M)\n"
}
func_cat () {
 func_crono
 if [ $HOUR -lt 6 ] || [ $HOUR -ge 18 ] ; then
  printf "${GOLD_BLACK}"
 else
  printf "${CYAN_BLACK}"
 fi
 cat $TMP/msg_file
 printf "${WHITE_BLACK}"
 #local BREAK=$(( $(date +%s) + 10 ))
  list () {
   printf "\n"
   grep -o -E '[[:alpha:]]+?[_]?[[:alpha:]]+?[ ]?\() \{' ~/twm/*.sh|awk -F\: '{ print $2 }'|awk -F\( '{ print $1 }'
   read -t 5
  }
  while  true ; do
    printf "${WHITEb_BLACK}Enter a command or type 'list':${COLOR_RESET} \n"
    read -t $i cmd
    if [ "$cmd" = " " ]; then
        break
    fi
    $cmd
    sleep 0.5s
    break
  done
}
func_sleep () {
 case $(date +%d) in
 (01)
  case $(date +%H) in
  (0[012345678])
   arena_duel
   coliseum_start
   reset
   clear
   i=1m
   func_cat
   printf "\n No battles now, waiting 1m\n"
   #sleep 55s 
   ;;
  esac ;;
 esac
 case $(date +%M) in
 ([25][89])
  reset
  clear
  i=15s
  func_cat
  printf "\n No battles now, waiting 15s\n"
  #sleep 10s 
  ;;
 (*)
  #check_cave
  #check_missions
  reset
  clear
  i=30s
  func_cat
  printf "\n No battles now, waiting 30s\n"
  #sleep 25s 
  ;;
#  break &>/dev/null
 esac
}
standard_crono() {
  arena_duel
  career_func
  cave_routine
  func_trade
  campaign_func
  clanDungeon
  check_missions
  messages_info
  func_crono
  func_sleep
}
