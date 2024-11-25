#!/bin/bash

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

(
 RUN=$1
 twm_dir="twm-master"
 echo "$RUN" >$HOME/$twm_dir/runmode_file
 while true; do
  pidf=$(jobs -l | awk '/sh.*$twm_dir\/twm\.sh/ { if (NR == 1) print $2 }')
  until [ -z "${pidf}" ]; do
   kill -9 ${pidf} 2>/dev/null
   pidf=$(jobs -l | awk '/sh.*$twm_dir\/twm\.sh/ { if (NR == 1) print $2 }')
   sleep 1s
  done
  run_mode () {
   if echo "$RUN"|grep -q -E '[-]cl'; then
    chmod +x $HOME/$twm_dir/twm.sh ; $HOME/$twm_dir/twm.sh
   elif echo "$RUN"|grep -q -E '[-]cv'; then
    chmod +x $HOME/$twm_dir/twm.sh ; $HOME/$twm_dir/twm.sh -cv
   elif echo "$RUN"|grep -q -E '[-]boot'; then
    echo '-boot' >$HOME/$twm_dir/runmode_file ; chmod +x $HOME/$twm_dir/twm.sh ; $HOME/$twm_dir/twm.sh -boot
   else
    echo '-boot' >$HOME/$twm_dir/runmode_file ; chmod +x $HOME/$twm_dir/twm.sh ; $HOME/$twm_dir/twm.sh -boot
   fi
  }
  run_mode
  sleep 0.1s
 done
)
