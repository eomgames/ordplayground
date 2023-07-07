This was heavily based on: https://github.com/vnprc/dockord

## Build and start the docker cloud

```
docker-compose build --no-cache
docker-compose up -d bitcoind
```

### I wait a min for bitcoind to start up then run

```
docker-compose up -d ord
```

This will start ord service (container), generate some address, some btc, then inscribe `/ordinals/keep_going.png` and then mine it.
Since you are on regtest you need to mine the transactions yourself.

## Open the ORD explorer

http://localhost:8080

## Inscribing

This process uses a mount in `/ordinals/projects`. You would put your files inside of it, use `docker-compose run ord bash` to start a container to do the inscribing process.

### start an individual docker insatnce

```
docker-compose run ord bash
```

### hop into a running docker container bash shell

```
docker exec -it dockord-ord-1 bash
```

### 1. create a regtest ord wallet

```
ord wallet create
```

### Optional - do a bitcoind health check

```
bitcoin-cli --rpcconnect=bitcoind --rpcport=8332 --rpccookiefile=/bitcoin/.bitcoin/regtest/.cookie getblockcount
```

### 2. Generate 101 blocks to address, you'll need this

```
bitcoin-cli --rpcconnect=bitcoind --rpcport=8332 --rpccookiefile=/bitcoin/.bitcoin/regtest/.cookie generatetoaddress 101 bcrt1paw2gyzatqtccenymqfxfrxx4fn235v3sfxvs7sqe7dlcm0raqwwsp0ul80
```

### 3. Create a wallet & get it some sweet BTC

```
ord wallet create && get a receive address
ADDRESS=$(ord wallet receive 2>/dev/null | grep -o -E "\"address\": \"[^\"]+\"" | sed -E "s/\"address\": \"(.*)\"/\1/")
bitcoin-cli --rpcconnect=bitcoind --rpcport=8332 --rpccookiefile=/bitcoin/.bitcoin/regtest/.cookie generatetoaddress 101 $ADDRESS
```

### 4. Create your ord indxe

```
ord index run
```

### 5. Now inscribe file

```
/ordinals/ord -r --cookie-file /bitcoin/.bitcoin/regtest/.cookie --rpc-url http://bitcoind:8332 wallet inscribe --fee-rate 1 /ordinals/keep_going.png
```

### 6. Mine that transaction (have to b/c you on REGTEST)

```
bitcoin-cli --rpcconnect=bitcoind --rpcport=8332 --rpccookiefile=/bitcoin/.bitcoin/regtest/.cookie generatetoaddress 1 $ADDRESS
```
