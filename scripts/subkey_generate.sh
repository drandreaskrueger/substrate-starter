# start this with:
#                  scripts/subkey_generate.sh 4
#
# version 0.7
# https://github.com/drandreaskrueger/substrate-starter

source config.sh
checknum $1
settrap

# easier to store & recall in bash arrays when using no spaces, instead use hyphens
hyphened2seed (){
    seed=$(echo $1 | sed -r 's/-/ /g' ) # turns the hyphens back into spaces
}

echo generating $NUM seed phrases:
echo
SEEDPHRASES=()
for (( i=1; i<$NUM+1; i++ ));
do
	phrase=$(subkey generate | grep "Secret phrase"  | sed -r 's/`//g' ) # remove the strange `
	phrase=$(echo $phrase | awk '{ print $3 "-" $4 "-" $5 "-" $6 "-" $7 "-" $8 "-" $9 "-" $10 "-" $11 "-" $12 "-" $13 "-" $14 }')
	hyphened2seed $phrase
	echo "$seed"
	SEEDPHRASES+=( $phrase )
done


echo
echo writing secretphrases into files:
echo
for (( i=1; i<$NUM+1; i++ ));
do
    filename=$GENERATED/seed$i.secret
    hyphened2seed ${SEEDPHRASES[$i-1]}
    echo $seed > $filename
    echo $i $filename
done

echo
echo babe and grandpa ADDRESSES for replacing the section in the chainspec.json:
echo
echo "\"babe\"": {"\"authorities\"": [
for (( i=1; i<$NUM+1; i++ ));
do
    hyphened2seed ${SEEDPHRASES[$i-1]}
	address=$(subkey --sr25519 inspect "$seed" | grep "Address" | awk '{ print $3 }')
	printf "["\"$address\"", 1]"
	if [ "$i" -ne "$NUM" ]
	then
		printf ","
	fi
	echo
done
echo ]},

echo "\"grandpa\"": {"\"authorities\"": [
for (( i=1; i<$NUM+1; i++ ));
do
    hyphened2seed ${SEEDPHRASES[$i-1]}
	address=$(subkey --ed25519 inspect "$seed" | grep "Address" | awk '{ print $3 }')
	printf "["\"$address\"", 1]"
	if [ "$i" -ne "$NUM" ]
	then
		printf ","
	fi
	echo
done
echo ]},

echo
echo insert these into keystores, beware: 2 validators running with SAME key, will get you slashed.
echo
for (( i=1; i<$NUM+1; i++ ));
do
    suri=${SEEDPHRASES[$i-1]}
    hyphened2seed $suri
    pubkey_sr25519=$(subkey --sr25519 inspect "$seed" | grep "Public key" | awk '{ print $4 }')
    pubkey_ed25519=$(subkey --ed25519 inspect "$seed" | grep "Public key" | awk '{ print $4 }')
    filename=$GENERATED/seed$i.babegran
    echo $pubkey_sr25519 > $filename
    echo $pubkey_ed25519 >> $filename
    echo $filename
    echo author.insertKey\(\"babe\",\"$seed\",\"$pubkey_sr25519\"\)
    echo author.insertKey\(\"gran\",\"$seed\",\"$pubkey_ed25519\"\)
done

