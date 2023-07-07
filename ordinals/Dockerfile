FROM frolvlad/alpine-glibc

RUN apk add --no-cache curl bash

SHELL ["/bin/bash", "-c"]

EXPOSE 8080

WORKDIR /ordinals
# I rotate between using gmart7t2/ord and ordinals/ord
# ADD https://github.com/ordinals/ord/releases/download/0.8.0/ord-0.8.0-x86_64-unknown-linux-gnu.tar.gz /ordinals/ord.tar.gz
ADD https://github.com/gmart7t2/ord/releases/download/0.7.0-gm2/ord-0.7.0-gm2-x86_64-unknown-linux-gnu.tar.gz /ordinals/ord.tar.gz
RUN tar -zxvf ord.tar.gz

RUN chmod +x /ordinals/ord
RUN ls -la
ENV RUST_LOG=debug
# ENV PATH="/ordinals:$PATH"

ADD https://bitcoincore.org/bin/bitcoin-core-24.0.1/bitcoin-24.0.1-x86_64-linux-gnu.tar.gz /bitcoin/bitcoin.tar.gz
RUN tar -zxvf /bitcoin/bitcoin.tar.gz
RUN mv bitcoin-24.0.1/bin/bitcoin-cli /usr/local/bin

RUN touch /root/.bashrc
RUN echo "alias ord='/ordinals/ord -r --cookie-file /bitcoin/.bitcoin/regtest/.cookie --rpc-url http://bitcoind:8332/ \$@'" >> /root/.bashrc

CMD ["init.sh"]
