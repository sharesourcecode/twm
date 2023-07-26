#!/bin/bash
printf "updating source files"
cd ~/
rm -rf $HOME/sourceinstall.sh
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/sourceinstall.sh -L -O
sleep 3s
chmod +x ./sourceinstall.sh
printf "Updated... Starting"
./sourceinstall.sh