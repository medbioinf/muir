#!/bin/bash

export CONTAINER_VERSION=2.6.3.0

DOWNLOAD_URL="https://gitlab.ruhr-uni-bochum.de/uszkojy2/maxquant-distributables/-/raw/main/v${CONTAINER_VERSION}/MaxQuant_v${CONTAINER_VERSION}.zip"
export CONTAINER_BUILD_ARGS="--build-arg DOWNLOAD_URL=${DOWNLOAD_URL}"
