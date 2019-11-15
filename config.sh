#!/bin/bash

# folder paths etc, to be loaded from every script.

VERSION=v0.7

# binary to use, e.g. node-template, or substrate
SUBSTRATE=node-template

# keys and chainspec are stored in folder 
GENERATED=generated

# all scripts live in folder
SCRIPTS=scripts

# naming of the nodes begins with
FILESTUB=SS

# build-spec --chain local  
TEMPLATE="local"

# my own chainspec is named:
CHAIN="$GENERATED/$FILESTUB"-raw.json

# first arg must be number of nodes 
checknum () {
    
    NUM=$1
    if [ -z "$NUM" ] 
    then
        echo "give number of nodes as integer arg please"
        exit
    fi
    
    if [ "$NUM" -ge 10 ] 
    then
        echo "max number of nodes is 9, then it would need some tiny code upgrades:"
        echo e.g.
        echo rpc 9933 + 11 = ws 9944 port collision
        echo log file names 01 .. 09 ... 10
        exit
    fi
}

settrap () {
    # exit when any command fails
    set -e
    # keep track of the last executed command
    trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
    # echo an error message before exiting
    trap 'echo; echo "\"${last_command}\" command filed with exit code $?."' EXIT
}
