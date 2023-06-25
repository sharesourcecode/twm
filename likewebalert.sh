#!/bin/bash
termux-wake-lock
mkdir -p ~/.tmp/tt
cd $HOME/tt
. timeexit.sh
( xdg-open $(echo "aHR0cHM6Ly93d3cud2hhdHNteXVhLmluZm8=" | base64 -d) ) &
_timeexit 20
clear
read -p "Copie e cole seu User Agent aqui e tecle ENTER/Confirma: " -t 120 -e -n 300 UA
[[ -z $UA ]] && UA="Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko" && echo $UA
sleep 1s

#UA
# https
URL=$(echo 'aHR0cHM6Ly90aXdhci50b3AK' | base64 -d)
# http
#URL=$(echo 'aHR0cDovL3Rpd2FyLnRvcAo=' | base64 -d)

mkdir -p $HOME/.tmp/tt
# Gravação da tela de login
echo "U0VUX0NPT0tJRVM6VFJVRQpBQ0NFUFRfQUxMX0NPT0tJRVM6VFJVRQpQRVJTSVNURU5UX0NPT0tJRVM6VFJVRQo=" | base64 -d >~/.tmp/tt/cfg
echo "COOKIE_FILE:~/.tmp/tt/.cookie" >>~/.tmp/tt/cfg
( lynx -dump -cfg=~/.tmp/tt/cfg -accept_all_cookies "$URL/?exit" -useragent="$UA" ) &
_timeexit 20
( lynx -dump -cfg=~/.tmp/tt/cfg -accept_all_cookies "$URL/?exit" -useragent="$UA" ) &
_timeexit 20
clear
echo "[ENTER] avança..."
read -p "Execute [apenas o login] e termine digitando Q: " -t 20 -e -n 1 LOGIN
lynx -accept_all_cookies -cmd_log=~/.tmp/tt/login "$URL/?sign_in" -useragent="$UA"
# Salva os cookies
lynx -cfg=~/.tmp/tt/cfg -accept_all_cookies -cmd_script=~/.tmp/tt/login "$URL/?sign_in" -useragent="$UA"
clear
echo "[ENTER] avança..."
read -p "Agora execute uma tarefa e termine digitando Q _ longe das caixas de texto: " -t 20 -e -n 1 LOGIN
lynx -cfg=~/.tmp/tt/cfg -accept_all_cookies -cmd_log=~/.tmp/tt/task "$URL/chat/clan" -useragent="$UA"
clear
read -p "Digite um intervalo de repetição. Ex 30s, 40m, 1h:" -t 20 -e -n 4 INTERVALO || INTERVALO="6s"
reset
while true; do
	clear
	echo "Repetirá a tarefa em $INTERVALO. Para cancelar Ctrl c"
	echo "Seu UA: $UA"
	sleep $INTERVALO
	( lynx -cfg=~/.tmp/tt/cfg -accept_all_cookies -cmd_script=~/.tmp/tt/task "$URL/chat/clan" -useragent="$UA" ) &
	_timeexit 20
done
