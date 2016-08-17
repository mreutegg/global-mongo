#!/bin/bash

docker-compose kill
docker-compose rm -f
docker volume rm $(docker volume ls | grep -E 'm[123]-((conf)|(data))') > /dev/null 2>&1
