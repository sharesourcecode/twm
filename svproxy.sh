func_proxy () {
 #/Obtém o IP do URL especificado usando o comando "drill",
 #/extrai o endereço IP a partir da saída com o comando "grep" e adiciona a porta ":80" com o comando "sed"
 SPROXY=$(drill ${URL} 2> /dev/null | grep -o -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | sed -n 's/^.*$/&:80/;1p')
 #/Define o proxy como http://<endereço_ip_obtido>:80
 PROXY="http://$SPROXY"
 if [ "$SPROXY" = '8.8.8.8:80' ] || [ "$SPROXY" = '1.1.1.1:80' ] || [ -z "$SPROXY" ]; then
  #/Se o endereço IP ou URL for inválido, seleciona um proxy padrão baseado no valor de "UR"
  if [ "$UR" = "s_en" ] || [ "$UR" = "$'\0'" ] || [ "$UR" = 3 ]; then
   PROXY="http://176.9.21.20:80"
  elif [ "$UR" = "s_cn" ] || [ "$UR" = "s_id" ] || [ "$UR" = 0 ] || [ "$UR" = 1 ] || [ "$UR" -ge 4 ]; then
   PROXY="http://138.201.178.183:80"
  elif [ "$UR" = 2 ]; then
   PROXY="http://148.251.244.27:80"
  fi
 fi
 #/Imprime o URL e o proxy selecionado na tela com formatação de cor
 printf "${BLACK_GRAY} Server: ${URL}|${PROXY} ${COLOR_RESET}\n"
 #/Remove a variável temporária UR
 unset UR SVPROXY
 #/Use w3m com a opção -o http_proxy=$PROXY e o URL fornecido como argumento
 #/(o comando w3m não está presente nesta função, mas pode ser usado posteriormente)
}
