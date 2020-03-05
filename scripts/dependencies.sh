# 
#     dependencies.sh
#
# version 0.91
# https://github.com/drandreaskrueger/substrate-starter

source config.sh
# settrap

echo
echo preparing system:
echo 
echo ...   Python virtualenv
echo ...     upgrade pip3
echo ...     install websockets library
echo 
echo 

set -x
rm -rf env 
python3 -m venv env
echo

set +x
echo +++ source env/bin/activate
source env/bin/activate
echo

set -x
python3 -m pip install pip==20.0.2
echo 

python3 -m pip install websockets
echo
set +x
