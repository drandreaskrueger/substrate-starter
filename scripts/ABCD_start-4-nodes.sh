#!/bin/bash
#
# start this with:
#                 scripts/ABCD_start-4-nodes.sh
#
# version v0.2
#

SUBSTRATE=node-template
LOGFOLDER=logs
LOGFILE=$LOGFOLDER/ABCD
BASEPATH=/tmp/ABCD

mkdir -p $BASEPATH
mkdir -p $LOGFOLDER

# Alice
$SUBSTRATE  --telemetry-url ws://telemetry.polkadot.io:1024  \
            --node-key 0000000000000000000000000000000000000000000000000000000000000001 \
            --validator --chain=local \
	        --alice --base-path $BASEPATH/alice > $LOGFILE"_alice.log" 2>&1 &

ALICE=/ip4/127.0.0.1/tcp/30333/p2p/QmRpheLN4JWdAnY7HGJfWFNbfkQCb6tFf4vvA6hgjMZKrR

# Bob
$SUBSTRATE  --telemetry-url ws://telemetry.polkadot.io:1024 \
            --chain=local  --validator --bootnodes $ALICE \
            --bob --base-path $BASEPATH/bob --port 30334 > $LOGFILE"_bob.log" 2>&1 &

# Charlie
$SUBSTRATE  --telemetry-url ws://telemetry.polkadot.io:1024 \
            --chain=local  --validator --bootnodes $ALICE \
            --charlie --base-path $BASEPATH/charlie --port 30335 > $LOGFILE"_charlie.log" 2>&1 &

# Dave
$SUBSTRATE  --telemetry-url ws://telemetry.polkadot.io:1024 \
            --chain=local  --validator --bootnodes $ALICE \
            --dave --base-path $BASEPATH/dave --port 30336 > $LOGFILE"_dave.log" 2>&1 &

# Log files:
echo
echo the 4 nodes should be started now
echo
echo watch their logs with this:
echo tail -f $LOGFILE"_alice.log" $LOGFILE"_bob.log" $LOGFILE"_charlie.log" $LOGFILE"_dave.log"
echo
echo show all processes, so you can kill them:
echo "ps aux | grep $SUBSTRATE | grep -v grep"

