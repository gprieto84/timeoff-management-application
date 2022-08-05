# -------------------------------------------------------------------
# Minimal dockerfile from alpine base
#
# Instructions:
# =============
# 1. Create an empty directory and copy this file into it.
#
# 2. Create image with: 
#	docker build --tag timeoff:latest .
#
# 3. Run with: 
#	docker run -d -p 3000:3000 --name alpine_timeoff timeoff
#
# 4. Login to running container (to update config (vi config/app.json): 
#	docker exec -ti --user root alpine_timeoff /bin/sh
# --------------------------------------------------------------------
FROM node:14-alpine

EXPOSE 3000

LABEL org.label-schema.schema-version="1.3.0"
LABEL org.label-schema.docker.cmd="docker run -d -p 3000:3000 --name timeoff-management"

RUN apk update
RUN apk upgrade
# RUN apk add --no-cache --virtual python g++ make
RUN apk add g++ make py3-pip
#Install dependencies
RUN apk add \
    git \
    gcc \
    libc-dev \
    clang

#Update npm
RUN npm install -g npm
RUN npm config set unsafe-perm true

WORKDIR /app

#clone app
COPY . timeoff-management
WORKDIR /app/timeoff-management/config

WORKDIR /app/timeoff-management
#Add user so it doesn't run as root
ARG user=app
ARG uid=1111
RUN adduser --system $user --home /app
# RUN set -x ; \
#     addgroup -g $uid -S $user ; \
#     adduser -u $uid -D -S -G $user --system --home /app  $user \
#     && exit 0 ; exit 1
RUN chown -Rh $user /app
USER $user

#install app
RUN npm install --build-from-source --python=/usr/bin/python3

CMD npm start