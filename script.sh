#!/bin/bash

# Add mongod.conf file

cd /etc/mongo

if [[ ! -f ./mongod.conf ]]; then
cat >> mongod.conf << EOF
storage:
  journal:
    enabled: true

systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log

net:
  port: 27017
  bindIp: 0.0.0.0

processManagement:
  timeZoneInfo: /usr/share/zoneinfo

security:
  authorization: enabled
EOF
fi

cd ..
cd ..

# Run mongodb

mongod
