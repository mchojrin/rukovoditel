#!/bin/sh

set -e
TARGET_IMAGE=ruko_prod
TAR_FILE="$TARGET_IMAGE.tar"
ID_FILE="~/.ssh/id_rsa_leeway"

echo "Building production image"
docker build . -t $TARGET_IMAGE --target=prod

echo "Packaging the image for deployment"
docker save -o $TAR_FILE $TARGET_IMAGE
echo "File $TAR_FILE ready for deployment"

IP=$(awk ' {print $1} ' /tmp/droplet.txt)

echo "Uploading files"
scp -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" -i $ID_FILE $TAR_FILE root@"$IP":~/

ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" -i $ID_FILE root@"$IP" "echo 'Bringing down services'; \
  docker-compose down; \
	echo 'Installing new image $TARGET_IMAGE'; \
	docker load -i $TAR_FILE; \
	echo 'Bringing services up'; \
	docker-compose up -d ;"

echo "Everything ready. Open up a browser at http://$IP to see updated version"