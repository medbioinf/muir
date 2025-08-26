#!/bin/sh

export CONTAINER_VERSION=v0.15.0-beta.1

SAGE_VERSION=$CONTAINER_VERSION

DOWNLOAD_URL="https://github.com/lazear/sage/releases/download/${SAGE_VERSION}/sage-${SAGE_VERSION}-x86_64-unknown-linux-musl.tar.gz"
export CONTAINER_BUILD_ARGS="--build-arg SAGE_VERSION=${SAGE_VERSION} --build-arg DOWNLOAD_URL=${DOWNLOAD_URL}"
