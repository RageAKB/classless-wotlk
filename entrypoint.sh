#!/bin/sh
# Create writable temp directories at runtime
mkdir -p /tmp/nginx /tmp/cache/nginx/client_temp /tmp/cache/nginx/proxy_temp /tmp/cache/nginx/fastcgi_temp /tmp/cache/nginx/uwsgi_temp /tmp/cache/nginx/scgi_temp /tmp/lib/nginx /tmp/log/nginx
chown -R nginx:nginx /tmp/nginx /tmp/cache/nginx /tmp/lib/nginx /tmp/log/nginx
exec nginx -g 'daemon off;'
