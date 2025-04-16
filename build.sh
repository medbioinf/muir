#!/bin/bash

cd docker

for d in */; do
  cd $d
  . container.sh
  dir=$(echo ${d} | rev | cut -c 2- | rev)
  container="quay.io/medbioinf/${dir}"
  container_ver="${container}:${CONTAINER_VERSION}"
  echo "building ${container}"

  docker build -t ${container_ver} -f Dockerfile .
  docker tag ${container_ver} "${container}:latest"

  docker push -a ${container}

  # if not already, make public
  curl -v -X POST \
    -H "Authorization: Bearer ${1}" \
    -H "Content-Type: application/json" \
    -d '{
      "visibility": "public"
    }' \
    "https://quay.io/api/v1/repository/medbioinf/${dir}/changevisibility"


  cd ..
done
