#!/bin/bash

# folder paths etc, to be loaded from every script.

VERSION=v0.8

# binary to use, e.g. node-template, or substrate
SUBSTRATE=node-template

# keys and chainspec are stored in folder 
GENERATED=generated

# logfiles go into this folder
LOGFILES=logs

# all scripts live in folder
SCRIPTS=scripts

# data folders for the nodes
BASEPATH=/tmp

# naming of the nodes begins with
FILESTUB=SS

# build-spec --chain local  
TEMPLATE="local"

# my own chainspec is named:
CHAIN="$GENERATED/$FILESTUB"-raw.json

# CLI args for all nodes: 
CONFIG="--validator --chain "$CHAIN" --telemetry-url ws://telemetry.polkadot.io:1024"

# ports of the FIRST node, subsequent nodes are incremented+1
PORT_P2P=30333
PORT_RPC=9933
PORT_WS=9944

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

chapter () {
    echo 
    echo ==========================================
    echo = $1
    echo ==========================================
        
    $1
}