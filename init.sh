#!/bin/bash

docker-compose up -d

echo "Initiating replica set"
mongo $(docker-machine ip):27017 ./scripts/replica_set.js

docker-compose logs
