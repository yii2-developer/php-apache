FROM php:7.3-apache

RUN apt-get update \

    && apt-get install -y --no-install-recommends nano mc wget openssl git sshpass cron supervisor sendmail unzip dnsutils iproute2 \

    && docker-php-ext-install bcmath \
    && docker-php-ext-enable bcmath \

    && docker-php-ext-install ctype \
    && docker-php-ext-enable ctype \

    && apt-get install -y --no-install-recommends libcurl4-openssl-dev \
    && docker-php-ext-install curl \
    && docker-php-ext-enable curl \

    && apt-get install -y --no-install-recommends libxml2-dev \
    && docker-php-ext-install dom \
    && docker-php-ext-enable dom \

    && docker-php-ext-install fileinfo \
    && docker-php-ext-enable fileinfo \

    && apt-get install -y --no-install-recommends libpng-dev libjpeg-dev libfreetype6-dev libgd-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-enable gd \

    && docker-php-ext-install hash \
    && docker-php-ext-enable hash \

    && docker-php-ext-install iconv \
    && docker-php-ext-enable iconv \

    && apt-get install -y --no-install-recommends libmagickwand-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \

    && docker-php-ext-install json \
    && docker-php-ext-enable json \

    && docker-php-ext-install mbstring \
    && docker-php-ext-enable mbstring \

    && docker-php-ext-install pdo \
    && docker-php-ext-enable pdo \

    && docker-php-ext-install session \
    && docker-php-ext-enable session \

    && docker-php-ext-install simplexml \
    && docker-php-ext-enable simplexml \

    && apt-get install -y --no-install-recommends libxml2-dev \
    && docker-php-ext-install soap \
    && docker-php-ext-enable soap \

    && docker-php-ext-install sockets \
    && docker-php-ext-enable sockets \

    && docker-php-ext-install xml \
    && docker-php-ext-enable xml \

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

    && apt-get install -y --no-install-recommends libldap2-dev \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install ldap \

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
COPY ./init.sh /init.sh

RUN chmod +x /docker-entrypoint/resolve-docker-host-ip.sh
RUN chmod +x /init.sh

COPY ./supervisor/cron.conf /etc/supervisor/conf.d/cron.conf
COPY ./supervisor/web-gui.conf /etc/supervisor/conf.d/web-gui.conf
COPY ./supervisor/application.conf /etc/supervisor/application.conf

ENTRYPOINT ["/docker-entrypoint/resolve-docker-host-ip.sh", "docker-php-entrypoint"]

CMD ["/init.sh"]
