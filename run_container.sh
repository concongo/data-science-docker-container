#! /bin/bash

NAME=$1
FOLDER=$2
PORT=$3

CONTAINER=`docker run -d -p $PORT:8888 -v $FOLDER:/home/ds/notebooks dataquestio/$NAME-starter`
echo $CONTAINER