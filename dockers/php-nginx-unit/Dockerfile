FROM unit:php8.3

RUN apt-get update -yqq > /dev/null && \
    apt-get install -yqq bash curl git \
    libpng-dev libwebp-dev libjpeg-dev \
    libfreetype6-dev libicu-dev libtidy-dev libzip-dev > /dev/null

RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp --enable-gd
RUN docker-php-ext-install gd \
    exif \
    intl \
    opcache \
    tidy \
    gd \
    bcmath \
    sockets \
    zip

RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini;
ADD ./dockers/php-nginx-unit/config /docker-entrypoint.d/config

COPY --chown=www-data:www-data ./src /var/www
RUN chmod 777 -R /var/www

WORKDIR /var/www

COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev --optimize-autoloader --prefer-dist

EXPOSE 80
EXPOSE 9090
CMD ["unitd", "--no-daemon", "--control", "*:9090"]