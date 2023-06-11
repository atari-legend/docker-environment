FROM php:8.2-fpm-alpine

COPY --from=composer:2.5 /usr/bin/composer /usr/bin/composer

RUN apk update
RUN apk add mysql-client libzip-dev libpng-dev

RUN docker-php-ext-install gd

WORKDIR /var/www/html

RUN docker-php-ext-install pdo pdo_mysql zip pcntl
