#!/bin/bash
# shellcheck shell=bash

# Try to use bashio if available, otherwise read from /data/options.json
if command -v bashio >/dev/null 2>&1 && bashio::config 'username' >/dev/null 2>&1; then
    USERNAME=$(bashio::config 'username')
    PASSWORD=$(bashio::config 'password')
elif [ -f /data/options.json ]; then
    if command -v jq >/dev/null 2>&1; then
        USERNAME=$(jq -r '.username // "admin"' /data/options.json 2>/dev/null || echo "admin")
        PASSWORD=$(jq -r '.password // "test"' /data/options.json 2>/dev/null || echo "test")
    else
        # Fallback: basic parsing without jq
        USERNAME=$(grep -o '"username"[[:space:]]*:[[:space:]]*"[^"]*"' /data/options.json | cut -d'"' -f4 || echo "admin")
        PASSWORD=$(grep -o '"password"[[:space:]]*:[[:space:]]*"[^"]*"' /data/options.json | cut -d'"' -f4 || echo "test")
    fi
else
    # Fallback to environment variables
    USERNAME="${USERNAME:-admin}"
    PASSWORD="${PASSWORD:-test}"
fi

export USERNAME
export PASSWORD

# Execute the original entrypoint/CMD from the base image
# Try common patterns - the base image should have its own way to start
if [ -f /init ] && [ -x /init ]; then
    exec /init "$@"
elif [ -f /docker-entrypoint.sh ] && [ -x /docker-entrypoint.sh ]; then
    exec /docker-entrypoint.sh "$@"
elif [ -f /usr/local/bin/docker-entrypoint.sh ] && [ -x /usr/local/bin/docker-entrypoint.sh ]; then
    exec /usr/local/bin/docker-entrypoint.sh "$@"
elif command -v node >/dev/null 2>&1; then
    if [ -f /app/index.js ]; then
        exec node /app/index.js
    elif [ -f /usr/src/app/index.js ]; then
        exec node /usr/src/app/index.js
    elif [ -f server.js ]; then
        exec node server.js
    elif [ -f index.js ]; then
        exec node index.js
    else
        echo "ERROR: Could not find node app to run" >&2
        exit 1
    fi
else
    # Last resort: exec whatever was passed
    exec "$@"
fi
