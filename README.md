# substrate-starter v0.8

arbitrary number of interconnected substrate nodes, incl key generation, chainspec, etc.

## entry points
main scripts, what they do, and how often you need them:

* [start.sh](start.sh): substrate-starter (often)
* [config.sh](config.sh): paths, definitions, etc (seldom/never)
* [init.sh](init.sh) : install, compile, etc (once)

### dependencies

Python library needed:

    pip3 install websockets

This new script collection v0.3 doesn't work with older node-template / substrate anymore; they swapped `babe` for `aura`, and that results in slight changes to the chainspec format. So use these node versions:

* [node-template 8b6fe6666d](https://github.com/substrate-developer-hub/substrate-node-template/tree/8b6fe6666d589486dd541663a32ffd98f2e21d74)
* (which is on the basis of [substrate 3e651110a](https://github.com/paritytech/substrate/tree/3e651110aa06aa835790df63410a29676243fc54))

### how to start

    ./start.sh 3
    
Then read everything. If errors, then fix from the top. The slightest error anywhere will cause it to fail later, for sure.

    ps aux | grep node-template
    pkill node-template
    
more infos given at the end of the script. Especially note the

> And watch the logs with: ...

## TODO:
Extend to [more than 9 nodes](https://gitlab.com/andreaskrueger/substrate-starter/-/blob/e6ea5bbdb278d2a2dfa682595f10a7944611f84e/config.sh#L49-56) by using wider IP port intervalls.

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
pkill node-template
scripts/ABCD_purge-4-chains.sh
```
Esp. if you are new to this, that approach is easiest to understand. But no control over keys, chainspec, etc. And it looks as if always only Alice and Bob are taking turns in authoring blocks ("Starting consensus session on top of parent ..."), while Charlie and Dave always only sync ("Imported ..."):

```
tail -f logs/ABCD_charlie.log logs/ABCD_dave.log
tail -f logs/ABCD_alice.log logs/ABCD_bob.log
```