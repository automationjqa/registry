#!/bin/bash

source /etc/profile

/usr/bin/registry serve /etc/docker-distribution/registry/config.yml >> /var/log/docker-registry.log
