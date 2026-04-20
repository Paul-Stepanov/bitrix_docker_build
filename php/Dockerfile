FROM php:8.3-fpm
LABEL authors="pstepanov"

# UID пользователя на хосте
ENV USER_ID=1000

ARG NODE_VERSION=22
ARG PHP_INI_TYPE=development
ENV PHP_INI_TYPE=${PHP_INI_TYPE}

WORKDIR /var/www/html

# Системные пакеты + Node.js + PHP-расширения + Xdebug (один слой)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl mc nano git zip unzip cron htop imagemagick \
    libpng-dev libjpeg-dev libtiff-dev libmcrypt-dev libmagickwand-dev \
    libicu-dev libzip-dev libc-dev pkg-config libcurl4-openssl-dev libssl-dev \
    libfreetype6-dev libjpeg62-turbo-dev \
    && curl -sSL https://deb.nodesource.com/setup_${NODE_VERSION}.x -o /tmp/nodesource_setup.sh \
    && bash /tmp/nodesource_setup.sh \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -f /tmp/nodesource_setup.sh \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg=/usr/local/lib \
    && docker-php-ext-install pdo pdo_mysql gd mysqli zip exif opcache intl \
    && pecl install imagick && docker-php-ext-enable imagick \
    && pecl install igbinary && docker-php-ext-enable igbinary \
    && printf "yes\nno\nno\n" | pecl install redis && docker-php-ext-enable redis \
    && pecl install xdebug \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Composer
COPY --from=composer:2.8.8 /usr/bin/composer /usr/bin/composer

# Создаём непривилегированного пользователя до переключения
RUN usermod -u ${USER_ID} www-data \
    && mkdir -p /var/log/php \
    && chown -R www-data:www-data /var/log/php \
    && chmod -R 775 /var/log/php

# Конфигурация PHP: базовый ini + кастомный override
RUN cp /usr/local/etc/php/php.ini-${PHP_INI_TYPE} /usr/local/etc/php/php.ini

COPY ./www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./setup-cron.sh /usr/local/bin/setup-cron.sh
RUN chmod +x /usr/local/bin/setup-cron.sh

EXPOSE 9000

# Мастер-процесс php-fpm стартует от root, воркеры — от www-data (см. www.conf)
CMD ["setup-cron.sh"]