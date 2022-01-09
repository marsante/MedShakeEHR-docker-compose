# https://hub.docker.com/_/php
FROM php:7.4-apache

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

ENV PHP_MEMORY_LIMIT 512M
ENV PHP_UPLOAD_LIMIT 512M
RUN set -ex; \
    \
    savedAptMark="$(apt-mark showmanual)"; \
    \
    apt-get -y update;\
    #mkdir -p /usr/share/man/man1 && \
    apt-get install -y --no-install-recommends \
    #apt-utils \
    #curl \
    libmagickwand-dev \
    libgpgme11-dev \ 
    libyaml-dev \
    libc-client-dev \
    libcurl4-openssl-dev \
    libkrb5-dev \
    libonig-dev \
    libzip-dev \
    #wget \ 
    && \
    pecl install imagick \
    gnupg \
    yaml && \
    docker-php-ext-enable imagick gnupg yaml && \
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
    rm -rf /var/lib/apt/lists/* && \
    # rm -rf /var/lib/apt/lists/* && \
    a2enmod rewrite headers ssl && \
    rm -rf /usr/src/* 

ARG USER_ID
ARG GROUP_ID
ARG USER_NAME

RUN groupadd -f -g $GROUP_ID $USER_NAME && \
useradd -u $USER_ID -g $GROUP_ID $USER_NAME

USER ${USER_NAME}