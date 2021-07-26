#!/bin/bash
set -xe

sudo apt update
sudo apt install -y curl wireguard python3

mkdir -p local

mkdir -p bin
cd bin
curl -vL https://github.com/wangyu-/udp2raw-tunnel/releases/download/20200818.0/udp2raw_binaries.tar.gz -o udp2raw.tgz

tar -xvzf udp2raw.tgz udp2raw_amd64
chmod +x udp2raw_amd64
rm udp2raw.tgz

curl -vL https://github.com/wangyu-/UDPspeeder/releases/download/20210116.0/speederv2_binaries.tar.gz -o udpspeeder.tgz
tar -xvzf udpspeeder.tgz speederv2_amd64
chmod +x speederv2_amd64
rm udpspeeder.tgz

cd ..

VERIFIED_HASH="a7ce38b2c30980be4e71c3af8a9c1db8183db349c699fa6f843e67add7e6cca2"
TEMP_HASH=$(sha256sum bin/udp2raw_amd64 | awk '{print $1}')
if [ "$TEMP_HASH" == "$VERIFIED_HASH" ]
then
    echo "[OK] udp2raw hash match: $TEMP_HASH"
else
    echo "[WARN] udp2raw hash mismatch: $TEMP_HASH. Expected: $VERIFIED_HASH"
fi

VERIFIED_HASH="3cf8f6c1e9baa530170368efb8a4bfcd6e75f88c2726ecbf2a75261dd1dd9fd5"
TEMP_HASH=$(sha256sum bin/speederv2_amd64 | awk '{print $1}')
if [ "$TEMP_HASH" == "$VERIFIED_HASH" ]
then
    echo "[OK] speederv2 hash match: $TEMP_HASH"
else
    echo "[WARN] speederv2 hash mismatch: $TEMP_HASH. Expected: $VERIFIED_HASH"
fi
