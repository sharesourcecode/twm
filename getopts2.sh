#!/bin/sh

CONFIG_FILE="config.txt"

# Inicializa padrões se o arquivo de configuração não existir
if [ ! -f "$CONFIG_FILE" ]; then
    echo "1=[ ] [x] [ ]" > "$CONFIG_FILE"
    echo "2=[ ] [ ] [x]" >> "$CONFIG_FILE"
    echo "3=[x] [ ] [ ]" >> "$CONFIG_FILE"
fi

# Carrega configurações do arquivo
op1=$(grep "^1=" "$CONFIG_FILE" | cut -d'=' -f2)
op2=$(grep "^2=" "$CONFIG_FILE" | cut -d'=' -f2)
op3=$(grep "^3=" "$CONFIG_FILE" | cut -d'=' -f2)

# Processa argumentos iniciais e salva no arquivo
while getopts "1:2:3:" opt; do
    case $opt in
        1)
            case $OPTARG in
                a) op1="[x] [ ] [ ]" ;;
                b) op1="[ ] [x] [ ]" ;;
                c) op1="[ ] [ ] [x]" ;;
                *) echo "Caractere incompatível" ;;
            esac
            ;;
        2)
            case $OPTARG in
                a) op2="[x] [ ] [ ]" ;;
                b) op2="[ ] [x] [ ]" ;;
                c) op2="[ ] [ ] [x]" ;;
                *) echo "Caractere incompatível" ;;
            esac
            ;;
        3)
            case $OPTARG in
                a) op3="[x] [ ] [ ]" ;;
                b) op3="[ ] [x] [ ]" ;;
                c) op3="[ ] [ ] [x]" ;;
                *) echo "Caractere incompatível" ;;
            esac
            ;;
        *) echo "Opção inválida" ;;
    esac
done

# Loop para permitir alterações dinâmicas
while true; do
    clear
    echo "Status atual:"
    echo "1) $op1"
    echo "2) $op2"
    echo "3) $op3"
    echo "Digite uma nova opção (exemplo: 1a, 2b, 3c) ou 'X' para sair:"
    input=$(dd bs=512 count=1 2>/dev/null)

    if [ "$input" = "X" ] || [ "$input" = "x" ]; then
        echo "Encerrando o programa..."
        break
    fi

    opt=$(echo "$input" | cut -c1)
    OPTARG=$(echo "$input" | cut -c2)

    case $opt in
        1)
            case $OPTARG in
                a) op1="[x] [ ] [ ]" ;;
                b) op1="[ ] [x] [ ]" ;;
                c) op1="[ ] [ ] [x]" ;;
                *) echo "Caractere incompatível" ;;
            esac
            ;;
        2)
            case $OPTARG in
                a) op2="[x] [ ] [ ]" ;;
                b) op2="[ ] [x] [ ]" ;;
                c) op2="[ ] [ ] [x]" ;;
                *) echo "Caractere incompatível" ;;
            esac
            ;;
        3)
            case $OPTARG in
                a) op3="[x] [ ] [ ]" ;;
                b) op3="[ ] [x] [ ]" ;;
                c) op3="[ ] [ ] [x]" ;;
                *) echo "Caractere incompatível" ;;
            esac
            ;;
        *) echo "Opção inválida" ;;
    esac

    # Salva alterações no arquivo
    echo "1=$op1" > "$CONFIG_FILE"
    echo "2=$op2" >> "$CONFIG_FILE"
    echo "3=$op3" >> "$CONFIG_FILE"
done

