#!/bin/sh
func () { 
    echo oi
    read -t 10 -n1 -s cmd
    printf "$cmd"
    }