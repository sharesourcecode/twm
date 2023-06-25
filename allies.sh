members_allies() {
 #/Muda para o diretório temporário
 cd $TMP
 #/Adiciona uma linha em branco ao arquivo allies.txt
 echo "" >>allies.txt
 clan_id
 #/Verifica se a variável CLD não está vazia
 if [ -n "$CLD" ]; then
  #/Imprime uma mensagem de auserAgent.txtlização
  echo -e "${ww_}\nUpdating clan members into allies\n\e[00m"
  #/Loop de 5 a 1
  for num in `seq 5 -1 1`; do
   #/Imprime o link do clã
   echo -e "${b__}/clan/${CLD}/${num}\e[00m"
   #/Executa o comando SOURCE com o URL do clã e um agente de usuário aleatório, filtra o resultado com grep e awk e adiciona ao arquivo allies.txt
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/clan/${CLD}/${num}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" | grep -o -E "[/]>([[:upper:]][[:lower:]]{0,15}[[:space:]]{0,1}[[:upper:]]{0,1}[[:lower:]]{0,14},[[:space:]])<s" | awk -F"[>]" '{print $2}' | awk -F"[,]" '{print $1}' | sed 's,\ ,_,' >>allies.txt
   ) </dev/null &>/dev/null &
   time_exit 17
#   sleep 1s
  done
  #/Ordena o arquivo allies.txt e remove duplicatas
  sort -u allies.txt -o allies.txt
 fi
 #/Imprime informações sobre os aliados para Coliseum e King of the Immortals
 echo -e "${ww_}\nAllies for Coliseum and King of the Immortals:\n\e[00m"
 cat allies.txt
 #/Adiciona um usuário ao arquivo allies.txt decodificando uma string base64
 echo "SW5mZXJuYWwgU2hlbGwK" | base64 -d >>allies.txt
 #/Imprime uma mensagem para esperar e auserAgent.txtrda 5 segundos antes de contiuserAgent.txtr
 echo -e "${ww_}Wait to continue.  👈\e[00m"
 sleep 5
}
id_allies() {
 #/Imprime uma mensagem de busca de aliados na lista de amigos
 echo -e "${ww_}Looking for allies on friends list\e[00m"
 #/Muda para o diretório temporário
 cd $TMP
 #/Imprime o caminho dos amigos
 echo -e "${b__}/mail/friends\e[00m"
 #/Executa o comando SOURCE com o URL dos amigos e um agente de usuário aleatório e salva o resultado em um arquivo temporário
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/mail/friends" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
 ) </dev/null &>/dev/null &
 time_exit 17
 #/Obtém o número de páginas de amigos
#  NPG=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep "/mail/friends/[0-9]'>&#62;&#62;" | cut -d\' -f2 | cut -d\/ -f4)
  NPG=$(cat $TMP/SRC | grep -o -E '/mail/friends/([[:digit:]]{0,4})[^[:alnum:]]{4}62[^[:alnum:]]{3}62[^[:alnum:]]' | sed 's/\/mail\/friends\/\([[:digit:]]\{0,4\}\).*/\1/')
  #/Limpa o arquivo tmp.txt
  >tmp.txt
  #/Verifica se NPG está vazio
  if [ -z "$NPG" ]; then
   #/Imprime o caminho dos amigos
   echo -e "${b__}/mail/friends\e[00m"
   #/Executa o comando SOURCE com o URL dos amigos e um agente de usuário aleatório, filtra o resultado com sed e grep e adiciona ao arquivo tmp.txt
   (
    w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/mail/friends" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" | sed 's,/user/,\n/user/,g' |  grep '/user/' | grep '/mail/' | cut -d\< -f1 >>tmp.txt
   ) </dev/null &>/dev/null &
   time_exit 17
  else
   #/Loop do número de páginas de amigos até 1
   for num in `seq "$NPG" -1 1`; do
   #/Imprime a página auserAgent.txtl da lista de amigos
    echo -e "${ww_}Friends list page ${num}\e[00m\n${b__}/mail/friends/${num}\e[00m";
    #/Executa o comando SOURCE com o URL da página auserAgent.txtl dos amigos e um agente de usuário aleatório, filtra o resultado com sed e grep e adiciona ao arquivo tmp.txt
    (
     w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/mail/friends/${num}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" | sed 's,/user/,\n/user/,g' | grep '/user/' | grep '/mail/' | cut -d\< -f1 >>tmp.txt
    ) </dev/null &>/dev/null &
    time_exit 17
#    sleep 1s
   done
  fi
  #/Ordena o arquivo tmp.txt e remove duplicatas
  sort -u tmp.txt -o tmp.txt
  #/Filtra o conteúdo do arquivo tmp.txt com cut e sed e salva no arquivo allies.txt
  cat tmp.txt | cut -d\> -f2 | sed 's,\ ,_,' >allies.txt
}
clan_allies() {
 #/Verifica se a variável CLD não está vazia
 clan_id
 if [ -n "$CLD" ]; then
  #/Muda para o diretório temporário
  cd $TMP
  #/Adiciona um clã ao arquivo callies.txt decodificando uma string base64
  echo "VHJvcGEgSW5mZXJuYWwK" | base64 -d >callies.txt
  #/Filtra o conteúdo do arquivo tmp.txt com cut e salva no arquivo ids.txt
  cat tmp.txt | cut -d/ -f3 >ids.txt
  #/Imprime uma mensagem de busca de aliados do clã na lista de amigos
  echo -e "${ww_}\nClan allies by Leader/Deputy on friends list\n\e[00m"
  #/Configuração do loop
  Lnl=$(cat ids.txt | wc -l); nl=1; ts=0
  #/Loop do número de linhas de ids.txt até 1
  for num in `seq "$Lnl" -1 "$nl"`; do
   #/Obtém o IDN auserAgent.txtl
   IDN=$(cat ids.txt | tail -n $Lnl | head -n 1)
   #/Verifica se IDN não está vazio
   if [ -n "$IDN" ]; then
    #/Imprime o caminho do usuário auserAgent.txtl
    echo -e "${Lnl} ${b__}/user/${IDN}\e[00m"
    #/Executa o comando SOURCE com o URL do usuário auserAgent.txtl e um agente de usuário aleatório e salva o resultado em um arquivo temporário
    (
     w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/user/${IDN}" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >$TMP/SRC
    ) </dev/null &>/dev/null &
    time_exit 17
    #/Obtém o líder e/ou vice-líder do clã auserAgent.txtl
    LEADPU=$(cat $TMP/SRC | sed 's,/clan/,\n/clan/,g' |  grep -E "</a>, <span class='blue'|</a>, <span class='green'" | cut -d\< -f1 |cut -d\> -f2)
    #/Obtém o clã auserAgent.txtl
    alCLAN=$(cat $TMP/SRC | grep -E -o '/clan/[0-9]{1,3}' | tail -n1)
    #/Imprime o líder ou vice-líder e o clã auserAgent.txtl
    echo -e "${bi_} ${LEADPU} - ${alCLAN}\e[00m"
    #Verifica se LEADPU não está vazio
    if [ -n "$LEADPU" ]; then
     #/Incrementa a variável ts
     ts=$((ts + 1))
     #/Adiciona LEADPU ao arquivo callies.txt substituindo espaços por underscores
     echo $LEADPU | sed 's,\ ,_,' >>callies.txt
     #/Imprime uma mensagem de aliado adicionado
     echo -e "${ww_} ${ts}. Ally ${LEADPU} ${alCLAN} added.\e[00m"
     #/Ordena o arquivo callies.txt e remove duplicatas
     sort -u callies.txt -o callies.txt
    fi
    Lnl=$((Lnl - 1))
   fi
   sleep 1s
  done
 fi
}
conf_allies() {
 #/Define o diretório temporário e limpa a tela do terminal
 cd $TMP
 clear
 #/Mostra a mensagem de introdução e opções para o usuário
 echo -e "${ww_}\nThe script will consider users on your friends list and \nClan as allies.\nLeader/Deputy on friend list will add \nClan allies.\n\e[00m\n1) Add/Update alliances(All Battles)\n\n2) Add/Update just Herois alliances(Coliseum/King of immortals)\n\n3) Add/Update just Clan alliances(Altars,Clan Coliseum and Clan Fight)\n\n4) Do nothing\n"
 #/Verifica se o arquivo .al_file existe e tem tamanho maior que 0, e lê o seu conteúdo
 if [ -f "$HOME/twm/.al_file" ] && [ -s "$HOME/twm/.al_file" ]; then
  AL=$(cat $HOME/twm/.al_file)
 else
  #/Solicita ao usuário que informe uma opção, com tempo limite de 300 segundos (5 minutos), e armazena na variável AL
  read -p "Set up alliances[1 to 4]: " -t 300 -e -n 1 AL
 fi
 #/Verifica userAgent.txtl opção foi escolhida pelo usuário e executa as respectivas funções
 case $AL in
 #/Opção 1: Ativa alianças em todas as batalhas (chama as funções AlliesID, ClanAlliesID e Members, define a variável ALD como 1, armazena o valor "1" no arquivo .al_file e exibe uma mensagem de confirmação)
 (1)
  id_allies; clan_allies;
  members_allies; ALD=1;
  echo "1" >$HOME/twm/.al_file;
  echo "Alliances on all battles active" ;;
 #/Opção 2: Ativa alianças apenas em Herois (chama as funções AlliesID e Members, verifica se o arquivo callies.txt existe e, se existir, o esvazia, define a variável ALD como 1, armazena o valor "2" no arquivo .al_file e exibe uma mensagem de confirmação)
 (2)
  id_allies; members_allies;
  if [ -e "$TMP/callies.txt" ]; then
   >$TMP/callies.txt
  fi
  ALD=1; echo "2" >$HOME/twm/.al_file;
  echo "Just Herois alliances now." ;;
 #/Opção 3: Ativa alianças apenas no Clan (chama as funções AlliesID, ClanAlliesID e verifica se o arquivo allies.txt existe e, se existir, o esvazia, desfaz a definição da variável ALD, armazena o valor "3" no arquivo .al_file e exibe uma mensagem de confirmação)
 (3)
  id_allies; clan_allies;
  if [ -e "$TMP/allies.txt" ]; then
   >$TMP/allies.txt
  fi
  unset ALD; echo "3" >$HOME/twm/.al_file;
  echo "Just Clan alliances now." ;;
 #/Opção 4: Não faz nada (exibe uma mensagem de confirmação e adiciona linhas vazias nos arquivos allies.txt e callies.txt, caso existam)
 (4)
  echo "Nothing changed."; ALD=1;
  echo "4" >$HOME/twm/.al_file;
  >>allies.txt; >>callies.txt ;;
 #/Nenhuma opção válida selecionada
 (*)
  clear;
  if [ -n "$AL" ]; then
   echo -e "\n Invalid option: $(echo $AL)"
   kill -9 $$
  else
   echo -e "\n Time exceeded!"
  fi ;;
 esac
 #/Adiciona um usuário ao arquivo allies.txt decodificando uma string base64
 echo "SW5mZXJuYWwgU2hlbGwK" | base64 -d >>allies.txt
 #/Ordena o arquivo allies.txt e remove duplicatas
 sort -u allies.txt -o allies.txt
 #/Adiciona um clã ao arquivo callies.txt decodificando uma string base64
 echo "VHJvcGEgSW5mZXJuYWwK" | base64 -d >>callies.txt
 #/Ordena o arquivo callies.txt e remove duplicatas
 sort -u callies.txt -o callies.txt
 #/Limpa as variáveis usadas na função
 unset ts IDN LEADPU alCLA AL NPG
}
