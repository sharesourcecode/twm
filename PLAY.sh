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
_show () {
	HP1=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | awk -F\< '{ print $2 }' | awk -F\> '{ print $2 }' | tr -cd '[[:digit:]]')
	HP2=$(echo $SRC | sed "s/alt/\\n/g" | grep "hp" | head -n3 | tail -n1 | awk -F\< '{ print $1 }' | awk -F\; '{ print $2 }' | tr -cd "[[:digit:]]")
	if [[ -n $OUTGATE ]] ; then
		[[ -n $HP1 && -n $HP2 ]] && echo -e "$URL\n$ACC: $HP1 - $HP2 :$USER\n"
		[[ -z $HP1 && -n $HP2 ]] && echo -e "$URL\n$ACC: 💀 - $HP2 :$USER\n"		else
		[[ -n $HP1 && -n $HP2 ]] && echo -e "$URL\nYou: $HP1 - $HP2 :Opponent\n"
		[[ -z $HP1 && -n $HP2 ]] && echo -e "$URL\nYou: 💀 - $HP2 :Opponent\n"
	fi
}
_access () {
	ACC=$(echo $SRC | grep -E -o "> [A-Z][a-z]{0,14}[\ ]{0,1}[A-Z]{0,1}[a-z]{0,12}" | awk -F"> " '{ print $2 }' | head -n1)
	USER=$(echo $SRC | grep -E -o "> [A-Z][a-z]{0,14}[\ ]{0,1}[A-Z]{0,1}[a-z]{0,12}" | awk -F">" '{ print $2 }' | head -n2 | tail -n1 | sed "s,\ ,_,g")
	ALLY=$(grep -E -o "[\n]{0,}[*]{0,13}$USER" $HOME/.tmp/allies.txt | sed "s,\ ,_,g")
	ENTERFIGHT=$(echo $SRC | sed 's/href=/\n/g' | grep '/enterFight/' | head -n1 | awk -F\' '{ print $2 }')
	ENTERGAME=$(echo $SRC | sed 's/href=/\n/g' | grep '/enterGame/' | head -n1 | awk -F\' '{ print $2 }')
	ATK=$(echo $SRC | sed 's/href=/\n/g' | grep '/atk/' | head -n1 | awk -F\' '{ print $2 }')
	ATTACK=$(echo $SRC | sed 's/href=/\n/g' | grep '/attack/' | head -n1 | awk -F\' '{ print $2 }')
	ATKRND=$(echo $SRC | sed 's/href=/\n/g' | grep '/atkrnd/' | head -n1 | awk -F\' '{ print $2 }')
	ATTACKRANDOM=$(echo $SRC | sed 's/href=/\n/g' | grep '/attackrandom/' | head -n1 | awk -F\' '{ print $2 }')
	KINGATK=$(echo $SRC | sed 's/href=/\n/g' | grep 'king/kingatk/' | head -n1 | awk -F\' '{ print $2 }')
	DODGE=$(echo $SRC | sed 's/href=/\n/g' | grep '/dodge/' | head -n1 | awk -F\' '{ print $2 }')
	HEAL=$(echo $SRC | sed 's/href=/\n/g' | grep '/heal/' | head -n1 | awk -F\' '{ print $2 }')
	STONE=$(echo $SRC | sed 's/href=/\n/g' | grep '/stone/' | head -n1 | awk -F\' '{ print $2 }')
	GRASS=$(echo $SRC | sed 's/href=/\n/g' | grep '/grass/' | head -n1 | awk -F\' '{ print $2 }')
	BEXIT=$(echo $SRC | grep -o 'user.png')
	OUTGATE=$(echo $SRC | grep -o 'out_gate')
	LEAVEFIGHT=$(echo $SRC | sed 's/href=/\n/g' | grep '/leaveFight/' | head -n1 | awk -F\' '{ print $2 }')
	WDRED=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | awk -F\' '{ print $4 }') #white/dred
	HLHP=$(expr $FULL \* $HPER \/ 100)
	_show
}
_unset () {
	unset HP1 HP2 USER ALLY ENTERFIGHT ENTERGAME ATK ATTACK ATKRND ATTACKRANDOM KINGATK DODGE HEAL STONE GRASS BEXIT OUTGATE LEAVEFIGHT WDRED HLHP
}
rpt=0
_requeriments
ts=20
_proxy
_loginlogoff
[[ -n $ALLIES ]] && _alliesConf
while true ; do
	rpt=$[$rpt+1]
	sleep 1
	if [[ $rpt -ne 1 ]] ; then
		ts=20
	fi
	_play
done
kill -9 $$
unset rpt ts
exit
