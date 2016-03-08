#!/bin/bash

IFS=',' read -ra PROXIES <<< "$tp_config"
for i in "${PROXIES[@]}"; do
  host=$(echo $i | cut -f1 -d':')
  port=$(echo $i | cut -f2 -d':')

  proxy_name="${host}_${port}"

  curl -s -i -X DELETE "tp:8474/proxies/${proxy_name}"
  curl -s -i -d '{"name": "'${proxy_name}'", "upstream": "'"${host}:${port}"'", "listen": "0.0.0.0:'${port}'"}' "tp:8474/proxies"
done

if [ -e /replica_set.js]; then
  mongo tp:27017 /replica_set.js
  rm /replica_set.js
fi
