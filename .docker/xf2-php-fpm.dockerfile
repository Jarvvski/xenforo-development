FROM php:7.3-fpm

RUN apt-get update && apt-get install -y wget libapache2-mod-fcgid libfcgi-bin \
    libmcrypt-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    mariadb-client libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && pecl install xdebug \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install pdo_mysql mysqli gd \
    && docker-php-ext-enable imagick

# Install health check tool for use in container health check
# https://github.com/renatomefi/php-fpm-healthcheck
RUN wget -O /usr/local/bin/php-fpm-healthcheck \
    https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/master/php-fpm-healthcheck \
    && chmod +x /usr/local/bin/php-fpm-healthcheck

RUN set -xe && echo "pm.status_path = /status" >> /usr/local/etc/php-fpm.d/zz-docker.conf
