# substrate / node-template changes: no more babe keys?

*My scripts to create a 4-nodes-network with my own keys ceased to work.*  

The scripts were done with subkey-v2 and node-template-v2 but an older version.

The problem is that `babe` is now missing from the `build-spec` chainspec.

This is a more verbose than necessary, because I had to work backwards myself, to actually understand where the breaking changes had happened. At the bottom of the issue is my question.

### grandpa

`grandpa` is still there:

```
node-template-2.0.0-7d7e74fb7-x86_64-linux-gnu build-spec --chain local | jq '.genesis.runtime.grandpa'
node-template-2.0.0-8b6fe66-x86_64-linux-gnu build-spec --chain local | jq '.genesis.runtime.grandpa'
```

BOTH result in

```
... Building chain spec
{
  "authorities": [
    [
      "5FA9nQDVg267DEd8m1ZypXLBnvN7SFxYwV7ndqSYGiN9TTpu",
      1
    ],
    [
      "5GoNkf6WdbxCFnPdAnYYQyCjAKPJgLNxXwPjwTh6DGg6gN3E",
      1
    ]
  ]
}
```

### babe

an older `node-template-2.0.0-7d7e74fb7` had `babe` entries:

```
node-template-2.0.0-7d7e74fb7-x86_64-linux-gnu build-spec --chain local | jq '.genesis.runtime.babe'

2020-03-02 00:29:37 Building chain spec
{
  "authorities": [
    [
      "5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY",
      1
    ],
    [
      "5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty",
      1
    ]
  ]
}
```

while the new  `node-template-2.0.0-8b6fe66-x86_64-linux-gnu` has none:

```
node-template-2.0.0-8b6fe66-x86_64-linux-gnu build-spec --chain local | jq '.genesis.runtime.babe'

... Building chain spec
null
```

### backgrounds

Back then, `babe` and `grandpa` Addresses were created like this:

    subkey --sr25519 inspect "tissue change wrap drum deny actor winter tent salmon ahead carbon adjust" | grep "Address"
    subkey --ed25519 inspect "tissue change wrap drum deny actor winter tent salmon ahead carbon adjust" | grep "Address"
    
> SS58 Address:     5CFZ1B2CjYKx96ipWzu4KvR5MFjExLL3TemMXqD32BTbt6Tr  
> SS58 Address:     5HHiES5rmNMDSq3TLaPyL8J9kg3KrspDYxnTc1UYS2m7fGnc  

And for the `author.insertKey('{babe,grandpa}', 'seed', 'publickey')` like this:

    subkey --sr25519 inspect "tissue change wrap drum deny actor winter tent salmon ahead carbon adjust" | grep "Public key"
    subkey --ed25519 inspect "tissue change wrap drum deny actor winter tent salmon ahead carbon adjust" | grep "Public key"

> Public key (hex): 0x0845e5782e683f4cf37094e7e6fb1e881fd1806bcb03189b21e59f4d50ace02e  
> Public key (hex): 0xe7189ee80b9d23f96981344656606a203fcb8ae3c825d54945352366aba0f83a  


---

## Questions:

* So the `babe` consensus has been dropped in a recent v2.0.0 ?
* `subkey` has not changed, right?
* Where is an uptodate manual about all the consensus keys in `2.0.0-8b6fe66`?


The idea for my run-4-nodes-with-own-keys scripting had begun on [this page "Generate your own keys"](https://substrate.dev/docs/en/tutorials/start-a-private-network-with-substrate#generate-your-own-keys) if I remember correctly. Back then I also found some good tutorial page explaining the keys, and the chainspec. 

**Which is the uptodate manual now, which works with `node-template-2.0.0-8b6fe66` ?**

Thanks a lot!

Have a great start into your week.


# issues
this page is now this issue:

* [sdh#477](https://github.com/substrate-developer-hub/substrate-developer-hub.github.io/issues/477) babe no more? Manual for consensus keys? 