FROM php:8-fpm-alpine

RUN apk update
RUN apk add mysql-client libzip-dev

WORKDIR /var/www/html

RUN docker-php-ext-install pdo pdo_mysql zip pcntl
