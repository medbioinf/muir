#!/bin/bash

cd docker

for d in */; do
  cd $d
  . container.sh
  dir=$(echo ${d} | rev | cut -c 2- | rev)
  container_tag="quay.io/medbioinf/${dir}:${CONTAINER_VERSION}"
  echo "building ${container_tag}"

  docker buildx build --file Dockerfile \
    --label org.opencontainers.image.description=${CONTAINER_DESCRIPTION} \
    --label org.opencontainers.image.title=${CONTAINER_DESCRIPTION} \
    --tag ${container_tag} .

  docker push ${container_tag}

  cd ..
done
