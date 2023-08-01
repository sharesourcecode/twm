#!/bin/sh
func () { 
    echo oi
    read -t 4 -n1 -s cmd
    $cmd
    }