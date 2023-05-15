#!/bin/bash

# Install dependencies
apt-get update -y && apt-get install -y \
    apt-utils \
    g++ \
    build-essential \
    libbz2-dev \
    libonig-dev \
    libedit-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmagickwand-dev \
    libmemcached-dev \
    libssl-dev \
    libreadline-dev \
    libzip-dev \
    libpng-dev \
    libcurl4-openssl-dev \
    locales \
    wget \
    unzip \
    zlib1g-dev \
    vim \
    git \
    mc \
    nano \
    mariadb-client \
    openssl \
    zip \
    curl \
    ssh \
    imagemagick \
    libssh2-1-dev \
    libgmp-dev \
    libssh2-1 \
    libc-client-dev \
    libkrb5-dev \
    gettext-base

# Install extensions
docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) gd \
  && docker-php-ext-configure intl \
  && docker-php-ext-install -j$(nproc) intl \
  && docker-php-ext-install -j$(nproc) \
     bcmath \
     gmp \
     bz2 \
     calendar \
     exif \
     gettext \
     mysqli \
     opcache \
     pdo_mysql \
     soap \
     sockets \
     curl \
     xml \
     exif \
     pcntl \
     mbstring \
  && docker-php-ext-configure zip \
  && docker-php-ext-install zip \
  && pecl install xdebug-3.2.0 && docker-php-ext-enable xdebug \
  && pecl install memcached-3.2.0 && docker-php-ext-enable memcached \
  && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
  && docker-php-ext-install -j$(nproc) imap
  
# Adhoc change to avoid "SSL connect attempt failed error:141A318A:SSL routines:tls_process_ske_dhe:dh key too small" error
sed -i -e "s#CipherString = DEFAULT@SECLEVEL=2#\#CipherString = DEFAULT@SECLEVEL=2#" "/etc/ssl/openssl.cnf"