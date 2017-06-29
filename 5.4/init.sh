#!/usr/bin/env sh

supervisord -c /etc/supervisor/supervisord.conf

if [ -n "$APACHE_RUN_USER" ]
then
    if ! id "$APACHE_RUN_USER" >/dev/null 2>&1; then
            useradd --shell=/bin/bash --home-dir="/var/www" "$APACHE_RUN_USER"
    fi

    CRON_FILE="/root/cron/tabs"
    if [ -f "$CRON_FILE" ]
    then
        crontab -u "$APACHE_RUN_USER" "$CRON_FILE"
    fi
fi

apache2-foreground
