#!/bin/bash

docker-compose up -d

docker ps --filter 'label=global.clustering.type=toxi' -q | while read id 
do
  echo "Creating proxy on $id"
  docker cp scripts/create_proxy.sh $id:/tmp
  docker cp scripts/set_latency.sh $id:/tmp
  docker exec $id /tmp/create_proxy.sh
done

echo "Initiating replica set"
mongo mongo1:27017 ./scripts/replica_set.js

./configure.sh 0

docker-compose logs
