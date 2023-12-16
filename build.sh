#!/usr/bin/env bash
set -x

test -e /usr/local/go/bin/go || curl -vskSL https://go.dev/dl/go1.21.5.linux-amd64.tar.gz | tar -C /usr/local/ -xvzf -
which go || export PATH=/usr/local/go/bin:$PATH
sed -i '/go test -v/d' Dockerfile

make build-docker

docker tag ghcr.io/openfaas/faas-netes:latest cloorc/faas-netes:0.17.4

echo "Login to docker hub to push image:"
docker login -u cloorc --password-stdin && docker push cloorc/faas-netes:0.17.4
