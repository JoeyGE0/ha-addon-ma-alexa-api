#!/usr/bin/with-contenv bashio
# shellcheck shell=bash

# Read config from HA using bashio
USERNAME=$(bashio::config 'username')
PASSWORD=$(bashio::config 'password')

export USERNAME
export PASSWORD

# Execute the original entrypoint/CMD from the alexa-api image
# The app should be in the same location as the original image
exec /init || exec node /app/index.js || exec node /usr/src/app/index.js || exec node server.js
