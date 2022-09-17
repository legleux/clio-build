#!/usr/bin/env bash

TAG=$1
docker build . --target deps -t clio-deps:$TAG
docker build . --target builder -t clio-builder:$TAG
# docker build . --target clio -t clio --label=$TAG
