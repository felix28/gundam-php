FROM php:8.2-fpm-alpine

# Set working directory
WORKDIR /var/www/html

RUN apk update && apk add --no-cache oniguruma-dev libzip-dev \
    # Install MySQL extensions
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl

# Copy existing application directory contents with directory permissions
COPY --chown=www-data:www-data . /var/www/html

# Copy the startup script
COPY start.sh /usr/local/bin/start
RUN chmod u+x /usr/local/bin/start

# Expose the webroot directory to NGINX container
VOLUME ["/var/www/html/public"]

# Expose port 9000 of the php-fpm server
EXPOSE 9000
CMD ["/usr/local/bin/start"]