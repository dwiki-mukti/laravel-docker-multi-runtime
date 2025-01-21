FROM phpswoole/swoole:5.1-php8.3

RUN docker-php-ext-install pcntl

WORKDIR /app
COPY --chown=www-data:www-data ./src /app

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
RUN composer install && \
    composer require laravel/octane && \
    php artisan octane:install --server=swoole

ENTRYPOINT php artisan octane:start --server=swoole --port=8000 --host=0.0.0.0
