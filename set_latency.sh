#!/bin/bash

LATENCY=$1
JITTER=${2:-0}
MACHINE_IP=$(docker-machine ip 2>/dev/null || echo "127.0.0.1")

for proxy_name in $(curl -s $IP:8474/proxies | jq -r 'keys[]')
do
  if [ -n "$LATENCY" ]; then
    echo "Set latency ${LATENCY} with jitter ${JITTER} on ${proxy_name}"
    curl -s -i -d '{"enabled":true, "latency":'${LATENCY}', "jitter": '${JITTER}'}' "${MACHINE_IP}:8474/proxies/${proxy_name}/downstream/toxics/latency" > /dev/null
  else
    echo "Disable latency on ${proxy_name}"
    curl -s -i -d '{"enabled":false}' "${MACHINE_IP}:8474/proxies/${proxy_name}/downstream/toxics/latency" > /dev/null
  fi
done
