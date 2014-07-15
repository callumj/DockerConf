#!/bin/bash

sudo chmod -R 0777 /redis_data

source /etc/profile

go get -u github.com/callumj/metrix

redis-server /etc/redis.conf

/opt/go/bin/metrix /etc/metrix.yml