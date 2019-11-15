# substrate-starter v0.1

arbitrary number of interconnected substrate nodes, incl key generation, chainspec, etc.

## entry points
main scripts, what they do, and how often you need them:

* [start.sh](start.sh): substrate-starter (often)
* [config.sh](config.sh): paths, definitions, etc (seldom/never)
* [init.sh](init.sh) : install, compile, etc (once)

## TODO:
Dockerize:

* Debian based
* run init.sh
* entrypoint start.sh
* map ports 30333, 9944, 9933 of the bootnode

