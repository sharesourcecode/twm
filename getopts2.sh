#!/bin/sh

# Inicializa as opções padrão
op1="[ ] [x] [ ]"
op2="[ ] [ ] [x]"
op3="[x] [ ] [ ]"

# Processa argumentos iniciais
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
    read input

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
done

