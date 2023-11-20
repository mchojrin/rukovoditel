#!/bin/sh

set -e
dropletId=$(awk ' {print $2} ' /tmp/droplet.txt)

echo "Destroying droplet $dropletId"

doctl compute droplet delete $dropletId -f

rm /tmp/droplet.txt
