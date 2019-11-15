# for 4 nodes start this:
#                        start-nodes.sh 4
#
# version 0.7
# https://github.com/drandreaskrueger/substrate-starter

source config.sh
checknum $1
settrap

echo
echo Starting network with $NUM interconnected nodes
echo 
echo common configuration:
echo $CONFIG
echo 


echo ..... Node 01
name=$FILESTUB"-node-01"
logfile=$LOGFILES/$name".log"
port=$PORT_P2P
rpcport=$PORT_RPC
wsport=$PORT_WS
# echo $name $port $rpcport $wsport $logfile
 
echo $SUBSTRATE --name $name --port $port --rpc-port $rpcport --ws-port $wsport --base-path $BASEPATH/$name $CONFIG
$SUBSTRATE --name $name --port $port --rpc-port $rpcport --ws-port $wsport --base-path $BASEPATH/$name $CONFIG > $logfile  2>&1 &

printf "sleep 2 seconds so that the first node has output its identity for sure ... "
sleep 2

identity=$(cat $logfile | grep "Local node identity is" | awk '{print $7 }')
if [ -z $identity ]; then
    echo something is wrong with the first node, check the log file
    echo less $logfile
    exit 126
fi

bootnode=/ip4/127.0.0.1/tcp/30333/p2p/$identity
echo bootnode: $bootnode

echo 
logfiles=$logfile" "

for (( i=2; i<$NUM+1; i++ ));
do
    echo ..... Node 0$i .....
    port=$(($PORT_P2P-1+i))
    rpcport=$(($PORT_RPC-1+i))
    wsport=$(($PORT_WS-1+i))
    name=$FILESTUB"-node-0"$i
    logfile=$LOGFILES/$name".log"
    # echo $name $port $rpcport $wsport $logfile
    echo $SUBSTRATE --name $name --port $port --rpc-port $rpcport --ws-port $wsport --base-path $BASEPATH/$name $CONFIG --bootnodes $bootnode 
    $SUBSTRATE --name $name --port $port --rpc-port $rpcport --ws-port $wsport --base-path $BASEPATH/$name $CONFIG --bootnodes $bootnode > $logfile  2>&1 &
    logfiles+="$logfile "
done

echo
echo ..... Done .....
echo
echo Now insert the babe and grandpa keys. And watch the logs with:
echo tail -f "$logfiles"
echo
echo Show all processes, so you can kill them:
echo "ps aux | grep $SUBSTRATE | grep -v grep"

