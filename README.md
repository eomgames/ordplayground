This was heavily based on: https://github.com/vnprc/dockord

## Build and start the docker cloud

```
docker compose build --no-cache
docker compose up bitcoind -d
```

### I wait a min for bitcoind to start up then run

```
docker compose up ord -d
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

### create a regtest ord wallet

```
ord -r --cookie-file /bitcoin/.bitcoin/regtest/.cookie --rpc-url http://bitcoind:8332/ wallet create
```

### bitcoind health check

```
bitcoin-cli --rpcconnect=bitcoind --rpcport=8332 --rpccookiefile=/bitcoin/.bitcoin/regtest/.cookie getblockcount
```

### generate 101 blocks to address

```
bitcoin-cli --rpcconnect=bitcoind --rpcport=8332 --rpccookiefile=/bitcoin/.bitcoin/regtest/.cookie generatetoaddress 101 bcrt1paw2gyzatqtccenymqfxfrxx4fn235v3sfxvs7sqe7dlcm0raqwwsp0ul80
```
