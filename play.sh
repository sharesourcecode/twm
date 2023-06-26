#!/bin/sh
(
 RUN=$1
 echo $RUN >$HOME/twm/.runmode_file
 while true ; do
  pidf=$(ps ax -o pid=,args= | grep 'twm/twm.sh' | grep -v 'grep' | head -n1 | grep -o -E '([0-9]{3,5})')
  until [ -z "${pidf}" ] ; do
   kill -9 ${pidf} 2> /dev/null
   pidf=$(ps ax -o pid=,args= | grep 'twm/twm.sh' | grep -v 'grep' | head -n1 | grep -o -E '([0-9]{3,5})')
   sleep 1s
  done
  run_mode () {
   case $RUN in
   (-cl)
    chmod +x $HOME/twm/twm.sh
    $HOME/twm/twm.sh ;;
   (-cv)
    chmod +x $HOME/twm/twm.sh
    $HOME/twm/twm.sh -cv ;;
   (-boot|""|*)
    echo '-boot' >$HOME/twm/.runmode_file
    chmod +x $HOME/twm/twm.sh
    $HOME/twm/twm.sh -boot ;;
   esac
  }
  run_mode
  sleep 0.1s
 done
)
