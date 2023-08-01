#!/bin/sh
func () { 
    echo Ola Mundo!
    read -t 10 -n1 -s cmd
    printf "$cmd"
    func
    }