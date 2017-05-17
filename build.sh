#!/bin/bash

IMAGE_NAME="nginx:server"
CONTAINER_DIR="/data/www"

if [ "$1" == "docker" ]; then
    if [ "$2" == "build" ]; then
       if docker ps -a | grep -qs $CONTAINER_TEST; then
         echo "Removing current container..."
         docker rm -f $CONTAINER_TEST
       fi

       docker rmi -f $(docker images -f "dangling=true" -q)
       docker rmi -f $IMAGE_NAME
       docker build -t=$IMAGE_NAME .

    elif [ "$2" == "ssh" ]; then
        docker exec -it $CONTAINER_TEST bash
    fi
fi