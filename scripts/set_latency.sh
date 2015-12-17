#!/bin/bash

IFS=',' read -ra PROXIES <<< "$tp_config"
for i in "${PROXIES[@]}"; do
  host=$(echo $i | cut -f1 -d':')
  port=$(echo $i | cut -f2 -d':')
  proxy_name="${host}_${port}"

  latency=$1
  jitter=${2:-0}

  if [ -n "$latency" ]; then
    echo "Set latency ${latency} with jitter ${jitter} on ${i}"
    curl -s -i -d '{"enabled":true, "latency":'${latency}', "jitter": '${jitter}'}' "localhost:8474/proxies/${proxy_name}/downstream/toxics/latency" > /dev/null
  else
    echo "Disable latency on ${i}"
    curl -s -i -d '{"enabled":false}' "localhost:8474/proxies/${proxy_name}/downstream/toxics/latency" > /dev/null
  fi
done
