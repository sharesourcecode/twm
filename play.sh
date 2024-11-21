#!/bin/sh

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

RUN=$1
twm_dir="twm-master"
echo "$RUN" >$HOME/$twm_dir/runmode_file

run_mode() {

  case "$RUN" in
    "-cl")
      chmod +x $HOME/$twm_dir/twm.sh
      $HOME/$twm_dir/twm.sh #&
      wait
    ;;
    "-cv")
      chmod +x $HOME/$twm_dir/twm.sh
      $HOME/$twm_dir/twm.sh -cv #&
      wait
    ;;
    "-boot")
      echo '-boot' >$HOME/$twm_dir/runmode_file ; chmod +x $HOME/$twm_dir/twm.sh
      $HOME/$twm_dir/twm.sh -boot #&
      wait
    ;;
    *)
      echo '-boot' >$HOME/$twm_dir/runmode_file
      chmod +x $HOME/$twm_dir/twm.sh
      $HOME/$twm_dir/twm.sh -boot #&
      wait
    ;;
  esac

}

while true; do
  pidf=$(jobs -l | awk '/sh.*$twm_dir\/twm\.sh/ { if (NR == 1) print $2 }')

  if [ -z "${pidf}" ]; then
    sync
    kill -9 ${pidf} > /dev/null 2>&1
    pidf=$(jobs -l | awk '/sh.*$twm_dir\/twm\.sh/ { if (NR == 1) print $2 }')
    sleep 1s
  fi

  run_mode
  sleep 0.1s
done
