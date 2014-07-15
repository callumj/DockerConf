#!/bin/bash

if [ ! -d "/app/.git" ]
then
  git clone https://github.com/callumj/callumjcom.git /app
fi

cd /app
git fetch
git reset --hard origin/master

npm install
grunt build
phantomjs phantom.js

curl -X POST "http://metrix.callumj.com/version?source=docker&key=$NAME&version=$VERSION"

nginx -c /etc/nginx/app.conf &
sleep 1
tail -f /app_logs/error*