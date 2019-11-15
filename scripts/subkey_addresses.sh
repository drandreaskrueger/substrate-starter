# start this with:
#                  scripts/subkey_addresses.sh 4
#
# json list of generated addresses, for inserting into my own chainspec, with jq
#
# version 0.7
# https://github.com/drandreaskrueger/substrate-starter

source config.sh
checknum $1

if [ "$2" = "babe" ]; then
    CRYPTOGRAPHY=--sr25519
fi
if [ "$2" = "grandpa" ]; then
    CRYPTOGRAPHY=--ed25519
fi

if [ -z "$CRYPTOGRAPHY" ]; then
    echo "must specify babe or grandpa as 2nd arg"
    exit
fi

printf "["
for (( i=1; i<$NUM+1; i++ ));
do
    filename=$GENERATED/seed$i.secret
    secret=$(cat $filename) 
    address=$(subkey $CRYPTOGRAPHY inspect "$secret" | grep "Address" | awk '{ printf $3 }')
    printf "["\"$address\"",1]"
    if [ "$i" -ne "$NUM" ]
    then
        printf ","
    fi
done
printf "]"
