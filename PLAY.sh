#!/bin/bash
PAGE="w3m -o http_proxy=$PROXY -debug"
DUMP="w3m -o http_proxy=$PROXY -debug -dump"
SOURCE="w3m -o http_proxy=$PROXY -debug -dump_source"
# /sources
cd ~/twm
. requeriments.sh ; . loginlogoff.sh
. flagfight.sh ; . clanid.sh ; . crono.sh ; . arena.sh ; . coliseum.sh
. campaign.sh ; . play.sh ; . altars.sh ; . clanfight.sh
. clancoliseum.sh ; . king.sh ; . undying.sh ; . clandungeon.sh
. trade.sh ; . career.sh ; . cave.sh ; . allies.sh ; . svproxy.sh
# /functions
_access () {
	ENTERFIGHT=$(echo $SRC | sed 's/href=/\n/g' | grep '/enterFight/' | head -n1 | awk -F\' '{ print $2 }')
	ENTERGAME=$(echo $SRC | sed 's/href=/\n/g' | grep '/enterGame/' | head -n1 | awk -F"[']" '{ print $2 }')
	ATK=$(echo $SRC | sed 's/href=/\n/g' | grep '/atk/' | head -n1 | awk -F"[']" '{ print $2 }')
	ATTACK=$(echo $SRC | sed 's/href=/\n/g' | grep '/attack/' | head -n1 | awk -F"[']" '{ print $2 }')
	ATKRND=$(echo $SRC | sed 's/href=/\n/g' | grep '/atkrnd/' | head -n1 | awk -F"[']" '{ print $2 }')
	ATTACKRANDOM=$(echo $SRC | sed 's/href=/\n/g' | grep '/attackrandom/' | head -n1 | awk -F"[']" '{ print $2 }')
	KINGATK=$(echo $SRC | sed 's/href=/\n/g' | grep 'king/kingatk/' | head -n1 | awk -F"[']" '{ print $2 }')
	DODGE=$(echo $SRC | sed 's/href=/\n/g' | grep '/dodge/' | head -n1 | awk -F"[']" '{ print $2 }')
	HEAL=$(echo $SRC | sed 's/href=/\n/g' | grep '/heal/' | head -n1 | awk -F"[']" '{ print $2 }')
	STONE=$(echo $SRC | sed 's/href=/\n/g' | grep '/stone/' | head -n1 | awk -F"[']" '{ print $2 }')
	GRASS=$(echo $SRC | sed 's/href=/\n/g' | grep '/grass/' | head -n1 | awk -F"[']" '{ print $2 }')
	BEXIT=$(echo $SRC | grep -o 'user.png')
	OUTGATE=$(echo $SRC | grep -o 'out_gate')
	LEAVEFIGHT=$(echo $SRC | sed 's/href=/\n/g' | grep '/leaveFight/' | head -n1 | awk -F"[']" '{ print $2 }')
	WDRED=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | awk -F"[']" '{ print $4 }') #white/dred
	HLHP=$(expr $FULL \* $HPER \/ 100)
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
		$PAGE $URL -o user_agent="$(shuf -n1 .ua)" | head -n3 | sed "/\[/d;/\|/d" >> msgs.txt
		$PAGE $URL/mail -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 >> msgs.txt
		$PAGE $URL -o user_agent="$(shuf -n1 .ua)" | grep -oP '(lvl\s\d+|g\s\d\S+|s\s\d\S+$)' | sed ':a;N;s/\n//g;ta' | sed 's/lvl/\n\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ lvl/g;s/g/\ g/g;s/s/\ s/g' >> msgs.txt
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
