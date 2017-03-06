#!/bin/sh

docker run -p 127.0.0.1:5000:5000 -d --restart=always -v $PWD/var-lib-registry:/var/lib/registry -v $PWD/config.yml:/etc/docker/registry/config.yml --name registry registry:2.6.0

