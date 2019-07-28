FROM nginx:alpine

RUN apk --no-cache add shadow tini tzdata && \
    usermod -u 211000 nginx && \
    groupmod -g 211000 nginx

RUN chown -R nginx:nginx /etc/nginx && \
    rm -rf /etc/nginx/conf.d/*.conf && \
    mkdir -p /app

COPY startup.sh /app

COPY nginx_config/default.conf /etc/nginx/nginx.conf

COPY index.html /var/www/html

# Change all files owner to nginx user
RUN chown -R nginx:nginx /var/www/html
RUN chmod +x /app/startup.sh

USER nginx

ENTRYPOINT ["/sbin/tini","-sg","--","/app/startup.sh"]