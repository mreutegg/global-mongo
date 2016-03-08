#!/bin/bash

IFS=',' read -ra PROXIES <<< "$tp_config"
for i in "${PROXIES[@]}"; do
  host=$(echo $i | cut -f1 -d':')
  port=$(echo $i | cut -f2 -d':')

  proxy_name="${host}_${port}"

  curl -s -i -X DELETE "localhost:8474/proxies/${proxy_name}" > /dev/null
  curl -s -i -d '{"name": "'${proxy_name}'", "upstream": "'"${host}:${port}"'", "listen": "0.0.0.0:'${port}'"}' "localhost:8474/proxies" > /dev/null
done
