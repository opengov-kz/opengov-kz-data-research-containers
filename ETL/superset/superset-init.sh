#!/bin/sh
superset fab create-admin --username "$ADMIN_USERNAME" --firstname Admin --lastname Admin --email "$ADMIN_EMAIL" --password "$ADMIN_PASSWORD"

superset db upgrade

superset superset init 

/bin/sh -c /usr/bin/run-server.sh
