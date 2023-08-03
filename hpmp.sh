hpmp () {
 #/options: -fix or -now

 #/Go to /train page
# if [ "$@" != '-fix' ] || [ -z "$@" ]; then
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/train" -o user_agent="$(shuf -n1 userAgent.txt)" >$TMP/TRAIN
  )  </dev/null &>/dev/null &
  time_exit 20
 #fi
 echo "passei"
 #/Fixed HP and MP.
 #/Needs to run -fix at least once before
 FIXHP=$(grep -o -E '\(([0-9]+)\)' $TMP/TRAIN | sed 's/[()]//g')
 FIXMP=$(grep -o -E ': [0-9]+' $TMP/TRAIN | sed -n '5s/: //p')
 printf "max hp: $FIXHP max mp $FIXMP"

 #/$STATUS can be obtained from any SRC file
 #/alt='hp'/> <span class='white'>19044</span> | <img src='/images/icon/mana.png' alt='mp'/> 1980</
 #<span class="bl rght nwr"><img src="/images/icon/health.png" alt="hp"> <span class="white">3806</span> | <img src="/images/icon/mana.png" alt="mp"> 1540</span>
 local STATUSH=$(grep -o -E 'hp(.*)[0-9]{1,6}(.*)\' $TMP/SRC |grep -o -E '[0-9]+') #|(.*)mp(.*)[0-9]{1,6}[<][/span]
 local STATUSM=$(grep -o -E '|(.*)mp(.*)[0-9]{1,6}[<](.*)span' $TMP/SRC |grep -o -E '[0-9]+') 
 printf "status {$STATUS}"
 #/Variable HP and MP
 NOWHP=$(echo "$STATUS"|sed -n '1p')
 NOWMP=$(echo "$STATUS"|sed -n '2p')
 printf "Actual Hp {$NOWHP} actual mp {$NOWMP}"
 #/Calculates percentage of HP and MP.
 #/Needs to run -fix at least once before
 HPPER=$(awk -v fixhp="$FIXHP" -v nowhp="$NOWHP" 'BEGIN { printf "%.0f", fixhp * nowhp / 100 }')
 MPPER=$(awk -v fixmp="$FIXMP" -v nowmp="$NOWMP" 'BEGIN { printf "%.0f", fixmp * nowmp / 100 }')
 #/e.g.
 printf "hp $NOWHP - ${HPPER}% [-] mp $NOWMP - ${MPPER}%\n"
sleep 10s
}
