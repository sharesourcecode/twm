#!/bin/sh

## user146726
## https://unix.stackexchange.com/questions/137566/arrays-in-unix-bourne-shell#:~:text=at%2016%3A11-,user146726,-2
## The following functions implement vectors (arrays) operations in dash:
## Definition of a vector <v>:
##      v_0 - variable that stores the number of elements of the vector
##      v_1..v_n, where n=v_0 - variables that store the values of the vector elements

vectors_array () {
 VectorAddElementNext () {
# Vector Add Element Next
# Adds the string contained in variable $2 in the next element position (vector length + 1) in vector $1

    local elem_value
    local vector_length
    local elem_name

    eval elem_value=\"\$$2\"
    eval vector_length=\$$1\_0
    if [ -z "$vector_length" ]; then
        vector_length=$((0))
    fi

    vector_length=$(( vector_length + 1 ))
    elem_name=$1_$vector_length

    eval $elem_name=\"\$elem_value\"
    eval $1_0=$vector_length
 }

 VectorAddElementDVNext () {
# Vector Add Element Direct Value Next
# Adds the string $2 in the next element position (vector length + 1) in vector $1

    local elem_value
    local vector_length
    local elem_name

    eval elem_value="$2"
    eval vector_length=\$$1\_0
    if [ -z "$vector_length" ]; then
        vector_length=$((0))
    fi

    vector_length=$(( vector_length + 1 ))
    elem_name=$1_$vector_length

    eval $elem_name=\"\$elem_value\"
    eval $1_0=$vector_length
 }

 VectorAddElement () {
# Vector Add Element
# Adds the string contained in the variable $3 in the position contained in $2 (variable or direct value) in the vector $1

    local elem_value
    local elem_position
    local vector_length
    local elem_name

    eval elem_value=\"\$$3\"
    elem_position=$(($2))
    eval vector_length=\$$1\_0
    if [ -z "$vector_length" ]; then
        vector_length=$((0))
    fi

    if [ $elem_position -ge $vector_length ]; then
        vector_length=$elem_position
    fi

    elem_name=$1_$elem_position

    eval $elem_name=\"\$elem_value\"
    if [ ! $elem_position -eq 0 ]; then
        eval $1_0=$vector_length
    fi
 }

 VectorAddElementDV () {
# Vector Add Element
# Adds the string $3 in the position $2 (variable or direct value) in the vector $1

    local elem_value
    local elem_position
    local vector_length
    local elem_name

    eval elem_value="$3"
    elem_position=$(($2))
    eval vector_length=\$$1\_0
    if [ -z "$vector_length" ]; then
        vector_length=$((0))
    fi

    if [ $elem_position -ge $vector_length ]; then
        vector_length=$elem_position
    fi

    elem_name=$1_$elem_position

    eval $elem_name=\"\$elem_value\"
    if [ ! $elem_position -eq 0 ]; then
        eval $1_0=$vector_length
    fi
 }

 VectorPrint () {
# Vector Print
# Prints all the elements names and values of the vector $1 on sepparate lines

    local vector_length

    vector_length=$(($1_0))
    if [ "$vector_length" = "0" ]; then
        echo "Vector \"$1\" is empty!"
    else
        echo "Vector \"$1\":"
        for i in $(seq 1 $vector_length); do
            eval echo \"[$i]: \\\"\$$1\_$i\\\"\"
            ###OR: eval printf \'\%s\\\n\' \"[\$i]: \\\"\$$1\_$i\\\"\"
        done
    fi
 }

 VectorDestroy () {
# Vector Destroy
# Empties all the elements values of the vector $1

    local vector_length

    vector_length=$(($1_0))
    if [ ! "$vector_length" = "0" ]; then
        for i in $(seq 1 $vector_length); do
            unset $1_$i
        done
        unset $1_0
    fi
 }

##################
### MAIN START ###
##################

## Setting vector 'params' with all the parameters received by the script:
 for i in $(seq 1 $#); do
    eval param="\${$i}"
    VectorAddElementNext params param
 done

# Printing the vector 'params':
 VectorPrint params

# read temp

## Setting vector 'params2' with the elements of the vector 'params' in reversed order:
 if [ -n "$params_0" ]; then
    for i in $(seq 1 $params_0); do
        count=$((params_0-i+1))
        VectorAddElement params2 count params_$i
    done
 fi

# Printing the vector 'params2':
 VectorPrint params2

#read temp

## Getting the values of 'params2'`s elements and printing them:
 if [ -n "$params2_0" ]; then
    echo "Printing the elements of the vector 'params2':"
    for i in $(seq 1 $params2_0); do
        eval current_elem_value=\"\$params2\_$i\"
        echo "params2_$i=\"$current_elem_value\""
    done
 else
    echo "Vector 'params2' is empty!"
 fi
}

 dim_array () {
 ## Creating a two dimensional array ('a'):
  for i in $(seq 1 10); do
    VectorAddElement a 0 i
    for j in $(seq 1 8); do
        value=$(( 8 * ( i - 1 ) + j ))
        VectorAddElementDV a_$i $j $value
    done
 done

## Manually printing the two dimensional array ('a'):
 echo "Printing the two-dimensional array 'a':"
 if [ -n "$a_0" ]; then
    for i in $(seq 1 $a_0); do
        eval current_vector_lenght=\$a\_$i\_0
        if [ -n "$current_vector_lenght" ]; then
            for j in $(seq 1 $current_vector_lenght); do
                eval value=\"\$a\_$i\_$j\"
                printf "$value "
            done
        fi
        printf "\n"
    done
 fi
}
################
### MAIN END ###
################

