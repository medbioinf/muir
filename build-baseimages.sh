#!/bin/bash

cd docker-bases

for d in "alpine-bash" "eclipse-temurin-alpine-bash"; do
  cd $d
  . container.sh
  dir=$(echo ${d} | rev | cut -c 1- | rev)
  container="quay.io/medbioinf/${dir}"
  container_ver="${container}:${CONTAINER_VERSION}"
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
