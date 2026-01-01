ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set default environment variables
# HA Supervisor will override these from config.json via environment mapping
ENV USERNAME=admin
ENV PASSWORD=test

# Don't override entrypoint or CMD - let the base image run as-is
# The base image already has its own entrypoint that runs the app
# HA Supervisor will inject USERNAME and PASSWORD env vars from config.json
