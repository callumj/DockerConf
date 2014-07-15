#!/bin/bash

curl -X POST "http://metrix.callumj.com/version?source=t&key=$NAME&version=$VERSION"

nginx -c /etc/nginx/app.conf