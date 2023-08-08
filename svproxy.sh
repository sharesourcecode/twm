func_proxy () {
 SPROXY=$(drill ${URL} 2> /dev/null|grep -o -E "([0-9]{1,3}\.){3}[0-9]{1,3}"|sed -n 's/^.*$/&:80/;1p')
 PROXY="http://$SPROXY"
 if echo "$SVPROXY"|grep -q '8.8.8.8:80' || echo "$SVPROXY"|grep -q '1.1.1.1:80' || [ -z "$SPROXY" ]; then
  if echo "$UR"|grep -q 's_en' || [ "$UR" = "$'\0'" ] || echo "$UR"|grep -q '3'; then
   PROXY="http://176.9.21.20:80"
  elif echo "$UR"|grep -q 's_cn' || echo "$UR"|grep -q 's_id' || echo "$UR"|grep -q '0' || echo "$UR"|grep -q '1' || [ "$UR" -ge 4 ]; then
   PROXY="http://138.201.178.183:80"
  elif echo "$UR"|grep -q "2"; then
   PROXY="http://148.251.244.27:80"
  fi
 fi
 printf "${BLACK_GRAY} Server: ${URL}|${PROXY} ${COLOR_RESET}\n"
 unset SVPROXY
}
