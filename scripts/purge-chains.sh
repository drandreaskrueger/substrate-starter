# for 4 nodes start this:
#                        purge-chains.sh 4
#
# version 0.7
# https://github.com/drandreaskrueger/substrate-starter

source config.sh
checknum $1
settrap

echo
echo Be aware this might cause problems if nodes are still running.
echo

for (( i=1; i<$NUM+1; i++ ));
do
    name=$FILESTUB"-node-0"$i
    echo node-template purge-chain -y --chain=$CHAIN --base-path $BASEPATH/$name
    node-template purge-chain -y --chain=$CHAIN --base-path $BASEPATH/$name
done

echo
echo see the remaining folders and files, e.g. keystore with
echo "ls -Rl $BASEPATH/$FILESTUB-*"
