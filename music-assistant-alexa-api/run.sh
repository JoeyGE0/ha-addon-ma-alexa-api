#!/bin/bash
# shellcheck shell=bash

# Try to use bashio if available, otherwise read from /data/options.json
if command -v bashio >/dev/null 2>&1; then
    USERNAME=$(bashio::config 'username' 2>/dev/null || echo "admin")
    PASSWORD=$(bashio::config 'password' 2>/dev/null || echo "test")
elif [ -f /data/options.json ]; then
    USERNAME=$(jq -r '.username // "admin"' /data/options.json 2>/dev/null || echo "admin")
    PASSWORD=$(jq -r '.password // "test"' /data/options.json 2>/dev/null || echo "test")
else
    # Fallback to environment variables
    USERNAME="${USERNAME:-admin}"
    PASSWORD="${PASSWORD:-test}"
fi

export USERNAME
export PASSWORD

# Execute the original entrypoint/CMD from the base image
# Try common patterns
exec /init 2>/dev/null || \
exec /docker-entrypoint.sh "$@" 2>/dev/null || \
exec node /app/index.js 2>/dev/null || \
exec node /usr/src/app/index.js 2>/dev/null || \
exec node server.js 2>/dev/null || \
exec node index.js 2>/dev/null || \
exec "$@"
