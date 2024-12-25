#!/bin/bash

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

(
 RUN=`echo $1|sed 's#-#a#'`
 twm_dir="twm"
 echo "$RUN" >$HOME/$twm_dir/runmode_file

 while true; do
   pidf=$(jobs -l | awk '/sh.*$twm_dir\/twm\.sh/ { if (NR == 1) print $2 }')

   until [ -z "${pidf}" ]; do
     kill -9 ${pidf} 2>/dev/null
     pidf=$(jobs -l | awk '/sh.*$twm_dir\/twm\.sh/ { if (NR == 1) print $2 }')
     sleep 1s
   done

   run_mode () {

     if [ "$RUN" = "acl" ]; then
       chmod +x $HOME/$twm_dir/twm.sh ; $HOME/$twm_dir/twm.sh
     elif [ "$RUN" = "acv" ]; then
       chmod +x $HOME/$twm_dir/twm.sh ; $HOME/$twm_dir/twm.sh -cv
     elif [ "$RUN" = "boot" ]; then
       echo 'aboot' >$HOME/$twm_dir/runmode_file ; chmod +x $HOME/$twm_dir/twm.sh ; $HOME/$twm_dir/twm.sh -boot
     else
       echo 'aboot' >$HOME/$twm_dir/runmode_file ; chmod +x $HOME/$twm_dir/twm.sh ; $HOME/$twm_dir/twm.sh -boot
     fi

   }

   run_mode
   sleep 0.1s
 done
)
