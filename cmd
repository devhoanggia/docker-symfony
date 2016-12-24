#!/bin/bash

IMAGE_NAME="docker-symfony"
CONTAINER_NAME="docker-symfony-server"
SOURCE="/data/www"
CONTAINER_PORT="9999"

if [ -z $1 ]; then
    echo -e "Supported arguments:
        * help
        * docker [start|ssh|cmd]
    "
elif [ "$1" == "help" ]; then
    echo "Docker config"
    echo "Images: $IMAGE_NAME"
    echo "Container: $CONTAINER_NAME"
    echo "Source: CONTAINER_FOLDER"
    echo "Port: CONTAINER_PORT"
    echo
    echo "docker rmi $IMAGE_NAME"
    echo "docker inspect $CONTAINER_TEST"
    echo "docker logs $CONTAINER_TEST"

elif [ "$1" == "init" ]; then
    echo "Initiating application..."
    chmod -R 777 app/cache
    docker_exec "composer update"
elif [ "$1" == "docker" ]; then
    if [ -z $2 ]; then
        echo -e "Available options:
            * start
            * ssh
            * cmd
        "
    elif [ "$2" == "start" ]; then
        if docker ps -a | grep -qs $CONTAINER_NAME; then
            echo "Removing current container..."
            docker rm -f $CONTAINER_NAME
        fi

        echo "Creating container '$CONTAINER_NAME'..."
        docker run --name $CONTAINER_NAME -d -p $CONTAINER_PORT:80 -v `pwd`:$SOURCE $IMAGE_NAME

    elif [ "$2" == "ssh" ]; then
        docker exec -it $CONTAINER_NAME bash
    elif [ "$2" == "cmd" ]; then
        if docker ps -a | grep -qs $CONTAINER_NAME; then
            docker exec -it $CONTAINER_NAME bash -c "cd $SOURCE; $*"
        else
            echo "Please start the container first!"
            exit
        fi
    fi
fi