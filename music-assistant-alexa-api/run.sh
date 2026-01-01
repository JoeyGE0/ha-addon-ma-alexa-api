#!/usr/bin/with-contenv bashio
# shellcheck shell=bash

USERNAME=$(bashio::config 'username')
PASSWORD=$(bashio::config 'password')

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
    else
        # Last resort: check if node app
        if command -v node >/dev/null 2>&1; then
            exec node /app/index.js || node /usr/src/app/index.js || node server.js
        else
            bashio::log.error "Could not determine entrypoint"
            exit 1
        fi
    fi
fi
