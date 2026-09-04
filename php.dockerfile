FROM php:8.5-fpm-alpine

COPY --from=composer:2.10 /usr/bin/composer /usr/bin/composer

RUN apk update
RUN apk add mysql-client libzip-dev libpng-dev

RUN docker-php-ext-install gd

WORKDIR /var/www/html

RUN docker-php-ext-install pdo pdo_mysql zip pcntl

# Code coverage driver, so `artisan test --coverage` works in this container
RUN apk add --no-cache --virtual .pcov-build-deps $PHPIZE_DEPS \
    && pecl install pcov \
    && docker-php-ext-enable pcov \
    && apk del .pcov-build-deps
