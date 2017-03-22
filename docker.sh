#!/bin/bash

IMAGE="quay.io/devhoanggia/nginx"
CONTAINER_NAME="nginx-server"
PORT_HOST=82

IMAGE_MYSQL="quay.io/devhoanggia/mysql"
PORT_MYSQL_HOST=3307
DB_DIRECTORY="/Users/lap00344/MyProject/database"

if [ -z $1 ]; then
    echo -e "Supported arguments:
        * docker [start|ssh|info]
    "
elif [ "$1" == "docker" ]; then
    if [ -z $2 ]; then
        echo -e "Available options:
            * start
            * ssh
            * info
        "
    elif [ "$2" == "start" ]; then
        docker pull $IMAGE

        if docker ps -a | grep -qs $CONTAINER_NAME; then
            echo "Removing intermediate container $CONTAINER_NAME"
            docker rm -f $CONTAINER_NAME
        fi

        if docker ps -a | grep -qs mysql; then
            echo "Removing intermediate container $IMAGE_MYSQL"
            docker rm -f mysql
        fi

        echo "Creating container mysql"
        docker run --name mysql -d -p $PORT_MYSQL_HOST:3306 -v $DB_DIRECTORY:/store/db $IMAGE_MYSQL

        echo "Creating container $CONTAINER_NAME"
        docker run --name $CONTAINER_NAME -d -p $PORT_HOST:80 -v `pwd`:$CONTAINER_DIR --link mysql:mysql $IMAGE

        echo "http://localhost:$PORT_HOST"

    elif [ "$2" == "ssh" ]; then
        docker exec -it $CONTAINER_NAME bash
    elif [ "$2" == "info" ]; then
        docker inspect $CONTAINER_NAME
    fi
else
    if docker ps -a | grep -qs $CONTAINER_NAME; then
        docker exec -it $CONTAINER_NAME bash -c "cd $CONTAINER_DIR; $*"
    else
        echo "Please start the container first!"
        exit
    fi
fi