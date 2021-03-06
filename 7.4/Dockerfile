FROM php:7.4-apache

RUN apt-get update \

    && apt-get install -y --no-install-recommends nano mc wget openssl git sshpass cron supervisor sendmail unzip dnsutils iproute2 \

    && docker-php-ext-install bcmath \
    && docker-php-ext-enable bcmath \

    && apt-get install -y --no-install-recommends libpng-dev libjpeg-dev libwebp-dev libfreetype6-dev libgd-dev \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ --with-webp=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-enable gd \

    && apt-get install -y --no-install-recommends libmagickwand-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \

    && apt-get install -y --no-install-recommends libxml2-dev \
    && docker-php-ext-install soap \
    && docker-php-ext-enable soap \

    && docker-php-ext-install sockets \
    && docker-php-ext-enable sockets \

    && apt-get install -y --no-install-recommends libxslt1-dev \
    && docker-php-ext-install xsl \
    && docker-php-ext-enable xsl \

    && apt-get install -y --no-install-recommends libzip-dev zlib1g-dev \
    && docker-php-ext-install zip \
    && docker-php-ext-enable zip \

    && docker-php-ext-install opcache \
    && docker-php-ext-enable opcache \

    && docker-php-ext-install pcntl \
    && docker-php-ext-enable pcntl \

    && docker-php-ext-install exif \
    && docker-php-ext-enable exif \

    && apt-get install -y --no-install-recommends libldap2-dev \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install ldap \
    && docker-php-ext-enable ldap \

    && apt-get install -y --no-install-recommends openssl libssl-dev libcurl4-openssl-dev \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb \

    && apt-get install -y --no-install-recommends default-mysql-client \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-enable pdo_mysql \

    && mkdir /opt/tmp && cd /opt/tmp \
    && wget https://github.com/unicode-org/icu/releases/download/release-66-1/icu4c-66_1-src.tgz \
    && tar zxvf icu4c-66_1-src.tgz \
    && cd icu/source \
    && ./configure --prefix=/opt/icu661 && make && make install \
    && rm -rf /opt/tmp \

    && apt-get install -y --no-install-recommends libicu63 libicu-dev \
    && export PKG_CONFIG_PATH="/opt/icu661/lib/pkgconfig" \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-enable intl \

    && apt-get clean && apt-get autoclean && apt-get autoremove --purge -y

COPY ./apache/docker-php7.conf /etc/apache2/conf-available/

RUN ls -l /etc/apache2/conf-available/ \
    && sed -i 's#DocumentRoot.*#DocumentRoot /var/www/html/public#' /etc/apache2/sites-available/000-default.conf \
    && sed -i 's/^#AddDefault/AddDefault/' /etc/apache2/conf-available/charset.conf \
    && sed -i 's/ServerTokens OS/ServerTokens Prod/' /etc/apache2/conf-available/security.conf \
    && sed -i 's/ServerSignature On/ServerSignature Off/' /etc/apache2/conf-available/security.conf \
    && a2disconf docker-php \
    && a2enconf docker-php7 \
    && a2enmod rewrite expires

EXPOSE 80

COPY ./docker-entrypoint/ /docker-entrypoint/

RUN chmod +x /docker-entrypoint/resolve-docker-host-ip.sh
RUN chmod +x /docker-entrypoint/init.sh

COPY ./supervisor/cron.conf /etc/supervisor/conf.d/cron.conf
COPY ./supervisor/web-gui.conf /etc/supervisor/conf.d/web-gui.conf
COPY ./supervisor/application.conf /etc/supervisor/application.conf

CMD ["/docker-entrypoint/resolve-docker-host-ip.sh", "/docker-entrypoint/init.sh", "apache2-foreground"]
