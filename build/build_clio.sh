#!/usr/bin/env bash

export SRC_DIR=$(realpath clio_src)
echo "[${SRC_DIR}] passed to Clio repo as SRC_DIR"

cmake -S clio_ci -B clio_ci/build -DSRC_DIR=$SRC_DIR
cmake --build clio_ci/build --parallel $(nproc) | tee -a clio_build.log

ls -lh .

echo "ls -lh clio_ci/build"
ls -lh clio_ci/build

echo "ls -lh ./clio_ci/build"
ls -lh ./clio_ci/build

echo "ls -lh ./clio_ci/build/clio-prefix/src/clio-build"
ls -lh ./clio_ci/build/clio-prefix/src/clio-build/

cp ./clio_ci/build/clio-prefix/src/clio-build/clio_tests .
