# Dockerized Mongo replica set

## Introduction

This docker-compose setup creates a simulation of a cross-region Mongo replica
set. The set consists of 3 instances. Two of them (`m1` and `m2`) are installed
in one "virtual datacenter" and the third (`m3`) is placed in a different
region, with 100ms of latency.

The user observes the replica set from the `m3` perspective, so they have 0ms
latency connecting to `m3` and 100ms to `m1` and `m2`:

![Graph](doc/graph.png?raw=true)

## Deployment

In order to setup the containers, invoke:

    ./init.sh

it'll use `docker-compose` to create 4 containers. Mongo instances are available
on exposed ports 27017 (primary), 27018 (secondary) and 27019 (secondary, no
latency).

## Connecting to the replica set with mongo

One may connect to the Mongo using the ports above and the hostname of the
`docker-machine`. If the docker runs without the `docker-machine` localhost
will work as well.

    mongo $(docker-machine ip $DOCKER_MACHINE_NAME):27017

## Setting latency

The latency and jitter can be set using another script:

    ./configure.sh 200 10

Both values are passed in milliseconds. Invoking the script without any parameters
will disable the latency.

## Stopping the replica set

The whole deployment can be stopped and removed with following command:

    ./kill.sh

## TODO

* Add [fakes3](https://github.com/jubos/fake-s3) support to simulate datastore
  latency
