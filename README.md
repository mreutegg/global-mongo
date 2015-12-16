# Dockerized Mongo replica set

## Introduction

This docker-compose setup creates a simulation of a cross-region Mongo replica
set. The set consists of 3 instances. Two of them (`m1` and `m2`) are installed
in one "virtual datacenter" and the third (`m3`) is placed in a different
region, with 100ms of latency.

The user observes the replica set from the `m3` perspective, so they have 0ms
latency connecting to `m3` and 100ms to `m1` and `m2`
