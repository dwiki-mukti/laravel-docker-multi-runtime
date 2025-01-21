#!/bin/sh

# Start PHP-FPM
php-fpm -D

# Start Apache
httpd -D FOREGROUND