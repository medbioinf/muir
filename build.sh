#!/bin/bash

GIT_HASH=$(git rev-parse --short HEAD)

cd docker

for d in */; do
  cd $d
  . container.sh
  dir=$(echo ${d} | rev | cut -c 2- | rev)
  container="quay.io/medbioinf/${dir}"
  container_ver="${container}:${CONTAINER_VERSION}-${GIT_HASH}"
  echo "building ${container}"

  docker build ${CONTAINER_BUILD_ARGS} --platform linux/amd64 -t ${container_ver} -f Dockerfile .
  docker tag ${container_ver} "${container}:latest"

  docker push ${container_ver}
  docker push ${container}:latest

  # if not already, make public
  curl -X POST \
    -H "Authorization: Bearer ${1}" \
    -H "Content-Type: application/json" \
    -d '{
      "visibility": "public"
    }' \
    "https://quay.io/api/v1/repository/medbioinf/${dir}/changevisibility"


  cd ..
done
