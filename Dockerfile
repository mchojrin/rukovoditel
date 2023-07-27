FROM php:7.4-apache
LABEL authors="mauro"

RUN apt-get update && \
    apt-get install -y \
        libpng-dev \
        libzip-dev

RUN docker-php-ext-install gd

RUN docker-php-ext-install zip

RUN docker-php-ext-install mysqli

ADD app /var/www/html

RUN chown -R www-data.www-data /var/www/html