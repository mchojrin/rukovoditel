#!/bin/sh

UID=$(id -u)
GID=$(id -g)

sed "s/UID/${UID}/g" .env.dist | sed "s/GID/${GID}/g" > .env
echo "Changes written to .env"