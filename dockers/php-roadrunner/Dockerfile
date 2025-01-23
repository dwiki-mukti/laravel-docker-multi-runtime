FROM php:8.3-cli

RUN docker-php-ext-install pcntl sockets
RUN apt update && apt install -yqq \
    git zip unzip  

WORKDIR /app
COPY --chown=www-data:www-data ./src /app

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
RUN composer install --no-dev --optimize-autoloader && \
    composer require laravel/octane && \
    php artisan octane:install --server=roadrunner

CMD php artisan octane:start --server=roadrunner --port=8000 --host=0.0.0.0