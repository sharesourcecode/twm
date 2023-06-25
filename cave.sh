#/Define a função cave_start
cave_start () {
 #/Imprime a string cave
 echo "cave ..."
 #/Chama a função clan_id
 clan_id
 #/Se a variável CLD não estiver vazia
 if [ -n "$CLD" ]; then
  #/Executa o comando w3m com as opções de URL e agente do usuário e canalize a saída para o tail com 0 linhas
#  (
#    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug "$URL/clan/$CLD/quest/take/5" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" | tail -n 0
#  ) </dev/null &>/dev/null &
  #/AuserAgent.txtrda 10 segundos
#  time_exit 17
  #/Imprime a string
#  echo "/clan/$CLD/quest/take/5"
  #/Executa o comando PAGE com as opções de URL e agente do usuário e canalize a saída para o tail com 0 linhas
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug "${URL}/clan/${CLD}/quest/help/5" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" | tail -n 0
  ) </dev/null &>/dev/null &
  #/AuserAgent.txtrda 10 segundos
  time_exit 17
  #/Imprime a string
  echo "/clan/${CLD}/quest/help/5"
 fi
 #/Defina a função condition_func
 condition_func () {
  #/Executa o comando SOURCE com as opções de URL e agente do usuário e redirecione a saída para o arquivo TMP/SRC
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/cave/" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
  ) </dev/null &>/dev/null &
  #/AuserAgent.txtrda 10 segundos
  time_exit 17
  #/Define a variável ACCESS1 como o resultado do comando cat com o arquivo TMP/SRC, seguido pelo comando sed para substituir href= por uma nova linha, seguido pelo comando grep para filtrar linhas contendo '/cave/', seguido pelo comando head para pegar a primeira linha e finalmente pelo comando awk para pegar o segundo campo delimitado por aspas simples
  ACCESS1=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n1 | awk -F\' '{ print $2 }')
  #/Define a variável DOWN como o resultado do comando cat com o arquivo TMP/SRC, seguido pelo comando sed para substituir href= por uma nova linha, seguido pelo comando grep para filtrar linhas contendo '/cave/down' e finalmente pelo comando awk para pegar o segundo campo delimitado por aspas simples
  DOWN=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/cave/down' | awk -F\' '{ print $2 }')
  #/Define a variável ACCESS2 como o resultado do comando cat com o arquivo TMP/SRC, seguido pelo comando sed para substituir href= por uma nova linha, seguido pelo comando grep para filtrar linhas contendo '/cave/', seguido pelos comandos head e tail para pegar a segunda linha e finalmente pelo comando awk para pegar o segundo campo delimitado por aspas simples
  ACCESS2=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n2 | tail -n1 | awk -F\' '{ print $2 }')
  #/Define a variável ACTION como o resultado do comando cat com o arquivo TMP/SRC, seguido pelo comando sed para substituir href= por uma nova linha, seguido pelo comando grep para filtrar linhas contendo '/cave/', seguido pelo comando awk para pegar o segundo campo delimitado por aspas simples e finalmente pelo comando tr para remover todos os caracteres que não sejam letras do alfabeto
  ACTION=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/cave/' | awk -F\' '{ print $2 }' | tr -cd "[[:alpha:]]")
  #/Define a variável MEGA como o resultado do comando cat com o arquivo TMP/SRC, seguido pelo comando sed para substituir src= por uma nova linha, seguido pelos comandos grep para filtrar linhas contendo '/images/icon/silver.png' e "'s'", seguido pelo comando tail para pegar a última linha e finalmente pelo comando grep com a opção -o para imprimir apenas o caractere 'M'
  MEGA=$(cat $TMP/SRC | sed 's/src=/\n/g' | grep '/images/icon/silver.png' | grep "'s'" | tail -n1 | grep -o 'M')
 }
 #/Chama a função condition_func
 condition_func
 #/Define a variável num como 1
 local num=1
 #/Define a variável BREAK como o resultado do comando echo com a soma dos minutos auserAgent.txtis mais 2
 local BREAK=$(echo $(( `date +%s` + 120 )))
 #/Executa o loop até que a variável num seja iuserAgent.txtl a 0 e a variável PLAY seja diferente de "cv"
 until [ $num -eq 0 ] && [ "$PLAY" != 'cv' ]; do
 #/Se a variável PLAY for diferente de cv e os minutos auserAgent.txtis forem iuserAgent.txtis à variável BREAK, saia do loop
  if [ "$PLAY" != "cv" ] && [ "$(date +%s)" -eq "$BREAK" ]; then
   break
  fi
  #/Chama a função condition_func
  condition_func
  #/Usa a estrutura case para verificar o valor da variável ACTION
  case $ACTION in
   #/Se o valor da variável ACTION for cavechancercavegatherrcavedownr
   (cavechancercavegatherrcavedownr)
    #/Executa o comando SOURCE com as opções de URL e agente do usuário e redirecione a saída para o arquivo TMP/SRC
    (
     w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${ACCESS2}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
    ) </dev/null &>/dev/null &
    #/AuserAgent.txtrda 10 segundos
    time_exit 17
    #/Imprime o valor da variável ACCESS2
    echo "${ACCESS2}"
    #/Decrementa a variável num em 1
    local num=$((num - 1)) ;;
   #/Se o valor da variável ACTION for "cavespeedUpr"
   (cavespeedUpr)
    #/Executa o comando SOURCE com as opções de URL e agente do usuário e redirecione a saída para o arquivo TMP/SRC
    (
     w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${ACCESS2}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
    ) </dev/null &>/dev/null &
    #/AuserAgent.txtrda 10 segundos
    time_exit 17
    #/Imprime o valor da variável ACCESS2
    echo "${ACCESS2}"
    #/Decrementa a variável num em 1
    local num=$((num - 1)) ;;
   #/Se o valor da variável ACTION for "cavedownr", "cavedownrclanbuiltprivateUpgradetruerrefcave"
   (cavedownr|cavedownrclanbuiltprivateUpgradetruerrefcave)
    #/Decrementa a variável num em 1
    local num=$((num - 1)) ;
    #/Executa o comando SOURCE com as opções de URL e agente do usuário e redirecione a saída para o arquivo TMP/SRC
    (
     w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${DOWN}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
    ) </dev/null &>/dev/null &
    #/AuserAgent.txtrda 10 segundos
    time_exit 17
    #/Imprime o valor da variável DOWN
    echo "$DOWN" ;;
   #/Se o valor da variável ACTION for "caveattackrcaverunawayr"
   (caveattackrcaverunawayr)
    #/Decrementa a variável num em 1
    local num=$((num - 1)) ;
    #/Executa o comando SOURCE com as opções de URL e agente do usuário e redirecione a saída para o arquivo TMP/SRC
    (
     w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}${ACCESS1}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
    ) </dev/null &>/dev/null &
    #/AuserAgent.txtrda 10 segundos
    time_exit 17
    #/Imprime o valor da variável ACCESS1
    echo "${ACCESS1}"
    #/Executa o comando SOURCE com as opções de URL e agente do usuário e redirecione a saída para o arquivo TMP/SRC
    (
     w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/cave/runaway" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
    ) </dev/null &>/dev/null &
    #/AuserAgent.txtrda 10 segundos
    time_exit 17
    #/Imprime a string
    echo '/cave/runaway' ;;
    #/Se o valor da variável ACTION for userAgent.txtlquer outro valor
   (*) local num=0 ;;
  esac
  #/Executa o comando cat com o arquivo TMP/SRC, seguido pelo comando sed para substituir href= por uma nova linha, seguido pelo comando grep para filtrar linhas contendo '/cave/', seguido pelos comandos head e tail para pegar a segunda linha e finalmente pelo comando awk para pegar o segundo campo delimitado por aspas simples
#  cat $TMP/SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n2 | tail -n1 | awk -F\' '{ print $2 }'
  #/AuserAgent.txtrda 1 segundo
  sleep 0.1s
 done
 #/Se a variável CLD não estiver vazia
 if [ -n "$CLD" ]; then
  #/Executa o comando PAGE com as opções de URL e agente do usuário e canalize a saída para o tail com 0 linhas
  (
   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug "${URL}/clan/${CLD}/quest/deleteHelp/5" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" | tail -n 0
  ) </dev/null &>/dev/null &
  #/AuserAgent.txtrda 10 segundos
  time_exit 17
  #/Imprime a string
  echo "/clan/${CLD}/quest/deleteHelp/5"
  #/Executa o comando PAGE com as opções de URL e agente do usuário e canalize a saída para o tail com 0 linhas
#  (
#   w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug "${URL}/clan/${CLD}/quest/end/5" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" | tail -n 0
#  ) </dev/null &>/dev/null &
  #/AuserAgent.txtrda 10 segundos
#  time_exit 17
  #/Imprime a string
#  echo "/clan/${CLD}/quest/end/5"
 fi
 #/Se a variável PLAY for diferente de "cv", imprima a string "You can run bash twm/play.sh -cv"
 if [ "$PLAY" != "cv" ]; then
  echo "You can run bash twm/play.sh -cv"
 fi
 #/Imprime a string cave (✔)\n
 echo -e "cave (✔)\n"
 unset ACCESS1 ACCESS2 ACTION DOWN MEGA
}
