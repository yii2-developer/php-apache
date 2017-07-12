#!/usr/bin/env sh

supervisord -c /etc/supervisor/supervisord.conf

USER_ID=${APACHE_RUN_ID:-33}

if [ -n "$APACHE_RUN_USER" ]
then
    if ! id "$APACHE_RUN_USER" >/dev/null 2>&1; then
            useradd --shell=/bin/bash --home-dir="/var/www" --uid="$USER_ID" --user-group --non-unique "$APACHE_RUN_USER"
    fi

    CRON_FILE="/root/cron/tabs"
    if [ -f "$CRON_FILE" ]
    then
        crontab -u "$APACHE_RUN_USER" "$CRON_FILE"
    fi
fi

apache2-foreground
