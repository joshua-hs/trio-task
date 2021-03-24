#!/bin/bash

#Create network
docker network create trio-network

#Build images
docker build -t trio-db db
docker build -t trio-app flask-app

#Run database container
docker run -d --network trio-network --name mysql trio-db

#Run flask app
docker run -d --network trio-network --name flask-app trio-app

#Run nginx container
docker run -d --network trio-network --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf -p 80:80 --name nginx nginx:alpine

docker ps -a