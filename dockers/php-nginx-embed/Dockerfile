FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -yqq && apt install -yqq software-properties-common > /dev/null
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php > /dev/null

RUN apt upgrade -yqq > /dev/null && apt install -yqq \
    git wget zip \
    libxml2-dev systemtap-sdt-dev \
    zlib1g-dev libpcre3-dev libargon2-dev libsodium-dev libkrb5-dev \
    php8.3-cli php8.3-dev libphp8.3-embed php8.3-zip > /dev/null

ENV NGINX_VERSION 1.26.0

RUN git clone -b v0.0.29 --single-branch --depth 1 https://github.com/rryqszq4/ngx-php.git > /dev/null

RUN wget -q http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    tar -zxf nginx-${NGINX_VERSION}.tar.gz && \
    cd nginx-${NGINX_VERSION} && \
    export PHP_LIB=/usr/lib && \ 
    ./configure --user=www --group=www \
    --prefix=/nginx \
    --with-ld-opt="-Wl,-rpath,$PHP_LIB" \
    --add-module=/ngx-php/third_party/ngx_devel_kit \
    --add-module=/ngx-php > /dev/null && \
    make > /dev/null && make install > /dev/null

RUN sed -i "s|opcache.jit=off|;opcache.jit=off|g" /etc/php/8.3/embed/conf.d/10-opcache.ini

COPY --chown=www-data:www-data . /app
COPY --chown=www-data:www-data ./dockers/php-nginx-embed/plugin/Ngx /app/src/app/Ngx
COPY --chown=www-data:www-data ./dockers/php-nginx-embed/plugin/bin /app/src/bin

COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer
RUN cd /app/src && composer install --no-interaction --prefer-dist --no-dev

EXPOSE 8000

CMD /nginx/sbin/nginx -c /app/dockers/php-nginx-embed/nginx_default.conf 
