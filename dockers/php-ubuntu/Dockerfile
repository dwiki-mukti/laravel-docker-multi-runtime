FROM ubuntu:24.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -yqq && apt-get install -yqq software-properties-common > /dev/null

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php > /dev/null && \
    apt-get update -yqq > /dev/null && apt-get upgrade -yqq > /dev/null

RUN apt-get update -yqq > /dev/null && \
    apt-get install -yqq wget git libxml2-dev systemtap-sdt-dev \
    zlib1g-dev libpcre3-dev libargon2-dev libsodium-dev libkrb5-dev \
    php8.3-cli php8.3-dev libphp8.3-embed php8.3-zip > /dev/null

WORKDIR /app
COPY --chown=www-data:www-data ./src /app

COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer
RUN composer install --no-interaction --prefer-dist --no-dev

EXPOSE 8000
CMD php artisan serve --host=0.0.0.0 --port=8000