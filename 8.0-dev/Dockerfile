# https://hub.docker.com/_/php
FROM php:8.1-apache
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
    libc-client-dev \
    libcurl4-openssl-dev \
    libgpgme11-dev \
    libkrb5-dev \
    libmagickwand-dev \
    libonig-dev \
    libyaml-dev \
    libzip-dev \
    && \
    pecl install gnupg && \
    pecl install imagick && \
    pecl install yaml && \
    docker-php-ext-enable gnupg imagick yaml; \
    PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install \
    bcmath \
    curl \
    dom \
    gd \
    imap \
    intl \
    mbstring \
    pdo_mysql \
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
	sed -i 's/;max_input_vars = 1000/max_input_vars = 20000/' "$PHP_INI_DIR/php.ini"

COPY --from=composer:2.2 /usr/bin/composer /usr/local/bin/composer
COPY config/vhost-docker /etc/apache2/sites-available/000-default.conf
ENV VRELEASE master
RUN curl -fsSL -o /tmp/msehr.tar.gz https://github.com/MedShake/MedShakeEHR-base/archive/"$VRELEASE".tar.gz && \
mkdir /usr/src/medshakeehr && \
tar -xf /tmp/msehr.tar.gz -C /usr/src/medshakeehr --strip-components=1 && \
rm /tmp/msehr.tar.gz
COPY config/MEDSHAKEEHRPATH-docker /usr/src/medshakeehr/public_html/MEDSHAKEEHRPATH
VOLUME /var/www/html/
COPY msehr.entrypoint /usr/local/bin/
ENTRYPOINT ["msehr.entrypoint"] 
CMD ["apache2-foreground"]