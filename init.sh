#!/bin/bash

MACHINE_IP=$(docker-machine ip 2>/dev/null || echo "127.0.0.1")

docker-compose up -d

echo "Initiating replica set"
mongo $MACHINE_IP:27017 ./scripts/replica_set.js

docker-compose logs
