FROM jarvvski/xenforo-2-php-fpm:alpine

# Install PHP pecl deps for installing php modules
RUN apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS;

RUN pecl install xdebug;
RUN docker-php-ext-enable xdebug;

# clear up php pecl deps
RUN apk del .phpize-deps

