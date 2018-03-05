#! /bin/bash
MODE=$1
NAME=$2
FOLDER=$3
PORT=$4


CONTAINER=`docker run -$MODE -p $PORT:8888 -v $FOLDER:/home/ds/notebooks dataquestio/$NAME-starter -e "JUPYTER_TOKEN=$TOKEN"`
echo $CONTAINER