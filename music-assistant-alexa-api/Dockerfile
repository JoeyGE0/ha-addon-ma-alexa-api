# Stage 1: Get the alexa-api image  
FROM ghcr.io/alams154/music-assistant-alexa-api:latest AS alexa-api

# Stage 2: Build final image with HA base
ARG BUILD_FROM
FROM ${BUILD_FROM}

# Copy run script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Copy app files from alexa-api image
# Only copy specific directories to avoid overwriting HA base files
COPY --from=alexa-api /app /app
COPY --from=alexa-api /usr/src/app /usr/src/app
COPY --from=alexa-api /opt /opt
COPY --from=alexa-api /package.json /package.json 2>/dev/null || true
COPY --from=alexa-api /node_modules /node_modules 2>/dev/null || true

# Use run.sh as entrypoint
ENTRYPOINT ["/run.sh"]
