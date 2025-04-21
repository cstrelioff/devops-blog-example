#!/bin/bash

if [ -d _site ]; then
  # if _site exists, delete and reconstruct
  echo "...removing old version of _site"
  rm -r _site
fi

# create 11ty-build image
docker build -f Dockerfile.build -t 11ty-build .

# create 11ty-container
docker run --name 11ty-container 11ty-build

# copy _site directory to host
docker cp 11ty-container:/app/_site _site

# [optional] cleanup image and container
docker container rm 11ty-container
docker rmi 11ty-build:latest
