#!/bin/sh
func () { 
    echo Ola Mundo!
    read -t 10 -n1 -s cmd
    printf "$cmd"
    func
    local prompt="Password: "
   local charcount=0
   while IFS= read -p "$prompt" -r -s -n 1 char ; do
    #/Enter - accept password
    if [ "$char" = $'\0' ] ; then
     break &>/dev/null
    fi
    #/Backspace
    if [ "$char" = $'\177' ] ; then
     if [ "$charcount" -gt 0 ] ; then
      local charcount=$((charcount - 1))
      local prompt=$(echo -n $'\b \b')
      local password=$(echo "$password" | sed 's/.$//')
     else
      local prompt=$(echo -n '')
     fi
    else
     local charcount=$((charcount + 1))
     local prompt=$(echo -n '*')
     local password="${password}${char}"
    fi
   done
   clear && echo Your Password is : "${password}"; return;
    }