# Static app — official nginx:alpine (Alpine 3.24.2)
FROM nginx:alpine

# Copy website files
COPY --chown=nginx:nginx . /usr/share/nginx/html

# Copy custom nginx config
COPY --chown=nginx:nginx nginx.conf /etc/nginx/nginx.conf

# Copy custom entrypoint
COPY --chown=nginx:nginx entrypoint.sh /docker-entrypoint-custom.sh
RUN chmod +x /docker-entrypoint-custom.sh

# Run as non-root nginx user
USER nginx

EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
    CMD wget -qO- http://127.0.0.1:8080/ >/dev/null 2>&1 || exit 1

ENTRYPOINT ["/docker-entrypoint-custom.sh"]
