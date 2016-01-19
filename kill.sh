#!/bin/bash

docker ps --filter 'label=global.clustering.type=mongo' -q | while read id
do
  echo "Removing volume on $id"
  docker cp scripts/clean.sh $id:/tmp
  docker exec $id /tmp/clean.sh
done

docker-compose kill
docker-compose rm -f
