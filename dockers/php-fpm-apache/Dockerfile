FROM php:8.3-fpm-alpine AS base

RUN apk add bash \
    libpng-dev libjpeg-turbo-dev libwebp-dev \
    freetype-dev \
    libzip-dev \
    libxml2-dev \
    oniguruma-dev \
    apache2 apache2-utils apache2-proxy apache2-proxy-html apache2-ssl

RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp --enable-gd && \
    docker-php-ext-install gd mbstring xml zip opcache

WORKDIR /var/www
COPY --chown=www-data:www-data ./src .
RUN chmod -R 775 /var/www

COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev --optimize-autoloader --prefer-dist

RUN sed -i 's/#LoadModule rewrite_module/LoadModule rewrite_module/' /etc/apache2/httpd.conf && \
    sed -i 's|#LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so|LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so|' /etc/apache2/httpd.conf

COPY ./dockers/php-fpm-apache/config/app.conf /etc/apache2/conf.d/app.conf

EXPOSE 80

COPY ./dockers/php-fpm-apache/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
