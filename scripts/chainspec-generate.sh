# for 4 nodes start this:
#                        chainspec-generate.sh 4
#
# version 0.7
# https://github.com/drandreaskrueger/substrate-starter

# TODO: remove the bootnode ?

source config.sh
checknum $1
# NO settrap because want unmodified return value of $SCRIPTS/subkey_addresses.sh $NUM aura

# echo
# echo make $NUM keys:
# $SCRIPTS/subkey_generate.sh $1

echo 
filename_orig=$GENERATED/$TEMPLATE.json
echo generating from template \'$TEMPLATE\' the file: $filename_orig 
node-template build-spec --chain $TEMPLATE > $filename_orig
wc $filename_orig

echo
filename_my_chainspec=$GENERATED/$FILESTUB.json
echo swapping out aura and grandpa from that json file, into new file $filename_my_chainspec
# this line is good for debugging as it outputs .genesis.runtime.{aura,grandpa} to stdout:
# jq '.genesis.runtime.aura.authorities='$($SCRIPTS/subkey_addresses.sh $NUM aura) $GENERATED/local.json | jq '.genesis.runtime.grandpa.authorities='$($SCRIPTS/subkey_addresses.sh $NUM grandpa) | jq '.genesis.runtime.grandpa,.genesis.runtime.aura'
# exit

# replace aura and grandpa addresses, and remove the hardcoded bootNodes
jq '.genesis.runtime.aura.authorities='$($SCRIPTS/subkey_addresses.sh $NUM aura) $GENERATED/local.json | jq '.genesis.runtime.grandpa.authorities='$($SCRIPTS/subkey_addresses.sh $NUM grandpa) | jq '.bootNodes=[]'   > $filename_my_chainspec
wc $filename_my_chainspec

# echo
# echo visual check intermediate file $filename_my_chainspec - here .genesis.runtime.grandpa :
# jq '.genesis.runtime.grandpa' $filename_my_chainspec

echo
filename_my_raw=$GENERATED/$FILESTUB-raw.json
echo transforming that file into "raw" chainspec file $filename_my_raw
# remove the hardcoded bootNodes again:
node-template build-spec --chain $filename_my_chainspec --raw | jq '.bootNodes=[]' > $filename_my_raw
wc $filename_my_raw

echo
echo Done. Now start all $NUM nodes, and then insert the above keys into the keystore, and restart nodes.
