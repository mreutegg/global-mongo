#!/bin/bash

docker ps --filter 'label=global.clustering.type=toxi' -q | while read id 
do
  echo "Setting latency on ${id}"
  docker exec $id /tmp/set_latency.sh "$@"
done
