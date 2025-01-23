FROM ubuntu:24.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -yqq && apt install -yqq software-properties-common

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && \
    apt upgrade -yqq && \
    apt install -yqq zip php8.3-cli php8.3-dev

WORKDIR /app
COPY --chown=www-data:www-data ./src /app

COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer
RUN composer install --no-interaction --prefer-dist --no-dev

EXPOSE 8000
CMD php artisan serve --host=0.0.0.0 --port=8000