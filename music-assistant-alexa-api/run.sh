#!/bin/sh
# Minimal wrapper - just export env vars and exec original command

# HA Supervisor sets these from config.json schema
# If not set, use defaults
export USERNAME="${USERNAME:-admin}"
export PASSWORD="${PASSWORD:-test}"

# Get the original CMD from the base image and execute it
# If no args provided, the base image's CMD will run
exec "$@"
