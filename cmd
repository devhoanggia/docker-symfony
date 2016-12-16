#!/bin/bash

IMAGE_NAME="docker-symfony"
CONTAINER_NAME="docker-symfony-web-server"
CONTAINER_FOLDER="/data/www"
CONTAINER_PORT="9999"

function docker_run {
    echo "Creating container '$CONTAINER_NAME'..."
    docker run --name $CONTAINER_NAME -d -p $CONTAINER_PORT:80 -v `pwd`:$CONTAINER_FOLDER $IMAGE_NAME
}

function docker_exec {
	if docker ps -a | grep -qs $CONTAINER_NAME; then
		docker exec -it $CONTAINER_NAME bash -c "cd $CONTAINER_FOLDER; $*"
	else
        echo "Please start the container first!"
        exit
    fi
}

if [ -z $1 ]; then
    echo -e "Supported arguments:
        * init
        * docker [start|update|ssh]
    "
elif [ "$1" == "init" ]; then
    echo "Initiating application..."
    chmod -R 777 app/cache
    docker_exec "composer update"
elif [ "$1" == "docker" ]; then
    if [ -z $2 ]; then
        echo -e "Available options:
            * start
            * update
            * ssh
        "
    elif [ "$2" == "start" ]; then
        if docker ps -a | grep -qs $CONTAINER_NAME; then
            echo "Removing current container..."
            docker rm -f $CONTAINER_NAME
        fi
        docker_run
    elif [ "$2" == "update" ]; then
        echo "Updating image '$IMAGE_NAME'..."
        docker pull $IMAGE_NAME
    elif [ "$2" == "inspect" ]; then
        docker inspect $IMAGE_NAME
    elif [ "$2" == "ssh" ]; then
        docker exec -it $CONTAINER_NAME bash
    fi
elif [ $# ]; then
    echo "Command is not support!"
fi


