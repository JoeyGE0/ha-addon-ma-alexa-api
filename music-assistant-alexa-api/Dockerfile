ARG BUILD_FROM
FROM ${BUILD_FROM}

# Install bashio and s6-overlay (HA add-on requirements)
# Try to install on Alpine-based image
RUN \
    if [ -f /etc/alpine-release ]; then \
        apk add --no-cache \
            bash \
            jq \
            curl \
            s6-overlay || true; \
    elif [ -f /etc/debian_version ]; then \
        apt-get update && \
        apt-get install -y --no-install-recommends \
            bash \
            jq \
            curl \
            s6 || true && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*; \
    fi

# Install bashio manually (HA add-on helper)
RUN \
    mkdir -p /usr/bin && \
    curl -L -f -s "https://raw.githubusercontent.com/hassio-addons/bashio/master/bashio" \
        -o /usr/bin/bashio && \
    chmod a+x /usr/bin/bashio && \
    mkdir -p /usr/bin/bashio/lib && \
    curl -L -f -s "https://raw.githubusercontent.com/hassio-addons/bashio/master/lib/bashio" \
        -o /usr/bin/bashio/lib/bashio || true

# Copy run script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Use run.sh as entrypoint
ENTRYPOINT ["/run.sh"]
