#!/bin/sh

#env=${APP_ENV:-production}

if [ "$env" != "local" ]; then
    (cd /var/www/html && php artisan config:cache && php artisan route:cache && php artisan view:cache)
fi

exec /usr/local/sbin/php-fpm