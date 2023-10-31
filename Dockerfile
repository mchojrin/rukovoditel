FROM php:7.4-apache
LABEL authors="Mauro Chojrin <mauro.chojrin@leewayweb.com>"

RUN apt-get update && \
    apt-get install -y \
        libpng-dev \
        libzip-dev

RUN docker-php-ext-install gd && \
    docker-php-ext-install zip && \
    docker-php-ext-install mysqli

COPY ./app /var/www/html

RUN chown -R www-data.www-data /var/www/html/

FROM prod as dev

RUN pecl install xdebug-3.1.6 && \
    docker-php-ext-enable xdebug

