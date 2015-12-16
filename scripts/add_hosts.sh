#!/bin/bash

IFS=',' read -ra HOSTS <<< "$host_config"
for i in "${HOSTS[@]}"; do
  host=$(echo $i | cut -f1 -d':')
  alias=$(echo $i | cut -f2 -d':')
  ip=$(grep _${host}_ /etc/hosts | head -1 | cut -f1)
  echo "$ip	$alias" >> /etc/hosts
done
