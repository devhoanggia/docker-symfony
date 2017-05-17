#!/bin/bash

CONTAINER_WEB="laravel-web"
CONTAINER_MYSQL="laravel-db"
CONTAINER_WEB_DIR="/data/www"

if [ "$1" == "docker" ]; then
    if [ "$2" == "remove" ]; then
        if docker ps -a | grep -qs $CONTAINER_WEB; then
            echo "Removing intermediate container $CONTAINER_WEB"
            docker rm -f $CONTAINER_WEB
        fi

        if docker ps -a | grep -qs mysql; then
            echo "Removing intermediate container $CONTAINER_MYSQL"
            docker rm -f $CONTAINER_MYSQL
        fi
    elif [ "$2" == "ssh" ]; then
        docker exec -it $CONTAINER_WEB bash
    elif [ "$2" == "info" ]; then
        docker inspect $CONTAINER_WEB
    fi
else
    if docker ps -a | grep -qs $CONTAINER_WEB; then
        docker exec -it $CONTAINER_WEB bash -c "cd $CONTAINER_WEB_DIR; $*"
    else
        echo "Please start the container first!"
        exit
    fi
fi