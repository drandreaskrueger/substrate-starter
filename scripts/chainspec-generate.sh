# for 4 nodes start this:
#                        chainspec-generate.sh 4
#
# version 0.7
# https://github.com/drandreaskrueger/substrate-starter

# TODO: remove the bootnode ?

source config.sh
checknum $1
# NO settrap because want unmodified return value of $SCRIPTS/subkey_addresses.sh $NUM babe

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
echo swapping out babe and grandpa from that json file, into new file $filename_my_chainspec
# this line is good for debugging as it outputs .genesis.runtime.{babe,grandpa} to stdout:
# jq '.genesis.runtime.babe.authorities='$($SCRIPTS/subkey_addresses.sh $NUM babe) $GENERATED/local.json | jq '.genesis.runtime.grandpa.authorities='$($SCRIPTS/subkey_addresses.sh $NUM grandpa) | jq '.genesis.runtime.grandpa,.genesis.runtime.babe'
# exit
jq '.genesis.runtime.babe.authorities='$($SCRIPTS/subkey_addresses.sh $NUM babe) $GENERATED/local.json | jq '.genesis.runtime.grandpa.authorities='$($SCRIPTS/subkey_addresses.sh $NUM grandpa) > $filename_my_chainspec
wc $filename_my_chainspec

# echo
# echo visual check intermediate file $filename_my_chainspec - here .genesis.runtime.grandpa :
# jq '.genesis.runtime.grandpa' $filename_my_chainspec

echo
filename_my_raw=$GENERATED/$FILESTUB-raw.json
echo transforming that file into "raw" chainspec file $filename_my_raw
node-template build-spec --chain $filename_my_chainspec --raw > $filename_my_raw
wc $filename_my_raw

echo
echo Done. Now start all $NUM nodes, and then insert the above keys into the keystore, and restart nodes.
