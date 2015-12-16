#!/bin/bash

IFS=',' read -ra PROXIES <<< "$tp_config"
for i in "${PROXIES[@]}"; do
  host=$(echo $i | cut -f1 -d':')
  port=$(echo $i | cut -f2 -d':')
  latency_name="${host}_latency"
  latency_value="${!latency_name}"
  latency=$(echo $latency_value | cut -f1 -d',')
  jitter=$(echo $latency_value | cut -f2 -d',')

  ip=$(grep _${host}_ /etc/hosts | head -1 | cut -f1)
  
  proxy_name="${host}_${port}"

  curl -v -i -X DELETE "localhost:8474/proxies/${proxy_name}" > /dev/null
  curl -v -i -d '{"name": "'${proxy_name}'", "upstream": "'"${ip}:${port}"'", "listen": "0.0.0.0:'${port}'"}' "localhost:8474/proxies"

  if [ -n "$latency_value" ]; then
    curl -v -i -d '{"enabled":true, "latency":'${latency}', "jitter": '${jitter}'}' "localhost:8474/proxies/${proxy_name}/downstream/toxics/latency"
  fi
done
