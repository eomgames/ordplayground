This was heavily based on: https://github.com/vnprc/dockord

## Youtube demo

https://www.youtube.com/watch?v=cVc8cL_JrnI

## Build and start the docker cloud

```
docker-compose build --no-cache
docker-compose up -d
```

This will start the bitcoind and ord service containers. Then using `init.sh` in the ord container, it will generate some addresses, some btc, then inscribe `/ordinals/keep_going.png` and then mine it.
Since you are on regtest you need to mine the transactions yourself.

## Open the ORD explorer

http://localhost:8080

## The Inscribing Process

This process uses a mount in `./ordinals/projects`. You would put your files inside of it, use `docker-compose run ord bash` to start a container to do the inscribing process.

### 1. Start an individual docker instance

```
docker-compose run ord bash
```

### 2. Create a wallet & get it some sweet BTC

This will create a wallet then generate 101 blocks: Further reading for 101 block: https://github.com/BlockchainCommons/Learning-Bitcoin-from-the-Command-Line/blob/8598756ae138608b21082d210f4f638a4507c67d/A3_0_Using_Bitcoin_Regtest.md#generate-blocks

```
ord wallet create
ADDRESS=$(ord wallet receive 2>/dev/null | grep -o -E "\"address\": \"[^\"]+\"" | sed -E "s/\"address\": \"(.*)\"/\1/")
bitcoin-cli --rpcconnect=bitcoind --rpcport=8332 --rpccookiefile=/bitcoin/.bitcoin/regtest/.cookie generatetoaddress 101 $ADDRESS
```

### 3. Create your ord index

```
ord index run
```

### 4. Now inscribe file

```
ord wallet inscribe --fee-rate 1 /ordinals/keep_going.png
```

### 5. Mine that transaction (have to b/c you on REGTEST)

```
bitcoin-cli --rpcconnect=bitcoind --rpcport=8332 --rpccookiefile=/bitcoin/.bitcoin/regtest/.cookie generatetoaddress 1 $ADDRESS
```

Now you should be able to look in your local explorer at http://localhost:8080 and see the inscription.
