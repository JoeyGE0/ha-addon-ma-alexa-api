# Stage 1: Get the alexa-api image
FROM ghcr.io/alams154/music-assistant-alexa-api:latest AS alexa-api

# Stage 2: Build final image with HA base
ARG BUILD_FROM
FROM ${BUILD_FROM}

# Copy app files from alexa-api (be selective to avoid overwriting HA base files)
# Copy common app locations
COPY --from=alexa-api /app /app 2>/dev/null || true
COPY --from=alexa-api /usr/src/app /usr/src/app 2>/dev/null || true
COPY --from=alexa-api /opt /opt 2>/dev/null || true

# Copy run script FIRST (before any other operations)
COPY run.sh /run.sh
RUN chmod a+x /run.sh && ls -la /run.sh

# Use run.sh as entrypoint
ENTRYPOINT ["/run.sh"]
