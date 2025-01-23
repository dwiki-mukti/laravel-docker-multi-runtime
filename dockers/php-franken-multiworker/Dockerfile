FROM php:8.3-cli
WORKDIR /app

RUN docker-php-ext-install pcntl

COPY --chown=www-data:www-data ./src .

RUN apt update && apt install -yqq \
    git zip unzip

COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer
RUN composer install --no-interaction --prefer-dist --no-dev && \
    composer require laravel/octane && \
    php artisan octane:install --server=frankenphp

EXPOSE 8000
CMD php artisan octane:start --server=frankenphp --port=8000 --host=0.0.0.0