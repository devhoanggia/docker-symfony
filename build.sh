#!/bin/bash

IMAGE_NAME="nginx:server"

if [ "$1" == "docker" ]; then
    if [ "$2" == "build" ]; then
       docker rmi -f $(docker images -f "dangling=true" -q)
       docker rmi -f $IMAGE_NAME
       docker build -t=$IMAGE_NAME .
    fi
fi