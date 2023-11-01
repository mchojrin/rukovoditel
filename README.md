# rukovoditel

A dockerized version of https://www.rukovoditel.net/.

## Installation instructions

These instructions are to be run in a Linux environment with bash available.

### Local

For local installation, you'll need docker and docker-compose available locally.

1. Run the `setup.sh` script to create the environment variables needed.
2. Run `docker-compose up` to get the services running
3. Open a browser at `http://localhost:8888` to finish the application setup

### Production

For production installation, you'll need a server where you can install docker and docker-compose. The script `deploy.sh` contains an example you can use for reference.

In this case, it is using [DigitalOcean](https://m.do.co/c/a008c19c273a), but the same can be achieved using other cloud providers.

If you want to use this very script:

1. Install the Digital Ocean client (`doctl` read [here](https://docs.digitalocean.com/reference/doctl/) for details).
2. Replace the lines `ID_FILE` and `SSH_FINGERPRINT` for the appropriate values of your environment
3. Run `deploy.sh` and follow the instructions from there
