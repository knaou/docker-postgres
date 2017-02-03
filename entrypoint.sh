#!/bin/sh

if [ ! -e "$PGDATA/postgresql.conf" ]; then
	chown postgres:postgres /postgresql-data
	su postgres -c "initdb --encoding=UNICODE"
	if [ "$DB_USER" != "" -a "$DB_PASSWORD" != "" -a "$DB_NAME" != "" ]; then
		if [ "$DB_ENCODING" == "" ]; then
			DB_ENCODING="utf8"
		fi
		su postgres -c "pg_ctl start"
		sleep 5
		echo "CREATE USER $DB_USER WITH NOSUPERUSER NOCREATEDB NOCREATEROLE PASSWORD '$DB_PASSWORD';" > /tmp/create_user.sql
		echo "CREATE DATABASE $DB_NAME OWNER $DB_USER ENCODING '$DB_ENCODING';" >> /tmp/create_user.sql
		su postgres -c "psql -f /tmp/create_user"
		su postgres -c "pg_ctl stop"
	fi
fi

su postgres -c "postgres"

