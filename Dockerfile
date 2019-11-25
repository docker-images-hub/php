FROM php:7.2-fpm-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
&& set -eux \
&& apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS \
&& apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev icu-dev \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install pdo_mysql opcache intl gd \
&& pecl install -o -f redis && docker-php-ext-enable redis \
&& rm -rf /tmp/* \
&& apk del .phpize-deps
