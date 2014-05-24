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

nginx -c /etc/nginx/app.conf &
sleep 1
tail -f /app_logs/error*