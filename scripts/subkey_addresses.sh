# start this with:
#                  scripts/subkey_addresses.sh 4
#
# json list of generated addresses, for inserting into my own chainspec, with jq
#
# version 0.7
# https://github.com/drandreaskrueger/substrate-starter

source config.sh
checknum $1

if [ "$2" = "aura" ]; then
    CRYPTOGRAPHY=--sr25519
    PERHAPS_BEGIN_LIST=""
    PERHAPS_ADD_ONE=""
fi
if [ "$2" = "grandpa" ]; then
    CRYPTOGRAPHY=--ed25519
    PERHAPS_BEGIN_LIST="["
    PERHAPS_ADD_ONE=",1]"
fi

if [ -z "$CRYPTOGRAPHY" ]; then
    echo "must specify aura or grandpa as 2nd arg"
    exit
fi

printf "["
for (( i=1; i<$NUM+1; i++ ));
do
    filename=$GENERATED/seed$i.secret
    secret=$(cat $filename) 
    address=$(subkey $CRYPTOGRAPHY inspect "$secret" | grep "Address" | awk '{ printf $3 }')
    printf $PERHAPS_BEGIN_LIST\"$address\"$PERHAPS_ADD_ONE
    if [ "$i" -ne "$NUM" ]
    then
        printf ","
    fi
done
printf "]"
