# /time
func_crono () {
 HOUR=`date +%H`
 if [ $HOUR = 00 ]; then HOUR=0; fi
 if [ $HOUR = 01 ]; then HOUR=1; fi
 if [ $HOUR = 02 ]; then HOUR=2; fi
 if [ $HOUR = 03 ]; then HOUR=3; fi
 if [ $HOUR = 04 ]; then HOUR=4; fi
 if [ $HOUR = 05 ]; then HOUR=5; fi
 if [ $HOUR = 06 ]; then HOUR=6; fi
 if [ $HOUR = 07 ]; then HOUR=7; fi
 if [ $HOUR = 08 ]; then HOUR=8; fi
 if [ $HOUR = 09 ]; then HOUR=9; fi
 MIN=`date +%M`
 if [ $MIN = 00 ]; then MIN=0; fi
 if [ $MIN = 01 ]; then MIN=1; fi
 if [ $MIN = 02 ]; then MIN=2; fi
 if [ $MIN = 03 ]; then MIN=3; fi
 if [ $MIN = 04 ]; then MIN=4; fi
 if [ $MIN = 05 ]; then MIN=5; fi
 if [ $MIN = 06 ]; then MIN=6; fi
 if [ $MIN = 07 ]; then MIN=7; fi
 if [ $MIN = 08 ]; then MIN=8; fi
 if [ $MIN = 09 ]; then MIN=9; fi
 echo -e "\n $URL ⏰ $(date +%H):$(date +%M)"
}
func_cat () {
 func_crono
 if [ $HOUR -lt 6 ] || [ $HOUR -ge 18 ]; then
  echo -ne "$y_"
 else
  echo -ne "$b_"
 fi
 cat $TMP/msg_file
 echo -ne "$c_"
}
func_sleep () {
 if [ $(date +%d) = 01 ] && [ $(date +%H) = 0[012345678] ] ; then
  arena_duel
  coliseum_start
  reset
  clear
  func_cat
  echo ' No battles now, waiting 1m'
  sleep 1m
 elif [ $(date +%M) = [25][89] ]; then
  reset
  clear
  func_cat
  echo ' No battles now, waiting 15s'
  sleep 15
 else
  reset
  clear
  func_cat
  echo ' No battles now, waiting 30s'
  sleep 30s
  break &> /dev/null
 fi
}
