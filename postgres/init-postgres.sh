#!/bin/bash

# データベースが初期化済みかつPOSTGRES_USER, POSTGRES_PASSWORDが設定されている場合
if [ -f "$PGDATA/PG_VERSION" ] && [ -n "$POSTGRESQL_USER" ] && [ -n "$POSTGRESQL_PASSWORD" ]; then
    # パスワードを更新
    postgres -c "psql -c \"ALTER USER $POSTGRESQL_USER WITH PASSWORD '$POSTGRESQL_PASSWORD';\""
fi
