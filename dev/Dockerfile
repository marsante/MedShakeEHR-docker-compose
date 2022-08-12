# https://hub.docker.com/_/composer
FROM composer:2.0 as build
ENV VRELEASE master
RUN curl -fsSL -o /tmp/msehr.tar.gz https://github.com/MedShake/MedShakeEHR-base/archive/"$VRELEASE".tar.gz && \
tar -xf /tmp/msehr.tar.gz -C /var/www/html --strip-components=1
WORKDIR /var/www/html/
RUN composer install -o --ignore-platform-req php && cd public_html && composer install -o
COPY --chown=www-data:www-data config/MEDSHAKEEHRPATH-docker /var/www/html/public_html/MEDSHAKEEHRPATH

# https://hub.docker.com/_/php
FROM php:8.0-apache
ENV PHPSTAGE production
ARG DEBIAN_FRONTEND=noninteractive
RUN set -ex; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ghostscript \
        git \
        imagemagick \
        mariadb-client \
        pdftk \
    ; \
    rm -rf /var/lib/apt/lists/*
RUN set -ex; \
    \
    savedAptMark="$(apt-mark showmanual)"; \
    \
    apt-get -y update;\
    apt-get install -y --no-install-recommends \
    libmagickwand-dev \
    libgpgme11-dev \ 
    libyaml-dev \
    libc-client-dev \
    libcurl4-openssl-dev \
    libkrb5-dev \
    libonig-dev \
    libzip-dev \
    && \
    pecl install imagick && \
    pecl install gnupg && \
    pecl install yaml && \
    docker-php-ext-enable imagick gnupg yaml; \
    PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install \
    curl \
    dom \
    gd \
    imap \
    intl \
    mbstring \
    mysqli \
    soap \
    xml \
    zip && \
    apt-mark auto '.*' > /dev/null; \
    apt-mark manual $savedAptMark; \
    ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
        | awk '/=>/ { print $3 }' \
        | sort -u \
        | xargs -r dpkg-query -S \
        | cut -d: -f1 \
        | sort -u \
        | xargs -rt apt-mark manual; \
    rm -r /tmp/pear; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*; \
    a2enmod rewrite headers ssl; \
    rm -rf /usr/src/*; \
    mv "$PHP_INI_DIR/php.ini-$PHPSTAGE" "$PHP_INI_DIR/php.ini" && \
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/' "$PHP_INI_DIR/php.ini" && \
	sed -i 's/post_max_size = 8M/post_max_size = 20M/' "$PHP_INI_DIR/php.ini" && \
	sed -i 's/;max_input_vars = 1000/max_input_vars = 10000/' "$PHP_INI_DIR/php.ini"

WORKDIR /var/www/html/
COPY --from=build --chown=www-data:www-data /var/www/html ./
COPY --chown=1000:1000 config/vhost-docker /etc/apache2/sites-available/000-default.conf
COPY msehr.entrypoint /usr/local/bin/
ENTRYPOINT ["msehr.entrypoint"] 