#!/bin/bash
IMAGE_NAME=sbeuran/custom-simple-http-server

until sudo docker ps | grep $IMAGE_NAME
do
  echo "Waiting for docker container to get started"
  sleep 3
done

CONTAINER_ID=$(sudo docker ps --all --quiet --filter ancestor=$IMAGE_NAME --format="{{.ID}}" | head -n 1)
CONTAINER_STATUS=$(sudo docker inspect --format "{{json .State.Status }}" $CONTAINER_ID)
until [ $CONTAINER_STATUS == '"running"' ]
do
  echo "Waiting for container to start..."
  sleep 2
done