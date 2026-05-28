#!/bin/bash
# Selective Docker build script
# Only builds containers whose source files have changed since the given commit.
#
# Usage:
#   ./build-selective.sh <quay_api_key> [base_commit]
#
# If base_commit is not provided, defaults to HEAD~1.
# If running in GitHub Actions on a merge/PR, uses the merge base.
# Pass --all to build everything (fallback behavior).

set -eo pipefail

QUAY_API_KEY="${1:-}"
BASE_COMMIT="${2:-}"

# If --all is passed as base commit, build everything
BUILD_ALL=false
if [[ "${BASE_COMMIT:-}" == "--all" ]]; then
  BUILD_ALL=true
fi

# Determine base commit for comparison
if [[ "$BUILD_ALL" != "true" && -z "$BASE_COMMIT" ]]; then
  if [[ -n "${GITHUB_SHA:-}" && -n "${GITHUB_EVENT_BEFORE:-}" ]]; then
    # GitHub Actions: compare against the commit before the push
    BASE_COMMIT="${GITHUB_EVENT_BEFORE}"
  elif git rev-parse HEAD~1 >/dev/null 2>&1; then
    BASE_COMMIT="HEAD~1"
  else
    # No previous commit available, build all
    BUILD_ALL=true
  fi
fi

# Track which base images need rebuilding
BASE_IMAGES_CHANGED=false

###############################################
# Helper: check if any file in a directory changed
###############################################
dir_changed() {
  local dir="$1"
  if [[ "$BUILD_ALL" == "true" ]]; then
    return 0
  fi
  git diff --name-only "$BASE_COMMIT" HEAD 2>/dev/null | grep -q "^${dir}/"
}

###############################################
# Helper: build and push a single container
###############################################
build_container() {
  local dir="$1"
  local container_name="$2"

  cd "$dir"
  . container.sh
  container="quay.io/medbioinf/${container_name}"
  container_ver="${container}:${CONTAINER_VERSION}"
  echo "=== Building ${container_ver} ==="

  docker build ${CONTAINER_BUILD_ARGS:-} --platform linux/amd64 -t ${container_ver} -f Dockerfile .
  docker tag ${container_ver} "${container}:latest"

  docker push ${container_ver}
  docker push ${container}:latest

  # Make public
  curl -s -X POST \
    -H "Authorization: Bearer ${QUAY_API_KEY}" \
    -H "Content-Type: application/json" \
    -d '{"visibility": "public"}' \
    "https://quay.io/api/v1/repository/medbioinf/${container_name}/changevisibility"

  cd ..
  echo "=== Done: ${container_ver} ==="
}

###############################################
# Build base images
###############################################
echo "========================================="
echo "Checking base images..."
echo "========================================="

cd docker-bases
for d in */; do
  dir_name=$(echo "${d}" | tr -d '/')
  if [[ "$BUILD_ALL" == "true" || $(dir_changed "docker-bases/${dir_name}") == 0 ]]; then
    BASE_IMAGES_CHANGED=true
    echo "Base image '${dir_name}' changed (or building all). Building..."
    cd "$dir_name"
    . container.sh
    container="quay.io/medbioinf/${dir_name}"
    container_ver="${container}:${CONTAINER_VERSION}"
    echo "=== Building base image ${container_ver} ==="

    docker build ${CONTAINER_BUILD_ARGS:-} --platform linux/amd64 -t ${container_ver} -f Dockerfile .
    docker tag ${container_ver} "${container}:latest"

    docker push ${container_ver}
    docker push ${container}:latest

    curl -s -X POST \
      -H "Authorization: Bearer ${QUAY_API_KEY}" \
      -H "Content-Type: application/json" \
      -d '{"visibility": "public"}' \
      "https://quay.io/api/v1/repository/medbioinf/${dir_name}/changevisibility"

    cd ..
    echo "=== Done: base image ${container_ver} ==="
  else
    echo "Base image '${dir_name}' unchanged. Skipping."
  fi
done
cd ..

###############################################
# Build app containers
###############################################
echo "========================================="
echo "Checking application containers..."
echo "========================================="

cd docker
for d in */; do
  dir_name=$(echo "${d}" | tr -d '/')

  # If base images changed, also rebuild containers that depend on them
  should_build=false
  if dir_changed "docker/${dir_name}"; then
    should_build=true
    echo "Container '${dir_name}' has local changes. Will build."
  elif [[ "$BASE_IMAGES_CHANGED" == "true" ]]; then
    # Check if this container's Dockerfile FROM references a base image we rebuilt
    base_image=$(grep -i "^FROM" "docker/${dir_name}/Dockerfile" | head -1 | awk '{print $2}')
    if echo "$base_image" | grep -q "quay.io/medbioinf/"; then
      should_build=true
      echo "Container '${dir_name}' depends on changed base image '${base_image}'. Will build."
    fi
  fi

  if [[ "$should_build" == "true" ]]; then
    build_container "$dir_name" "$dir_name"
  else
    echo "Container '${dir_name}' unchanged. Skipping."
  fi
done
cd ..

echo "========================================="
echo "Selective build complete."
echo "========================================="