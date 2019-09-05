#!/usr/bin/env sh

supervisord -c /etc/supervisor/supervisord.conf

USER_ID=${APACHE_RUN_ID:-33}

if [ -n "$APACHE_RUN_USER" ]
then
    if ! id "$APACHE_RUN_USER" >/dev/null 2>&1; then
        groupadd --gid="$USER_ID" --non-unique "$APACHE_RUN_USER"
        useradd --shell=/bin/bash --home-dir="/var/www" --uid="$USER_ID" --gid="$USER_ID" --non-unique "$APACHE_RUN_USER"
    fi

    if [ -z "$CRON_FILE" ]
    then
        CRON_FILE="/var/spool/cron/config/crontab"
    fi

    if [ -f "$CRON_FILE" ]
    then
        crontab -u "$APACHE_RUN_USER" "$CRON_FILE"
    fi
fi

su --command="supervisord -c /etc/supervisor/application.conf" "$APACHE_RUN_USER"

apache2-foreground
