FROM php:8.2-apache

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN apt-get update && apt-get install -y \
    build-essential \
    gnupg \
    libpng-dev \
    libjpeg62-turbo-dev \
    libwebp-dev \
    rsync \
    git \
    libzip-dev \
    libfreetype6-dev

RUN docker-php-ext-install pdo pdo_mysql mysqli zip
RUN docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype
RUN docker-php-ext-install gd

RUN a2enmod rewrite
RUN a2enmod expires
RUN a2enmod headers
RUN a2enmod deflate

RUN echo "max_execution_time = 180" > $PHP_INI_DIR/conf.d/max_execution_time.ini
RUN echo "upload_max_filesize = 16M" > $PHP_INI_DIR/conf.d/upload_max_filesize.ini
RUN echo "post_max_size = 16M" > $PHP_INI_DIR/conf.d/post_max_size.ini

ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
