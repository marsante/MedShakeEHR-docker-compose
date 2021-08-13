FROM php:7.4-apache

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    mkdir -p /usr/share/man/man1 && \
    apt-get -y --no-install-recommends install apt-utils \
    curl \
    ghostscript \
    git \
    imagemagick \
    libc-client-dev \
    libcurl4-openssl-dev \
    # for gpg
    libgpgme11-dev \ 
    libkrb5-dev \
    libmagickwand-dev \
    libonig-dev \
    libyaml-dev \
    libzip-dev \
    mariadb-client \
    pdftk \
    wget && \
    pecl install imagick \
    gnupg \
    yaml && \
    docker-php-ext-enable imagick gnupg yaml && \
    PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install curl \
    gd \
    imap \
    intl \
    mbstring \
    mysqli \
    soap \
    xml \
    zip && \
    rm -rf /var/lib/apt/lists/* && \
    a2enmod rewrite headers ssl && \
    rm -rf /usr/src/* 

ARG USER_ID
ARG GROUP_ID
ARG USER_NAME

RUN groupadd -f -g $GROUP_ID $USER_NAME && \
useradd -u $USER_ID -g $GROUP_ID $USER_NAME

USER ${USER_NAME}

