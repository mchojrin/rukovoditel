#!/bin/sh

set -e
DROPLET=ruko-do
TARGET_IMAGE=ruko_prod
TAR_FILE="$TARGET_IMAGE.tar"
ID_FILE="~/.ssh/id_rsa_leeway"
SSH_FINGERPRINT="91:1e:be:f0:03:24:86:1d:d1:f7:00:ce:f4:37:35:16"
ENV_FILE=".env.dist"
SETUP_SCRIPT="setup.sh"

echo "Building production image"
docker build . -t $TARGET_IMAGE --target=prod

echo "Packaging the image for deployment"
docker save -o ruko_prod.tar ruko_prod
echo "File $TAR_FILE ready for deployment"

echo "Spinning up a new droplet and waiting for it to be ready..."
doctl compute droplet create \
    --image ubuntu-23-10-x64 \
    --size s-1vcpu-1gb \
    --region sfo3 \
    --wait \
    --interactive=false \
    --vpc-uuid e313b2da-7606-46e5-9b95-5367cdbf3467 \
    --ssh-keys $SSH_FINGERPRINT \
    $DROPLET

echo "Droplet up"
doctl compute droplet get $DROPLET --template="{{.PublicIPv4}} {{.ID}}" > /tmp/droplet.txt

IP=$(awk ' {print $1} ' /tmp/droplet.txt)
dropletId=$(awk ' {print $2} ' /tmp/droplet.txt)

rm /tmp/droplet.txt

echo "Droplet ready with ip: $IP and id:$dropletId"

echo "Waiting for droplet to be ready for ssh connections"
until ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" -i $ID_FILE root@"$IP" true >/dev/null 2>&1; do
	: 
done

echo "Uploading files"
scp -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" -i $ID_FILE $TAR_FILE docker-compose.yml $ENV_FILE $SETUP_SCRIPT root@"$IP":~/

ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" -i $ID_FILE root@"$IP" "echo 'Installing docker and docker-compose' ; \
	apt install -y docker.io ; apt install -y docker-compose; \
	echo 'Configuring .env'; \
	sh ./$SETUP_SCRIPT; \
	echo 'Installing image $TARGET_IMAGE'; \
	docker load -i $TAR_FILE; \
	echo 'Bringing services up'; \
	docker-compose up -d; \
	" 

echo "Everything ready. Open up a browser at http://$IP to finish installation"
echo "When done, delete the droplet using the command:"
echo "  doctl compute droplet delete $dropletId -f"
