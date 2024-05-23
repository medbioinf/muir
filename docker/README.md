# muir Dockerfiles

Put the Dockerfiles for each image in its separate folder here.

As the images are build under the scope of their own path, all data which needs to be copied to the image during the build should also lie in the respective folder of the image.

Each image needs one `Dockerfile` and the `container.sh`, which requires the environment variables `CONTAINER_TITLE`, `CONTAINER_VERSION` and `CONTAINER_DESCRIPTION` and can be used to pass further information for the build of the container.

The `build.sh` script in the main folder of the repo iterates through all folders here, builds the images and pushes them to the quay.io registry.
