#!/bin/dash

# Defina a porta que você deseja usar
PORT=8080

# O diretório que você deseja compartilhar (pode ser ajustado conforme necessário)
DIRECTORY="/data/data/com.termux/files/home/twm"

# Função para servir arquivos
serve_file() {
 if [ -f "$DIRECTORY/$1" ]; then
   {
     echo "HTTP/1.1 200 OK"
     echo "Content-Type: application/octet-stream"
     echo "Content-Length: $(stat -c%s "$DIRECTORY/$1")"
     echo
     cat "$DIRECTORY/$1"
   } | ncat -l -p $PORT
 else
   {
     echo "HTTP/1.1 404 Not Found"
     echo "Content-Type: text/plain"
     echo
     echo "Arquivo não encontrado"
   } | ncat -l -p $PORT
 fi
}

# Iniciar servidor
while :; do

 case `date +%X` in
    *:*:?0|*:*:?1|*:*:?2|*:*:?3|*:*:?4|*:*:?5)
      printf "Servidor HTTP disponivel entre os segundos de final 0 a 5.\nAcesse localhost:$PORT/NomeDeArquivo\nPressione Ctrl+C para parar.\n"
      # Ouvir na porta especificada e aceitar conexões
      ncat -l -p $PORT | (
        read -r line
        # Extraia o nome do arquivo
        FILE=$(echo "$line" | grep -o "GET /[^ ]*" | cut -d' ' -f2 | cut -d'/' -f2)
        serve_file "$FILE"
      ) ;;
    # Servidor parado, aguardando reinício
    *) sleep 1s ;;
 esac

done
