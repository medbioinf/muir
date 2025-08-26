#!/bin/bash

export CONTAINER_VERSION=0.0.1

DOWNLOAD_URL=https://github.com/Noble-Lab/FDRBench/releases/download/v${CONTAINER_VERSION}/fdrbench-${CONTAINER_VERSION}.zip

export CONTAINER_BUILD_ARGS="--build-arg CONTAINER_VERSION=${CONTAINER_VERSION} --build-arg DOWNLOAD_URL=${DOWNLOAD_URL}"
