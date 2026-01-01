#!/bin/bash
# shellcheck shell=bash

# Try to read config from bashio if available, otherwise use env vars
if command -v bashio >/dev/null 2>&1; then
    USERNAME=$(bashio::config 'username')
    PASSWORD=$(bashio::config 'password')
else
    # Fallback to environment variables (HA Supervisor injects these)
    USERNAME="${USERNAME:-admin}"
    PASSWORD="${PASSWORD:-test}"
fi

export USERNAME
export PASSWORD

# Try to execute original entrypoint if args provided, otherwise use common patterns
if [ $# -gt 0 ]; then
    exec "$@"
else
    # Fallback: try common entrypoints
    if [ -f /init ]; then
        exec /init
    elif [ -f /usr/local/bin/docker-entrypoint.sh ]; then
        exec /usr/local/bin/docker-entrypoint.sh
    elif [ -f /docker-entrypoint.sh ]; then
        exec /docker-entrypoint.sh
    else
        # Last resort: check if node app
        if command -v node >/dev/null 2>&1; then
            exec node /app/index.js || node /usr/src/app/index.js || node server.js || node index.js
        else
            echo "ERROR: Could not determine entrypoint" >&2
            exit 1
        fi
    fi
fi
