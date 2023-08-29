clan_id () {
 cd $TMP
 #/Executa o comando especificado no SOURCE com a URL do clã e um userAgent.txt aleatório
 (
  w3m -cookie -o http_proxy=$PROXY -o accept_encoding=UTF-8 -debug -dump_source "${URL}/clan" -o user_agent="$(shuf -n1 $TMP/userAgent.txt)" >CLD
 ) </dev/null &>/dev/null &
 time_exit 20
 #/Lê o conteúdo do arquivo CLD, substitui cada ocorrência de "/clan/" por uma nova linha,
 #/seleciona somente as linhas que contêm a string "built/", e extrai a primeira parte da string
 CLD=$(cat CLD | sed "s/\/clan\//\\n/g" | grep 'built/' | awk -F\/ '{ print $1 }')
}
