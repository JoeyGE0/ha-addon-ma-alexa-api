ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set default environment variables
# HA Supervisor will override these from config.json schema automatically
ENV USERNAME=admin
ENV PASSWORD=test

# Don't override entrypoint or CMD - let the base image run as-is
# HA Supervisor automatically injects USERNAME and PASSWORD from config.json schema
