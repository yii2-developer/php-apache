FROM php:8.2-apache

RUN apt-get update \
    && apt-get install --yes --no-install-recommends nano mc wget dnsutils openssl cron supervisor git unzip p7zip-full \
    # bcmath
    && docker-php-ext-install bcmath \
    && docker-php-ext-enable bcmath \
    # gd
    && apt-get install --yes --no-install-recommends libpng-dev libjpeg-dev libwebp-dev libfreetype6-dev libgd-dev \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ --with-webp=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-enable gd \
    # imagick
    && apt-get install --yes --no-install-recommends libmagickwand-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    # soap
    && apt-get install --yes --no-install-recommends libxml2-dev \
    && docker-php-ext-install soap \
    && docker-php-ext-enable soap \
    # sockets
    && docker-php-ext-install sockets \
    && docker-php-ext-enable sockets \
    # xsl
    && apt-get install --yes --no-install-recommends libxslt1-dev \
    && docker-php-ext-install xsl \
    && docker-php-ext-enable xsl \
    # zip
    && apt-get install --yes --no-install-recommends libzip-dev zlib1g-dev \
    && docker-php-ext-install zip \
    && docker-php-ext-enable zip \
    # opcache
    && docker-php-ext-install opcache \
    && docker-php-ext-enable opcache \
    # pcntl
    && docker-php-ext-install pcntl \
    && docker-php-ext-enable pcntl \
    # exif
    && docker-php-ext-install exif \
    && docker-php-ext-enable exif \
    # ldap
    && apt-get install --yes --no-install-recommends libldap2-dev \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install ldap \
    && docker-php-ext-enable ldap \
    # mongodb
    && apt-get install --yes --no-install-recommends openssl libssl-dev libcurl4-openssl-dev \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb \
    # pdo_mysql
    && apt-get install --yes --no-install-recommends default-mysql-client \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-enable pdo_mysql \
    # pdo_pgsql
    && apt-get install --yes --no-install-recommends libpq-dev postgresql-client \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-enable pdo_pgsql \
    # icu
    && mkdir /opt/tmp && cd /opt/tmp \
    && wget https://github.com/unicode-org/icu/releases/download/release-72-1/icu4c-72_1-src.tgz \
    && tar zxvf icu4c-72_1-src.tgz \
    && cd icu/source \
    && ./configure --prefix=/opt/icu721 && make && make install \
    && rm -rf /opt/tmp \
    # intl
    && apt-get install --yes --no-install-recommends libicu72 libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-enable intl \
    # apt
    && apt-get clean && apt-get autoclean && apt-get autoremove --purge --yes

RUN a2enmod rewrite headers expires

COPY ./etc/apache2/ /etc/apache2/
COPY ./etc/supervisor/ /etc/supervisor/
COPY ./usr/local/bin/ /usr/local/bin/

WORKDIR /var/www/html/project

CMD ["initialize", "apache2-foreground"]
