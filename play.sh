#!/bin/sh
(
 RUN=$1
 echo "$RUN" > $HOME/twm/runmode_file
 while true ; do
  pidf=$(ps ax -o pid=,args= | grep 'twm/twm.sh' | grep -v 'grep' | head -n1 | grep -o -E '([0-9]{3,5})')
  until [ -z "${pidf}" ] ; do
   kill -9 ${pidf} 2> /dev/null
   pidf=$(ps ax -o pid=,args= | grep 'twm/twm.sh' | grep -v 'grep' | head -n1 | grep -o -E '([0-9]{3,5})')
   sleep 1s
  done
  run_mode () {
   awk -v run="$RUN" -v mcl="-cl" mcv="-cv" mboot="-boot" '
    BEGIN {
     if (run == mcl) {
      system("chmod +x $HOME/twm/twm.sh ; $HOME/twm/twm.sh")
     } else if (run == mcv) {
      system("chmod +x $HOME/twm/twm.sh ; $HOME/twm/twm.sh -cv")
     } else if (run == mboot) {
      system("echo '-boot' >$HOME/twm/runmode_file ; chmod +x $HOME/twm/twm.sh ; $HOME/twm/twm.sh -boot")
     } else {
      system("echo '-boot' >$HOME/twm/runmode_file ; chmod +x $HOME/twm/twm.sh ; $HOME/twm/twm.sh -boot")
     }
    }
   '
  }
  run_mode
  sleep 0.1s
 done
)
