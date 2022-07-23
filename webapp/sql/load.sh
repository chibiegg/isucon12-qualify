#!/bin/sh

set -ex
cd `dirname $0`

ISUCON_DB_HOST=${ISUCON_DB_HOST:-192.168.0.13}
ISUCON_DB_PORT=${ISUCON_DB_PORT:-3306}
ISUCON_DB_USER=${ISUCON_DB_USER:-isucon}
ISUCON_DB_PASSWORD=${ISUCON_DB_PASSWORD:-isucon}
ISUCON_DB_NAME=${ISUCON_DB_NAME:-isuports}



mysql -u"$ISUCON_DB_USER" \
                -p"$ISUCON_DB_PASSWORD" \
                --host "$ISUCON_DB_HOST" \
                --port "$ISUCON_DB_PORT" \
                "$ISUCON_DB_NAME" < admin/10_schema.sql

# MySQLを初期化
mysql -u"$ISUCON_DB_USER" \
		-p"$ISUCON_DB_PASSWORD" \
		--host "$ISUCON_DB_HOST" \
		--port "$ISUCON_DB_PORT" \
		"$ISUCON_DB_NAME" < admin/90_data.sql

