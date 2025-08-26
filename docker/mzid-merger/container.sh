#!/bin/bash

export CONTAINER_VERSION=1.4.26

DOWNLOAD_URL="https://github.com/PNNL-Comp-Mass-Spec/MzidMerger/releases/download/v1.4.26/MzidMerger.zip"
export CONTAINER_BUILD_ARGS="--build-arg DOWNLOAD_URL=${DOWNLOAD_URL}"
