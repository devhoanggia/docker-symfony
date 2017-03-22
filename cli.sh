#!/bin/bash

IMAGE_NAME="nginx:server"
CONTAINER_TEST="nginx:test"
CONTAINER_DIR="/data/www"
PORT=91

if [ -z $1 ]; then
    echo -e "Supported arguments:
        * docker [build|test|ssh]
    "
elif [ "$1" == "docker" ]; then
    if [ -z $2 ]; then
        echo -e "Available options:
            * build
            * test
            * ssh
        "
    elif [ "$2" == "build" ]; then
       if docker ps -a | grep -qs $CONTAINER_TEST; then
         echo "Removing current container..."
         docker rm -f $CONTAINER_TEST
       fi

       docker rmi -f $(docker images -f "dangling=true" -q)
       docker rmi -f $IMAGE_NAME
       docker build -t=$IMAGE_NAME .

    elif [ "$2" == "test" ]; then
        if docker ps -a | grep -qs $CONTAINER_TEST; then
            echo "Removing current container..."
            docker rm -f $CONTAINER_TEST
        fi
        docker run -d --name $CONTAINER_TEST -v `pwd`/store:$CONTAINER_DIR -p $PORT:80 $IMAGE_NAME
        echo "http://localhost:$PORT"

    elif [ "$2" == "ssh" ]; then
        docker exec -it $CONTAINER_TEST bash
    fi
fi