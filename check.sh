#check cave...
#/cave/gather/?r=54426358 #new mine
#/cave/down/?r=54426358 #new search
#/cave/attack/?r=42724370 #attack cave
#/cave/runaway/?r=42724370 #runaway cave

(
  w3m -cookie -o -A 1 http_proxy=$PROXY -o accept_encoding=UTF-8 -dump "${url}${mana}{1,4}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tee $TMP/info_file|sed -n '/[|]\ mp/,/\[arrow\]/p'|sed '1,1d;$d;6q' >> $TMP/msg_file
 ) </dev/null &>/dev/null &
 time_exit 17
printf " ##### Titan #####\n" > $TMP/msg_file
    #mana= "/images/icon/mana[.]png"
    (
        w3m -cookie -o -A 1 http_proxy=$PROXY -o accept_encoding=UTF-8 -dump "${url}/images/icon/mana[.]png{1,4}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tee $TMP/info_file|sed -n '/[|]\ mp/,/\[arrow\]/p'|sed '1,1d;$d;6q' >> $TMP/msg_file
    ) </dev/null &>/dev/null &
    time_exit 17

  #health= "/images/icon/health[.]png"
    (
        w3m -cookie -o -A 1 http_proxy=$PROXY -o accept_encoding=UTF-8 -dump "${url}/images/icon/health[.]png{1,4}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)"|tee $TMP/info_file|sed -n '/[|]\ mp/,/\[arrow\]/p'|sed '1,1d;$d;6q' >> $TMP/msg_file
    ) </dev/null &>/dev/null &
    time_exit 17

check_cave () {
(
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/cave/" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
) </dev/null &>/dev/null &
 time_exit 20
 if grep -o -E '/cave/[a-z]/[?]r[=][0-9]+' $TMP/SRC ; then
CLICK=$(grep -o -E '/cave/[a-z]/[?]r[=][0-9]+' $TMP/SRC)
printf $CLICK
(
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${CLICK}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
) </dev/null &>/dev/null &
time_exit 20
printf "${BLACK_YELLOW}Cave Done (✔)${COLOR_RESET}\n"
fi
}
