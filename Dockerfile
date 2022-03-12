FROM debian:stretch-slim

RUN apt-get update
RUN apt-get install -y wget

RUN apt-get install -y gnupg
RUN wget -O- https://www.mongodb.org/static/pgp/server-5.0.asc | apt-key add -
RUN echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/5.0 main" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list

RUN apt-get update

RUN apt-get install -y mongodb-org=5.0.6 mongodb-org-database=5.0.6 mongodb-org-server=5.0.6 mongodb-org-shell=5.0.6 mongodb-org-mongos=5.0.6 mongodb-org-tools=5.0.6

WORKDIR "/"
RUN mkdir data
WORKDIR "/data"
RUN mkdir db

EXPOSE 27017
CMD ["mongod"]
