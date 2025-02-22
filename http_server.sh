#!/bin/dash

# Defina a porta que você deseja usar
PORT=8080

# O diretório que você deseja compartilhar (pode ser ajustado conforme necessário)
DIRECTORY="/data/data/com.termux/files/home/twm"

# Verificar a disponibilidade de ncat ou nc
if command -v ncat >/dev/null 2>&1; then
 NC_CMD="ncat -l -p $PORT"
elif command -v nc >/dev/null 2>&1; then
 NC_CMD="nc -l $PORT"
else
 echo "Nenhum comando ncat ou nc encontrado."
 exit 1
fi

# Função para servir arquivos
serve_file() {

 if [ -f "$DIRECTORY/$1" ]; then
   {
     echo "HTTP/1.1 200 OK"
     echo "Content-Type: application/octet-stream"
     echo "Content-Length: $(stat -c%s "$DIRECTORY/$1")"
     echo
     cat "$DIRECTORY/$1"
   } | $NC_CMD
 else
   {
     echo "HTTP/1.1 404 Not Found"
     echo "Content-Type: text/plain"
     echo
     echo "Arquivo não encontrado"
   } | $NC_CMD
 fi

}

# Iniciar servidor
while :; do

 case `date +%X` in
   *:*:?0|*:*:?1|*:*:?2|*:*:?3|*:*:?4|*:*:?5)
     printf "Servidor HTTP disponível entre os segundos de final 0 a 5.\nAcesse localhost:$PORT/NomeDeArquivo\nPressione Ctrl+C para parar.\n"

     # Escutar na porta especificada e aceitar conexões
     $NC_CMD | (
       read -r line
       # Extraia o nome do arquivo
       FILE=$(echo "$line" | grep -o "GET /[^ ]*" | cut -d' ' -f2 | cut -d'/' -f2)
       serve_file "$FILE"
     ) ;;

     # Servidor parado, aguardando reinício
   *) sleep 1s ;;
 esac

done
