requer_func () {
 #/servers
 clear
 options_one () {
  clear
  printf " 1)${BLACK_CYAN} English, Global: Titan's War online \033[00m\n 2)${BLACK_CYAN} Русский: Битва Титанов онлайн \033[00m\n 3)${BLACK_CYAN} Polski: Wojna Tytanów online \033[00m\n 4)${BLACK_CYAN} Deutsch: Krieg der Titanen online \033[00m\n 5)${BLACK_CYAN} Español: Guerra de Titanes online \033[00m\n 6)${BLACK_CYAN} Brasil, Português: Furia de Titãs online \033[00m\n 7)${BLACK_CYAN} Italiano: Guerra di Titani online \033[00m\n 8)${BLACK_CYAN} Français: Combat des Titans online \033[00m\n 9)${BLACK_CYAN} Română: Războiul Titanilor online \033[00m\n10)${BLACK_CYAN} 中文, Chinese: 泰坦之战 \033[00m\n11)${BLACK_CYAN} Indonesian: Titan's War Indonesia \033[00m\n C)${BLACK_YELLOW} ❌ Cancel \033[00m\n"
 }
 options_two () {
  clear
  printf " ${BLACK_RED}1\033[00m)${BLACK_CYAN} English, Global: Titan's War online ${BLACK_GREEN}[ENTER]\033[00m\n 2)${CYAN_CYAN} Русский: Битва Титанов онлайн \033[00m\n 3)${CYAN_CYAN} Polski: Wojna Tytanów online \033[00m\n 4)${CYAN_CYAN} Deutsch: Krieg der Titanen online \033[00m\n 5)${CYAN_CYAN} Español: Guerra de Titanes online \033[00m\n 6)${CYAN_CYAN} Brazil, Português: Furia de Titãs online \033[00m\n 7)${CYAN_CYAN} Italiano: Guerra di Titani online \033[00m\n 8)${CYAN_CYAN} Français: Combat des Titans online \033[00m\n 9)${CYAN_CYAN} Română: Războiul Titanilor online \033[00m\n${BLACK_RED}1\033[00m${BLACK_GREEN}0\033[00m)${BLACK_CYAN} 中文, Chinese: 泰坦之战 \033[00m\n${BLACK_RED}1\033[00m${BLACK_GREEN}1\033[00m)${BLACK_CYAN} Indonesian: Titan's War Indonesia \033[00m\n C)${BLACK_YELLOW} ❌ Cancel \033[00m\n"
 }
 invalid_one () {
  options_one
  printf "Select number Server[1 to 11]: \033[01;31m\033[01;07m$UR◄ invalid option\033[00m\n"
  sleep 0.2s
  menu_one
 }
 invalid_two () {
  clear
  options_two
  printf "Select number Server[1 to 11]: \033[01;31m\033[01;07m1$UR◄ invalid option\033[00m\n"
  sleep 0.2s
  menu_two
 }
 menu_two () {
  options_two
  printf "Select number Server[1 to 11]: 1\n"
  read -n 1 UR
  echo $UR
  if [ "$UR" = $'\0' ] ; then
   echo "s_en" >$HOME/twm/ur_file
  elif [ $UR = 0 ] ; then
#   LANG=zh-CN.UTF-8
   echo "s_cn" >$HOME/twm/ur_file
  elif [ $UR = 1 ] ; then
   echo "s_id" >$HOME/twm/ur_file
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
  fi
 }
 menu_one () {
  options_one
  printf "Select number Server[1 to 11]: \n"
  read -n 1 UR
  if [ $UR = 1 ] ; then
   menu_two
  elif [ $UR = 2 ] ; then
   echo "2" >$HOME/twm/ur_file
  elif [ $UR = 3 ] ; then
   echo "3" >$HOME/twm/ur_file
  elif [ $UR = 4 ] ; then
   echo "4" >$HOME/twm/ur_file
  elif [ $UR = 5 ] ; then
   echo "5" >$HOME/twm/ur_file
  elif [ $UR = 6 ] ; then
   echo "6" >$HOME/twm/ur_file
  elif [ $UR = 7 ] ; then
   echo "7" >$HOME/twm/ur_file
  elif [ $UR = 8 ] ; then
   echo "8" >$HOME/twm/ur_file
  elif [ $UR = 9 ] ; then
   echo "9" >$HOME/twm/ur_file
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
  fi
 }
 if [ -f $HOME/twm/ur_file ] && [ -s $HOME/twm/ur_file ] ; then
  UR="$(cat $HOME/twm/ur_file)"
 else
  menu_one
 fi
 UR="$(cat $HOME/twm/ur_file)"
 case $UR in
 (1|s_en)
  URL=$(echo "dGl3YXIubmV0" | base64 -d)
  TMP="$HOME/twm/.1"
  export TZ="Europe/London" ; ALLIES="_WORK" ;;
 (2|ru)
  URL=$(echo "dGl3YXIucnU=" | base64 -d)
  echo "2" >$HOME/twm/ur_file
  TMP="$HOME/twm/.2"
  export TZ="Europe/Moscow" ; ALLIES="_WORK" ;;
 (3|pl)
  URL=$(echo "dGl3YXIucGw=" | base64 -d)
  echo "3" >$HOME/twm/ur_file
  TMP="$HOME/twm/.3"
  export TZ="Europe/Warsaw" ; ALLIES="_WORK" ;;
 (4)
  URL=$(echo "dGl0YW5lbi5tb2Jp" | base64 -d)
  echo "4" >$HOME/twm/ur_file
  TMP="$HOME/twm/.4"
  export TZ="Europe/Berlin" ; ALLIES="_WORK" ;;
 (5)
  URL=$(echo "Z3VlcnJhZGV0aXRhbmVzLm5ldA==" | base64 -d)
  echo "5" >$HOME/twm/ur_file
  TMP="$HOME/twm/.5"
  export TZ="America/Cancun" ; ALLIES="_WORK" ;;
 (6|fu)
  URL=$(echo "ZnVyaWFkZXRpdGFzLm5ldA==" | base64 -d)
  echo "6" >$HOME/twm/ur_file
  TMP="$HOME/twm/.6"
  export TZ="America/Bahia" ; ALLIES="_WORK" ;;
 (7)
  URL=$(echo "Z3VlcnJhZGl0aXRhbmkubmV0" | base64 -d)
  echo "7" >$HOME/twm/ur_file
  TMP="$HOME/twm/.7"
  export TZ="Europe/Rome" ; ALLIES="_WORK" ;;
 (8|fr)
  URL=$(echo "dGl3YXIuZnI=" | base64 -d)
  echo "8" >$HOME/twm/ur_file
  TMP="$HOME/twm/.8"
  export TZ="Europe/Paris" ; ALLIES="_WORK" ;;
 (9|ro)
  URL=$(echo "dGl3YXIucm8=" | base64 -d)
  echo "9" >$HOME/twm/ur_file
  TMP="$HOME/twm/.9"
  export TZ="Europe/Bucharest" ; ALLIES="_WORK" ;;
 (10|s_cn)
  URL=$(echo "Y24udGl3YXIubmV0" | base64 -d)
  TMP="$HOME/twm/.10"
  export TZ="Asia/Shanghai" ; ALLIES="_WORK" ;;
 (11|s_id)
  URL=$(echo "dGl3YXItaWQubmV0" | base64 -d)
  TMP="$HOME/twm/.11"
  export TZ="Asia/Jakarta" ; ALLIES="_WORK" ;;
 (*)
  clear
  if [ -n $UR ] ; then
   printf "\n Invalid option: $(echo $UR)\n"
   kill -9 $$
  else
   printf "\n Time exceeded!\n"
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
  printf "${BLACK_CYAN} Simulate your real or random device. \033[00m\n1)${BLACK_CYAN} Manual \033[00m\n2)${BLACK_CYAN} Automatic \033[00m\n"
  if [ -f $HOME/twm/fileAgent.txt ] && [ -s $HOME/twm/fileAgent.txt ] ; then
   UA=$(cat $HOME/twm/fileAgent.txt)
  else
   printf "Set up User-Agent[1 to 2]: \n"
   read -n 1 UA
  fi
  TWMKEY=$(curl https://codeberg.org/ueliton/auth/raw/branch/main/auth -s -L | base64 -d)
  SERVER='https://gitea.com/api/v1/repos/Ueliton/twm/raw/master/'
  case $UA in
  (0)
   clear ; echo "0" >$HOME/twm/fileAgent.txt
   if [ ! -e $TMP/userAgent.txt ] || [ -z $UA ] ; then
    curl -H "Authorization: token $TWMKEY" ${SERVER}userAgent.txt -s -L >$TMP/userAgent.txt
   fi
   ;;
  (1)
   clear ; echo "0" >$HOME/twm/fileAgent.txt
   xdg-open $(echo "aHR0cHM6Ly93d3cud2hhdHNteXVhLmluZm8=" | base64 -d) &>/dev/null
   printf "Copy and paste your User Agent here and tip ENTER: \n"
   read -n 300 UA
   echo "$UA" >$TMP/userAgent.txt
   if [ ! -e $TMP/userAgent.txt ] || [ -z $UA ] ; then
    printf " ...\n"
    curl -H "Authorization: token $TWMKEY" ${SERVER}userAgent.txt -s -L >$TMP/userAgent.txt
   fi
   ;;
  (2)
   printf " ...\n${BLACK_PINK}"
   curl -H "Authorization: token $TWMKEY" ${SERVER}userAgent.txt -s -L >$TMP/userAgent.txt
   echo "0" >$HOME/twm/fileAgent.txt
   printf "Automatic User Agent selected\n${COLOR_RESET}"
   ;;
  (*)
   clear
   if [ -n $UA ] ; then
    printf "\n Invalid option: $(echo $UA)\n"
    kill -9 $$
   else
    printf "\n Time exceeded!\n"
   fi
   ;;
  esac
  unset UA
 }
 if [ ! -e $TMP/userAgent.txt ] || [ $(cat $TMP/userAgent.txt | wc -c) -lt 10 ] || [ $(cat $TMP/userAgent.txt | wc -c) -gt 65 ] ; then
  user_agent
 else
  printf "${BLACK_PINK}\nUser-Agent: $(shuf -n 1 $TMP/userAgent.txt)\n${COLOR_RESET}\n"
 fi
 #/DOS to Unix
 sed -i 's/^M$//g' $TMP/userAgent.txt &>/dev/null
 sed -i 's/\x0D$//g' $TMP/userAgent.txt &>/dev/null
}
