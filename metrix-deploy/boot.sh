#!/bin/bash

sudo chmod -R 0777 /redis_data

source /etc/profile

go get -u github.com/callumj/metrix

redis-server /etc/redis.conf

curl -X POST "http://metrix.callumj.com/version?source=docker&key=$NAME&version=$VERSION"

/opt/go/bin/metrix /etc/metrix.yml