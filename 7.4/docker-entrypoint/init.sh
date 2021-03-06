#!/usr/bin/env sh

set -e

supervisord --configuration /etc/supervisor/supervisord.conf

if [ -n "$APACHE_RUN_USER" ] && [ -n "$APACHE_RUN_GROUP" ]; then
  if ! id "$APACHE_RUN_USER" >/dev/null 2>&1; then
    APACHE_RUN_ID=${APACHE_RUN_ID:-33}

    groupadd --gid="$APACHE_RUN_ID" --non-unique "$APACHE_RUN_GROUP"
    useradd --shell=/bin/bash --home-dir="/var/www" --uid="$APACHE_RUN_ID" --gid="$APACHE_RUN_ID" --non-unique "$APACHE_RUN_USER"
  fi

  if [ -f "$CRON_FILE" ]; then
    crontab -u "$APACHE_RUN_USER" "$CRON_FILE"
  fi

  su --command="supervisord --configuration /etc/supervisor/application.conf" "$APACHE_RUN_USER"
fi

exec "$@"
