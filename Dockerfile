FROM php:7.4-apache as prod

LABEL authors="Mauro Chojrin <mauro.chojrin@leewayweb.com>"

RUN apt-get update && \
    apt-get install -y \
        libpng-dev \
        libzip-dev

RUN docker-php-ext-install gd && \
    docker-php-ext-install zip && \
    docker-php-ext-install mysqli

ADD app /var/www/html

RUN chown -R www-data.www-data /var/www/html

FROM prod as dev

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN usermod -u $USER_ID www-data && \
    groupmod -g $GROUP_ID www-data

RUN pecl install xdebug-3.1.6 && \
    docker-php-ext-enable xdebug