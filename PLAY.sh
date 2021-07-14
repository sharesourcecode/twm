#!/bin/bash
PAGE="w3m -o https_proxy=$PROXY -o accept_language=$LANG -debug"
DUMP="w3m -o https_proxy=$PROXY -o accept_language=$LANG -debug -dump"
SOURCE="w3m -o https_proxy=$PROXY -o accept_language=$LANG -o accept_encoding=UTF-8 -debug -dump_source"
# /colors
ww_='\e[01;30m\e[01;07m' # \e[01;30m\e[05;07m
_w_='\e[01;30m\e[08;07m'
rr_='\e[01;31m\e[01;07m'
gg_='\e[01;32m\e[01;07m'
y_='\033[33m\033'
yy_='\e[00;33m\e[01;07m'
bi_='\e[03;34m\e[02;03m'
b__='\e[03;34m\e[02;04m'
pp_='\e[01;35m\e[01;07m'
b_='\033[36m\033'
c_='\033[37m\033'
#cc_='\e[00m'
# /sources
[[ ! -e "$HOME/easyinstall.sh" ]] && {
	echo -e "\n Downloading easyinstall.sh"
	curl https://raw.githubusercontent.com/sharesourcecode/twm/master/easyinstall.sh -O -L &> /dev/null ;
	mv easyinstall.sh $HOME/easyinstall.sh &> /dev/null
	. $HOME/easyinstall.sh ;
}
cd ~/twm
. requeriments.sh ; . loginlogoff.sh
. flagfight.sh ; . clanid.sh ; . crono.sh ; . arena.sh ; . coliseum.sh
. campaign.sh ; . play.sh ; . altars.sh ; . clanfight.sh
. clancoliseum.sh ; . king.sh ; . undying.sh ; . clandungeon.sh
. trade.sh ; . career.sh ; . cave.sh ; . allies.sh ; . svproxy.sh
# /functions
_access () {
	ENTERFIGHT=$(cat SRC | sed 's/href=/\n/g' | grep '/enterFight/' | head -n1 | awk -F\' '{ print $2 }')
	ENTERGAME=$(cat SRC | sed 's/href=/\n/g' | grep '/enterGame/' | head -n1 | awk -F"[']" '{ print $2 }')
	ATK=$(grep -o -P '\W\w{4,12}\W\w{0,4}at\w{0,3}k\W{2}r\W\d{0,10}' SRC | sed -n 1p)
#	ATTACK=$(cat SRC | grep -o -P '\W\w{4,12}\Wat\w{0,3}k\W{2}r\W\d{0,10}')
	ATKRND=$(grep -o -P '\W\w{4,12}\Wat\w{0,3}k\w{3,6}\W{2}r\W\d{0,10}' SRC)
#	ATTACKRANDOM=$(cat SRC | grep -o -P '\W\w{4,12}\Wat\w{0,3}k\w{3,6}\W{2}r\W\d{0,10}')
#	KINGATK=$(cat SRC | sed 's/href=/\n/g' | grep 'king/kingatk/' | head -n1 | awk -F"[']" '{ print $2 }')
	DODGE=$(grep -o -P '\W\w{4,12}\Wd\w{4}\W{2}r\W\d{0,10}' SRC)
	HEAL=$(grep -o -P '\W\w{4,12}\Wh\w{3}\W{2}r\W\d{0,10}' SRC)
	STONE=$(grep -o -P '\W\w{4,12}\Ws\w{4}\W{2}r\W\d{0,10}' SRC)
	GRASS=$(grep -o -P '\W\w{4,12}\Wg\w{4}\W{2}r\W\d{0,10}' SRC)
	DT=$(grep -o -P 'dodge(.*)dgreen medium\D{2}\d{2}\D\d{2}' SRC | sed "s,^dodge\(.*\)[>],,g")
	HT=$(grep -o -P '\Wheal\W(.*)\d{1,2}:\d{2}(.*)\Wstone\W' SRC | grep -o -P '\d{2}:\d{2}')
	BEXIT=$(grep -o 'user.png' SRC)
	OUTGATE=$(grep -o 'out_gate' SRC)
	LEAVEFIGHT=$(cat SRC | sed 's/href=/\n/g' | grep '/leaveFight/' | head -n1 | awk -F"[']" '{ print $2 }')
	WDRED=$(cat SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | awk -F"[']" '{ print $4 }') #white/dred
	HLHP=$(echo $(($FULL * $HPER / 100)))
	_show
}
_unset () {
	unset HP1 HP2 YOU USER CLAN ENTERFIGHT ENTERGAME ATK ATKRND DODGE HEAL BEXIT OUTGATE LEAVEFIGHT WDRED HLHP
}
rpt=0
#sleep 5
_requeriments
ts=20
_proxy
#_coliseum
_loginlogoff
[[ -n $ALLIES ]] && _alliesConf
_msgs () {
		cd $TMP
		echo -e "# Latest posts:" >msgs.txt
		$PAGE $URL -o user_agent="$(shuf -n1 .ua)" | head -n3 | sed "/\[/d;/\|/d" >> msgs.txt &
		sleep 2
		$PAGE $URL/mail -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 >> msgs.txt &
		sleep 3
		$PAGE $URL -o user_agent="$(shuf -n1 .ua)" | grep -o -P '(lvl\s\d+|g\s\d\S+|s\s\d\S+$)' | sed ':a;N;s/\n//g;ta' | sed 's/lvl/\n\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ lvl/g;s/g/\ g/g;s/s/\ s/g' >> msgs.txt &
		sleep 3
		killall -q -9 w3m
}
while true ; do
	rpt=$[$rpt+1]
	sleep 1
	if [[ $rpt -ne 1 ]] ; then
		ts=20
	fi
#	_coliseum
#	_cave
	_play
done
unset rpt ts
kill -9 $$
exit
