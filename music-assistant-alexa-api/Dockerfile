ARG BUILD_FROM
FROM ${BUILD_FROM}

# Copy run script FIRST and verify it exists
COPY run.sh /run.sh
RUN chmod a+x /run.sh && \
    ls -la /run.sh && \
    test -f /run.sh && \
    echo "run.sh copied successfully"

# Install bashio manually (HA add-on helper)
# Check what package manager is available
RUN \
    if command -v apk >/dev/null 2>&1; then \
        apk add --no-cache bash jq curl || true; \
    elif command -v apt-get >/dev/null 2>&1; then \
        apt-get update && \
        apt-get install -y --no-install-recommends bash jq curl || true && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* || true; \
    fi

# Install bashio
RUN \
    mkdir -p /usr/bin/bashio/lib && \
    curl -L -f -s "https://raw.githubusercontent.com/hassio-addons/bashio/master/bashio" \
        -o /usr/bin/bashio 2>/dev/null || \
    curl -L -f -s "https://github.com/hassio-addons/bashio/raw/master/bashio" \
        -o /usr/bin/bashio 2>/dev/null || true && \
    chmod a+x /usr/bin/bashio 2>/dev/null || true && \
    curl -L -f -s "https://raw.githubusercontent.com/hassio-addons/bashio/master/lib/bashio" \
        -o /usr/bin/bashio/lib/bashio 2>/dev/null || \
    curl -L -f -s "https://github.com/hassio-addons/bashio/raw/master/lib/bashio" \
        -o /usr/bin/bashio/lib/bashio 2>/dev/null || true

# Use run.sh as entrypoint - override any existing entrypoint
ENTRYPOINT ["/run.sh"]
