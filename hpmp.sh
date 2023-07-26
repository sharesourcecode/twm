hpmp () {
 #Go to /train page
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "$URL/train" -o user_agent="$(shuf -n1 userAgent.txt)" >$TMP/SRC
 ) &
 time_exit 20

 #Fixed HP and MP
 FIXHP=$(grep -o -E '\(([0-9]+)\)' $TMP/SRC|sed 's/[()]//g')
 FIXMP=$(grep -o -E '[[:alpha:]]+: [0-9]{1,5}' $TMP/SRC|grep -m5 -o -E '[0-9]{1,5}'|sed -n '5p')

 #alt='hp'/> <span class='white'>19044</span> | <img src='/images/icon/mana.png' alt='mp'/> 1980</
 #Search from an existing source
 STATUS=$(grep -o -E 'hp(.*)[0-9]{1,6}(.*)\|(.*)mp(.*)[0-9]{1,6}[<][/]span' $TMP/SRC|grep -o -E '[0-9]+)

 #Variable HP and MP
 NOWHP=$(echo "$STATUS"|sed -n '1p')
 NOWMP=$(echo "$STATUS"|sed -n '2p')

 #Calculates percentage of HP and MP
 HPPER=$(awk -v fixhp="$FIXHP" -v nowhp="$NOWHP" 'BEGIN { printf "%.0f", fixhp * nowhp / 100 }')
 MPPER=$(awk -v fixmp="$FIXMP" -v nowmp="$NOWMP" 'BEGIN { printf "%.0f", fixmp * nowmp / 100 }')

 printf "hp $NOWHP - ${HPPER}% | mp $NOWMP - ${MPPER}%\n"
}
