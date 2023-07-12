# Great idea from:
# https://gist.github.com/System-Glitch/cb4e87bf1ae3fec9925725bb3ebe223a
# Script to generate a new block every minute
# Put this script at the root of your unpacked folder
#!/bin/bash

echo "Generating a block every minute. Press [CTRL+C] to stop.."


address=`bitcoin-cli --rpcconnect=bitcoind --rpcport=8332 --rpccookiefile=/bitcoin/.bitcoin/regtest/.cookie getnewaddress`

while :
do
        echo "Generate a new block `date '+%d/%m/%Y %H:%M:%S'`"
        bitcoin-cli --rpcconnect=bitcoind --rpcport=8332 --rpccookiefile=/bitcoin/.bitcoin/regtest/.cookie  generatetoaddress 1 $address

        sleep 60
done