ARG BUILD_FROM
FROM ${BUILD_FROM}

# Copy minimal wrapper script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Preserve original CMD but use our wrapper as entrypoint
# This way we can inject env vars before the original command runs
ENTRYPOINT ["/run.sh"]
