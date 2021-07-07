#!/bin/bash
PAGE="w3m -o https_proxy=$PROXY -o accept_language=$LANG -debug"
DUMP="w3m -o https_proxy=$PROXY -o accept_language=$LANG -debug -dump"
SOURCE="w3m -o https_proxy=$PROXY -o accept_language=$LANG -o accept_encoding=UTF-8 -debug -dump_source"
# /sources
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
	ATK=$(cat SRC | sed 's/href=/\n/g' | grep '/atk/' | head -n1 | awk -F"[']" '{ print $2 }')
	ATTACK=$(cat SRC | sed 's/href=/\n/g' | grep '/attack/' | head -n1 | awk -F"[']" '{ print $2 }')
	ATKRND=$(cat SRC | sed 's/href=/\n/g' | grep '/atkrnd/' | head -n1 | awk -F"[']" '{ print $2 }')
	ATTACKRANDOM=$(cat SRC | sed 's/href=/\n/g' | grep '/attackrandom/' | head -n1 | awk -F"[']" '{ print $2 }')
	KINGATK=$(cat SRC | sed 's/href=/\n/g' | grep 'king/kingatk/' | head -n1 | awk -F"[']" '{ print $2 }')
	DODGE=$(cat SRC | sed 's/href=/\n/g' | grep '/dodge/' | head -n1 | awk -F"[']" '{ print $2 }')
	HEAL=$(cat SRC | sed 's/href=/\n/g' | grep '/heal/' | head -n1 | awk -F"[']" '{ print $2 }')
	STONE=$(cat SRC | sed 's/href=/\n/g' | grep '/stone/' | head -n1 | awk -F"[']" '{ print $2 }')
	GRASS=$(cat SRC | sed 's/href=/\n/g' | grep '/grass/' | head -n1 | awk -F"[']" '{ print $2 }')
	BEXIT=$(cat SRC | grep -o 'user.png')
	OUTGATE=$(cat SRC | grep -o 'out_gate')
	LEAVEFIGHT=$(cat SRC | sed 's/href=/\n/g' | grep '/leaveFight/' | head -n1 | awk -F"[']" '{ print $2 }')
	WDRED=$(cat SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | awk -F"[']" '{ print $4 }') #white/dred
	HLHP=$(expr "$FULL" \* "$HPER" \/ 100)
	_show
}
_unset () {
	unset HP1 HP2 YOU USER CLAN ENTERFIGHT ENTERGAME ATK ATTACK ATKRND ATTACKRANDOM KINGATK DODGE HEAL STONE GRASS BEXIT OUTGATE LEAVEFIGHT WDRED HLHP
}
rpt=0
_requeriments
ts=20
_proxy
_loginlogoff
[[ -n $ALLIES ]] && _alliesConf
_msgs () {
		cd $TMP
		echo -e "# Latest posts:" >msgs.txt
		$PAGE $URL -o user_agent="$(shuf -n1 .ua)" | head -n3 | sed "/\[/d;/\|/d" >> msgs.txt &
		sleep 2
		$PAGE $URL/mail -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 >> msgs.txt &
		sleep 2
		$PAGE $URL -o user_agent="$(shuf -n1 .ua)" | grep -oP '(lvl\s\d+|g\s\d\S+|s\s\d\S+$)' | sed ':a;N;s/\n//g;ta' | sed 's/lvl/\n\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ lvl/g;s/g/\ g/g;s/s/\ s/g' >> msgs.txt &
		sleep 3
		killall -q -9 w3m
	}
_msgs
while true ; do
	rpt=$[$rpt+1]
	sleep 1
	if [[ $rpt -ne 1 ]] ; then
		ts=20
	fi
	_play
done
unset rpt ts
kill -9 $$
exit
