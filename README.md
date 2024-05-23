# muir - Containers for the Medical Bioinformatics

This repo holds Dockerfiles for the build of containers regularly used by the #medbioinf. The main aim is to use them in workflows and pipelines and commonly have only one tool per Docker container.

The repo should not duplicate any work, but only holds Dockerfiles for tools which either don't have theri own (official) builds, are not available for current versions or need some tweaks in our pipelines, not provided by official containers.

## Status of the container builds
All containers are hosted on quay.io

- comet-ms: [![Docker Repository on Quay](https://quay.io/repository/medbioinf/comet-ms/status "Docker Repository on Quay")](https://quay.io/repository/medbioinf/comet-ms) (https://uwpr.github.io/Comet/)

## Architecture of the repo
- under `./docker`, each folder represents one Docker image to build
- each image needs one `Dockerfile` and the `container.sh`, which requires the environment variable `CONTAINER_VERSION` and can be used to pass further information for the build of the container
- the version number of the container should reflect the version of the original tool
- the images are build and pushed after a successful push to GitHub

## Name of the repo
Muir is gaelic for "sea", like a sea of containers.
