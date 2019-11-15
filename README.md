# substrate-starter v0.2

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

## Alice Bob Charlie Dave
The built-in keys allow a simple local network too:
```
scripts/ABCD_start-4-nodes.sh
tail -f logs/ABCD_alice.log logs/ABCD_bob.log logs/ABCD_charlie.log logs/ABCD_dave.log
sudo pkill node-template
scripts/ABCD_purge-4-chains.sh
```
Esp. if you are new to this, that approach is easiest to understand. But no control over keys, chainspec, etc.