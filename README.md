# docker-mongodb

Docker image to run mongodb 4.4

> Support RPi 3/4 64-bit

## Build

```sh
sudo docker build -t test-mongo:1 .
```

## Run

```sh
sudo docker run --restart always --name test-mongo -d test-mongo:1
```

## Run prepared to expose the mongodb to work outside the container

```sh
sudo docker run -p 27017:27017 --restart always --name test-mongo -v /home/MONGOD_CONF_PATH:/etc/mongo -d test-mongo:1 mongod --config /etc/mongo/mongod.conf
```

> MONGOD_CONF_PATH - path to mongod.conf file

## Default file mongod.conf, prepared to expose the mongodb to work outside the container

```yml
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
```

## Add example admin user

```sh
sudo docker exec -it test-mongo bash

mongo

use admin

db.createUser({
  user: 'admin',
  pwd: '123456',
  roles: [ { role: 'root', db: 'admin' } ]
})

db.auth("admin", passwordPrompt())
```

## Add example read/write user

```sh
sudo docker exec -it test-mongo bash

mongo

use admin

db.createUser(
  {
    user: "test",
    pwd: "123456",
    roles: [ { role: "readWrite", db: "test" } ]
  }
);
```

## Test read/write user

```sh
sudo docker exec -it test-mongo bash

mongo

use test

db.auth("test", passwordPrompt())

db.test.insert({"name":"test"})
db.test.find({"name":"test"}).pretty()
db.test.update({"name":"test"},{$set:{'mongo':"yes"}})
```

# Use compose

## Add **.env** file in main folder

```
DB_LOGIN="TODO_LOGIN"
DB_PASSWORD="TODO_PASSWORD"
```

> DB_LOGIN - login for the mongo database admin user

> DB_PASSWORD - password for the mongo database admin user

## (Optional) Add custom **mongod.conf** file
## Default **mongod.conf** file

```yml
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
```

## Create compose test

```sh
sudo docker compose up
```

## Create compose prod

```sh
sudo docker compose up -d
```

## Delete compose

```sh
sudo docker compose down
```

## Check compose

```sh
sudo docker compose images
```

## Create users

### Add example admin user

```sh
sudo docker exec -it docker-mongodb-mongodb-1 bash

mongo

use admin

db.createUser({
  user: 'admin',
  pwd: '123456',
  roles: [ { role: 'root', db: 'admin' } ]
})

db.auth("admin", passwordPrompt())
```

### Add example read/write user

```sh
sudo docker exec -it docker-mongodb-mongodb-1 bash

mongo

use admin

db.createUser(
  {
    user: "test",
    pwd: "123456",
    roles: [ { role: "readWrite", db: "test" } ]
  }
);
```
