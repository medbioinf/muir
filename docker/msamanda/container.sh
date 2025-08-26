#!/bin/bash

export CONTAINER_VERSION=3.0.22.071

MSAMANDA_VERSION=$CONTAINER_VERSION
DOWNLOAD_URL="https://ms.imp.ac.at/index.php?file=msamanda/MSAmanda_Linux_${MSAMANDA_VERSION}.tar.gz"

export CONTAINER_BUILD_ARGS="--build-arg DOWNLOAD_URL=${DOWNLOAD_URL}"
