#!/bin/bash

export CONTAINER_VERSION=v2025.02.0

DOWNLOAD_URL=https://github.com/UWPR/Comet/releases/download/${CONTAINER_VERSION}/comet.linux.exe

export CONTAINER_BUILD_ARGS="--build-arg DOWNLOAD_URL=${DOWNLOAD_URL}"