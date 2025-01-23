FROM dunglas/frankenphp:php8.3

RUN apt update -yqq && \
    apt install -yqq unzip libzip-dev && \
    docker-php-ext-install zip && \
    docker-php-ext-enable zip

WORKDIR /app
COPY --chown=www-data:www-data ./src /app

COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev --optimize-autoloader

ENV SERVER_NAME=":80"

EXPOSE 80