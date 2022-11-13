FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y wget

RUN apt-get install -y gnupg
RUN wget -O- https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list

RUN apt-get update

RUN apt-get install -y mongodb-org

WORKDIR "/"
RUN mkdir data
WORKDIR "/data"
RUN mkdir db

WORKDIR "/"

COPY ./script.sh .
RUN chmod +x /script.sh

EXPOSE 27017

CMD /script.sh
