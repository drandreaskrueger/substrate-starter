#!/bin/bash
#
# start this with:
#                 sudo pkill node-template; scripts/ABCD_purge-4-chains.sh
#
# version v0.2
# https://github.com/drandreaskrueger/substrate-starter
#

SUBSTRATE=node-template
BASEPATH=/tmp/ABCD

echo Be aware this might cause problems if nodes are still running.
echo
$SUBSTRATE purge-chain -y --chain=local --base-path $BASEPATH/alice
$SUBSTRATE purge-chain -y --chain=local --base-path $BASEPATH/bob
$SUBSTRATE purge-chain -y --chain=local --base-path $BASEPATH/charlie
$SUBSTRATE purge-chain -y --chain=local --base-path $BASEPATH/dave

