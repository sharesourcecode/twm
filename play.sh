#!/bin/sh
(
 RUN=$1
 echo "$RUN" >twm//runmode_file
 while true; do
  pidf=$(ps ax -o pid=,args=|grep "sh.*twm/twm.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
  until [ -z "${pidf}" ]; do
   kill -9 ${pidf} 2>/dev/null
   pidf=$(ps ax -o pid=,args=|grep "sh.*twm/twm.sh"|grep -v 'grep'|head -n 1|grep -o -E '([0-9]{3,5})')
   sleep 1s
  done
  run_mode () {
   if echo "$RUN"|grep -q -E '[-]cl'; then
    chmod +x twm//twm.sh ; twm//twm.sh
   elif echo "$RUN"|grep -q -E '[-]cv'; then
    chmod +x twm//twm.sh ; twm//twm.sh -cv
   elif echo "$RUN"|grep -q -E '[-]boot'; then
    echo '-boot' >twm//runmode_file ; chmod +x twm//twm.sh ; twm//twm.sh -boot
   else
    echo '-boot' >twm//runmode_file ; chmod +x twm//twm.sh ; twm//twm.sh -boot
   fi
  }
  run_mode
  sleep 0.1s
 done
)
