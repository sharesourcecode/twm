#check cave...
#/cave/gather/?r=54426358 #new mine
#/cave/down/?r=54426358 #new search
#/cave/attack/?r=42724370 #attack cave
#/cave/runaway/?r=42724370 #runaway cave

mana= "/images/icon/mana[.]png"
grep -o "${url}${mana}" results.html 
mana= (grep -A 1 "${url}${mana}" results.html | tail -n 1)
printf $mana

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
