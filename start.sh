#!/bin/bash

# the whole thing: generate keys, modify chainspec, start nodes, insertKeys

source config.sh
checknum $1

chapter "echo substrate-starter $VERSION"

# call with source so that the Python virtualenv keeps enabled (so that websockets is available):
chapter "source scripts/dependencies.sh"

chapter "scripts/subkey_generate.sh $NUM"

chapter "scripts/chainspec-generate.sh $NUM"

chapter "scripts/kill-nodes.sh"

chapter "scripts/start-nodes.sh $NUM"

# make these longer if you see: ALERT: (<class 'ConnectionRefusedError'>)
# during the chapter: scripts/substrate-insert-keys.py $NUM
SLEEP=3
if [ "$1" -ge 10 ]; then
   SLEEP=7
fi
if [ "$1" -ge 20 ]; then
   SLEEP=10
fi
if [ "$1" -ge 30 ]; then
   SLEEP=14
fi
if [ "$1" -ge 40 ]; then
   SLEEP=20
fi
if [ "$1" -ge 70 ]; then
   SLEEP=60
fi

chapter "sleep $SLEEP"

chapter "scripts/substrate-insert-keys.py $NUM"

chapter "sleep $SLEEP"
 
chapter "scripts/kill-nodes.sh"

chapter "scripts/purge-chains.sh $NUM"
 
chapter "scripts/start-nodes.sh $NUM"

