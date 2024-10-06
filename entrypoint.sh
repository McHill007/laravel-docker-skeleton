#!/bin/bash

echo "Version 1.0"

cd /var/www


if [ -z "$( ls -A '/var/www/app' )" ]; then
    echo "Laravel app does not exists! Creating new app..."
    laravel new app2 --force -n
    shopt -s dotglob
    mv /var/www/app2/* /var/www/app
    rm -rfd /var/www/app2
    echo "Setting permissions for laravel app..."
    chown -R www-data:www-data "app/storage" "app/bootstrap/cache" "app/database/database.sqlite"
    chmod -R 775 "app/storage" "app/bootstrap/cache" "app/database/database.sqlite"
    echo "Permissions successfully set."  
else
    echo "Laravel app already exists!!!"
fi

echo "Starting supervisord..."
supervisord -c /etc/supervisor/supervisord.conf  