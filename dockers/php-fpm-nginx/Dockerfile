FROM php:8.3-fpm-alpine AS base

RUN apk add bash curl git \
    libpng-dev libwebp-dev libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    libxml2-dev \
    oniguruma-dev

RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp --enable-gd
RUN docker-php-ext-install gd mbstring xml zip opcache

WORKDIR /var/www
COPY --chown=www-data:www-data ./src .

COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev --optimize-autoloader --prefer-dist

COPY --from=nginx:alpine /usr/sbin/nginx /usr/sbin/nginx
COPY --from=nginx:alpine /etc/nginx /etc/nginx
COPY --from=nginx:alpine /usr/share/nginx /usr/share/nginx

COPY ./dockers/php-fpm-nginx/config/default.conf /etc/nginx/conf.d/
COPY ./dockers/php-fpm-nginx/config/nginx.conf /etc/nginx/
RUN addgroup -g 101 nginx && adduser -u 101 -G nginx -D nginx
RUN mkdir -p /var/log/nginx
RUN mkdir -p /var/cache/nginx/client_temp

EXPOSE 80

CMD php-fpm & nginx -g "daemon off;"
