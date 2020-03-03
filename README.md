# substrate-starter v0.9

arbitrary number of interconnected substrate nodes, incl key generation, chainspec, etc.

## entry points
main scripts, what they do, and how often you need them:

* [start.sh](start.sh): substrate-starter (often)
* [config.sh](config.sh): paths, definitions, etc (seldom/never)
* [init.sh](init.sh) : install, compile, etc (once)

### dependencies

Python library needed:

    pip3 install websockets

This new 2020 script collection does NOT work with older node-template / substrate anymore; they swapped `babe` for `aura`, and that results in slight changes to the chainspec format. So use this node version: [node-template 8b6fe6666d](https://github.com/substrate-developer-hub/substrate-node-template/tree/8b6fe6666d589486dd541663a32ffd98f2e21d74) (which is on the basis of [substrate 3e651110a](https://github.com/paritytech/substrate/tree/3e651110aa06aa835790df63410a29676243fc54)).

Work through the [installation manual](https://substrate.dev/docs/en/overview/getting-started) so that these are available on the `$PATH`:

    node-template --version; subkey --version
    
> node-template 2.0.0-8b6fe66-x86_64-linux-gnu  
> subkey 2.0.0  


### how to start

    ./start.sh 3
    
Then read everything. If errors, then fix from the top. The slightest error anywhere will cause it to fail later, for sure.

    ps aux | grep node-template
    pkill node-template
    
more infos given at the end of the script. Especially note the

> And watch the logs with: ...

## Memory
I have tested with increasing number of nodes:

| number of interconnected nodes | Total memory used | memory per node in MB |
|--------------------------------|-------------------|-----------------------|
| 10                             | 833               | 83                    |
| 20                             | 1692              | 85                    |
| 30                             | 2579              | 86                    |
| 40                             | 3595              | 90                    |
| 50                             | 4697              | 94                    |
| 80                             | 8518              | 106                   |
| 99                             | 11015             | 111                   |

Stability: 30 nodes, on a 2018 Laptop, run just fine. No error message whatsoever. And mostly `(29 peers)`!  

However when starting larger numbers of nodes (on a too small machine), checking the log files, you will see error messages like these:

* Handler initialization process is too long with PeerId("QmRvr...")
* Polling the network future took 35s
* Essential task failed. Shutting down service.

Especially the last one probably means that also the memory measurements become incorrect then? All this could be fixed somehow probably, but I don't care enough.

To start that many nodes on one machine is a rather academic extreme case anyways. It does NOT make sense to start more than a couple of nodes. But for that - these scripts are very useful, right?


## TODO:
Installation script `./init.sh` to prepare a fresh machine. For now, just install `node-template` and `subkey` manually, please.

When starting 55 nodes or more (lol), the port 9955 is taken already.  

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

## Credits
![logo grants badge](img/web3_foundation_grants_badge_black_smaller.png)

This little side project for adapting [chainhammer](https://github.com/drandreaskrueger/chainhammer) to substrate was financed by the web3foundation.