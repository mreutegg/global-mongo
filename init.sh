#!/bin/bash

docker-compose --x-networking up -d

docker ps --filter 'label=global.clustering.type=mongo' -q | while read id 
do
  echo "Adding hosts on $id"
  docker cp scripts/add_hosts.sh $id:/tmp
  docker exec $id /tmp/add_hosts.sh
done

docker ps --filter 'label=global.clustering.type=toxi' -q | while read id 
do
  echo "Creating proxy on $id"
  docker cp scripts/create_proxy.sh $id:/tmp
  docker exec $id /tmp/create_proxy.sh
done

mongo docker:27017 scripts/replica_set.js

docker-compose logs
