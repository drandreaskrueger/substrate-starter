#!/bin/bash

# the whole thing: generate keys, modify chainspec, start nodes, insertKeys

source config.sh
checknum $1

chapter "echo substrate-starter $VERSION"

chapter "scripts/subkey_generate.sh $NUM"

chapter "scripts/chainspec-generate.sh $NUM"

chapter "scripts/kill-nodes.sh"

chapter "scripts/start-nodes.sh $NUM"

chapter "sleep 3"

chapter "scripts/substrate-insert-keys.py $NUM"

chapter "sleep 3"
 
chapter "scripts/kill-nodes.sh"

chapter "scripts/purge-chains.sh $NUM"
 
chapter "scripts/start-nodes.sh $NUM"

