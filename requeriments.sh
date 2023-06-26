requer_func () {
 #/servers
 clear
 options_one () {
  clear
  echo -e " 1)"$ww_" 🇬🇧 English, Global: Titan's War online \e[00m\n 2)"$ww_" 🇷🇺 Русский: Битва Титанов онлайн \e[00m\n 3)"$ww_" 🇵🇱 Polski: Wojna Tytanów online \e[00m\n 4)"$ww_" 🇩🇪 Deutsch: Krieg der Titanen online \e[00m\n 5)"$ww_" 🇪🇸 Español: Guerra de Titanes online \e[00m\n 6)"$ww_" 🇧🇷 Brazil, 🇵🇹 Português: Furia de Titãs online \e[00m\n 7)"$ww_" 🇮🇹 Italiano: Guerra di Titani online \e[00m\n 8)"$ww_" 🇫🇷 Français: Combat des Titans online \e[00m\n 9)"$ww_" 🇷🇴 Română: Războiul Titanilor online \e[00m\n10)"$ww_" 🇨🇳 中文, Chinese: 泰坦之战 \e[00m\n11)"$ww_" 🇮🇩 Indonesian: Titan's War Indonesia \e[00m\n C)"$yy_" ❌ Cancel \e[00m"
 }
 options_two () {
  clear
  echo -e " "$rr_"1\e[00m)"$ww_" 🇬🇧 English, Global: Titan's War online "$gg_"[ENTER]\e[00m\n 2)"$_w_" 🇷🇺 Русский: Битва Титанов онлайн \e[00m\n 3)"$_w_" 🇵🇱 Polski: Wojna Tytanów online \e[00m\n 4)"$_w_" 🇩🇪 Deutsch: Krieg der Titanen online \e[00m\n 5)"$_w_" 🇪🇸 Español: Guerra de Titanes online \e[00m\n 6)"$_w_" 🇧🇷 Brazil, 🇵🇹 Português: Furia de Titãs online \e[00m\n 7)"$_w_" 🇮🇹 Italiano: Guerra di Titani online \e[00m\n 8)"$_w_" 🇫🇷 Français: Combat des Titans online \e[00m\n 9)"$_w_" 🇷🇴 Română: Războiul Titanilor online \e[00m\n"$rr_"1\e[00m"$gg_"0\e[00m)"$ww_" 🇨🇳 中文, Chinese: 泰坦之战 \e[00m\n"$rr_"1\e[00m"$gg_"1\e[00m)"$ww_" 🇮🇩 Indonesian: Titan's War Indonesia \e[00m\n C)"$yy_" ❌ Cancel \e[00m"
 }
 invalid_one () {
  options_one
  echo -e "Select number Server[1 to 11]: \e[01;31m\e[01;07m$UR◄ invalid option\e[00m"
  sleep 0.2s
  menu_one
 }
 invalid_two () {
  clear
  options_two
  echo -e "Select number Server[1 to 11]: \e[01;31m\e[01;07m1$UR◄ invalid option\e[00m"
  sleep 0.2s
  menu_two
 }
 menu_two () {
  options_two
  read -p "Select number Server[1 to 11]: 1" -t 300 -r -s -n 1 UR
  echo $UR
  if [ "$UR" = $'\0' ] ; then
   echo "s_en" >$HOME/twm/.ur_file
  elif [ $UR = 0 ] ; then
#   LANG=zh-CN.UTF-8
   echo "s_cn" >$HOME/twm/.ur_file
  elif [ $UR = 1 ] ; then
   echo "s_id" >$HOME/twm/.ur_file
  elif [ "$UR" = $'\177' ] ; then
   menu_one
  elif [ $UR = c ] || [ $UR = C ] ; then
   pidf=$(ps ax -o pid=,args= | grep 'twm/play.sh' | grep -v 'grep' | head -n1 | grep -o -E '([0-9]{3,5})')
   until [ -z $pidf ] ; do
    kill -9 $pidf 2> /dev/null
    pidf=$(ps ax -o pid=,args= | grep 'twm/play.sh' | grep -v 'grep' | head -n1 | grep -o -E '([0-9]{3,5})')
    sleep 1s
   done
   kill -9 $$ 2> /dev/null
  else
   invalid_two
#   echo "$UR" >$HOME/twm/.ur_file
  fi
 }
 menu_one () {
  options_one
  read -p "Select number Server[1 to 11]: " -t 300 -r -s -n 1 UR
  if [ $UR = 1 ] ; then
   menu_two
  elif [ $UR = 2 ] ; then
#   LANG=ru.UTF-8
   echo "2" >$HOME/twm/.ur_file
  elif [ $UR = 3 ] ; then
   echo "3" >$HOME/twm/.ur_file
  elif [ $UR = 4 ] ; then
   echo "4" >$HOME/twm/.ur_file
  elif [ $UR = 5 ] ; then
   echo "5" >$HOME/twm/.ur_file
  elif [ $UR = 6 ] ; then
   echo "6" >$HOME/twm/.ur_file
  elif [ $UR = 7 ] ; then
   echo "7" >$HOME/twm/.ur_file
  elif [ $UR = 8 ] ; then
   echo "8" >$HOME/twm/.ur_file
  elif [ $UR = 9 ] ; then
   echo "9" >$HOME/twm/.ur_file
  elif [ "$UR" = $'\177' ] ; then
   menu_one
  elif [ $UR = c ] || [ $UR = C ] ; then
   pidf=$(ps ax -o pid=,args= | grep 'twm/play.sh' | grep -v 'grep' | head -n1 | grep -o -E '([0-9]{3,5})')
   until [ -z $pidf ] ; do
    kill -9 $pidf 2> /dev/null
    pidf=$(ps ax -o pid=,args= | grep 'twm/play.sh' | grep -v 'grep' | head -n1 | grep -o -E '([0-9]{3,5})')
    sleep 1s
   done
   kill -9 $$ 2> /dev/null
  else
   invalid_one
#   echo "$UR" >$HOME/twm/.ur_file
  fi
 }
 if [ -f $HOME/twm/.ur_file ] && [ -s $HOME/twm/.ur_file ] ; then
  UR="$(cat $HOME/twm/.ur_file)"
 else
  menu_one
 fi
 UR="$(cat $HOME/twm/.ur_file)"
 case $UR in
 (1|s_en)
#  LANG=ru.UTF-8
  URL=$(echo "dGl3YXIubmV0" | base64 -d)
  TMP="$HOME/twm/.1"
  export TZ="Europe/London" ; LANG="en.UTF-8"
  ALLIES="_WORK" ;;
 (2|ru)
  URL=$(echo "dGl3YXIucnU=" | base64 -d)
  echo "2" >$HOME/twm/.ur_file
  TMP="$HOME/twm/.2"
  export TZ="Europe/Moscow" ; ALLIES="_WORK" ;;
 (3|pl)
  URL=$(echo "dGl3YXIucGw=" | base64 -d)
  echo "3" >$HOME/twm/.ur_file
  TMP="$HOME/twm/.3"
  export TZ="Europe/Warsaw" ; LANG="pl.UTF-8"
  ALLIES="_WORK" ;;
 (4)
  URL=$(echo "dGl0YW5lbi5tb2Jp" | base64 -d)
  echo "4" >$HOME/twm/.ur_file
  TMP="$HOME/twm/.4"
  export TZ="Europe/Berlin" ; LANG="de.UTF-8"
  ALLIES="_WORK" ;;
 (5)
  URL=$(echo "Z3VlcnJhZGV0aXRhbmVzLm5ldA==" | base64 -d)
  echo "5" >$HOME/twm/.ur_file
  TMP="$HOME/twm/.5"
  export TZ="America/Cancun" ; LANG="es-MX.UTF-8"
  ALLIES="_WORK" ;;
 (6|fu)
  URL=$(echo "ZnVyaWFkZXRpdGFzLm5ldA==" | base64 -d)
  echo "6" >$HOME/twm/.ur_file
  TMP="$HOME/twm/.6"
  export TZ="America/Bahia" ; LANG="pt-BR.UTF-8"
  ALLIES="_WORK" ;;
 (7)
  URL=$(echo "Z3VlcnJhZGl0aXRhbmkubmV0" | base64 -d)
  echo "7" >$HOME/twm/.ur_file
  TMP="$HOME/twm/.7"
  export TZ="Europe/Rome" ; LANG="it.UTF-8"
  ALLIES="_WORK" ;;
 (8|fr)
  URL=$(echo "dGl3YXIuZnI=" | base64 -d)
  echo "8" >$HOME/twm/.ur_file
  TMP="$HOME/twm/.8"
  export TZ="Europe/Paris" ; LANG="fr-FR.UTF-8"
  ALLIES="_WORK" ;;
 (9|ro)
  URL=$(echo "dGl3YXIucm8=" | base64 -d)
  echo "9" >$HOME/twm/.ur_file
  TMP="$HOME/twm/.9"
  export TZ="Europe/Bucharest" ; LANG="ro.UTF-8"
  ALLIES="_WORK" ;;
 (10|s_cn)
  URL=$(echo "Y24udGl3YXIubmV0" | base64 -d)
  TMP="$HOME/twm/.10"
  export TZ="Asia/Shanghai" ; ALLIES="_WORK" ;;
 (11|s_id)
  URL=$(echo "dGl3YXItaWQubmV0" | base64 -d)
  TMP="$HOME/twm/.11"
  export TZ="Asia/Jakarta" ; LANG="id.UTF-8"
  ALLIES="_WORK" ;;
 (*)
  clear
  if [ -n $UR ] ; then
   echo -e "\n Invalid option: $(echo $UR)"
   kill -9 $$
  else
   echo -e "\n Time exceeded!"
  fi ;;
 esac
 clear
 if [ -z $URL ] ; then
  exit
 fi
 #/tmp dir
 mkdir -p $TMP
 #/termux on android
 cd $TMP
 reset ; clear
 #/user agents to $TMP/userAgent.txt
 user_agent () {
  cd $TMP
  clear
  echo -e ""$ww_" Simulate your real or random device. \e[00m\n1)"$ww_" Manual \e[00m\n2)"$ww_" Automatic \e[00m"
  if [ -f $HOME/twm/fileAgent.txt ] && [ -s $HOME/twm/fileAgent.txt ] ; then
   UA=$(cat $HOME/twm/fileAgent.txt)
  else
   read -p "Set up User-Agent[1 to 2]: " -t 300 -e -n 1 UA
  fi
  TWMKEY=$(curl https://codeberg.org/ueliton/auth/raw/branch/main/auth -s -L | base64 -d)
  SERVER='https://gitea.com/api/v1/repos/Ueliton/twm/raw/master/'
  case $UA in
  (0)
   clear ; echo "0" >$HOME/twm/fileAgent.txt
   if [ ! -e $TMP/userAgent.txt ] || [ -z $UA ] ; then
    curl -H "Authorization: token $TWMKEY" ${SERVER}userAgent.txt -s -L >$TMP/userAgent.txt
   fi ;;
  (1)
   clear ; echo "0" >$HOME/twm/fileAgent.txt
   xdg-open $(echo "aHR0cHM6Ly93d3cud2hhdHNteXVhLmluZm8=" | base64 -d) &>/dev/null
   read -p "Copy and paste your User Agent here and tip ENTER: " -t 900 -e -n 300 UA
   echo "$UA" >$TMP/userAgent.txt
   if [ ! -e $TMP/userAgent.txt ] || [ -z $UA ] ; then
    curl -H "Authorization: token $TWMKEY" ${SERVER}userAgent.txt -s -L >$TMP/userAgent.txt
   fi ;;
  (2)
   curl -H "Authorization: token $TWMKEY" ${SERVER}userAgent.txt -s -L >$TMP/userAgent.txt
   echo "0" >$HOME/twm/fileAgent.txt ; echo -e ""$pp_""
   echo "Automatic User Agent selected"
   echo -e "\e[00m" ;;
  (*)
   clear
   if [ -n $UA ] ; then
    echo -e "\n Invalid option: $(echo $UA)"
    kill -9 $$
   else
    echo -e "\n Time exceeded!"
   fi ;;
  esac
  unset UA
 }
 if [ ! -e $TMP/userAgent.txt ] || [ $(cat $TMP/userAgent.txt | wc -c) -lt 10 ] || [ $(cat $TMP/userAgent.txt | wc -c) -gt 65 ] ; then
  user_agent
 else
  echo -e ""$pp_""
  echo -e "User-Agent: $(shuf -n 1 $TMP/userAgent.txt)"
  echo -e "\e[00m"
 fi
 #/DOS to Unix
 sed -i 's/^M$//g' $TMP/userAgent.txt &> /dev/null
 sed -i 's/\x0D$//g' $TMP/userAgent.txt &> /dev/null
}
