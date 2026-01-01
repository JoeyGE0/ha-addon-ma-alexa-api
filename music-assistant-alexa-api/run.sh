#!/usr/bin/with-contenv bashio
# shellcheck shell=bash

# Read config from HA
USERNAME=$(bashio::config 'username')
PASSWORD=$(bashio::config 'password')

export USERNAME
export PASSWORD

# Run the alexa-api container
exec docker run --rm -i \
    -p 3000:3000 \
    -e USERNAME="${USERNAME}" \
    -e PASSWORD="${PASSWORD}" \
    --name music-assistant-alexa-api \
    ghcr.io/alams154/music-assistant-alexa-api:latest
