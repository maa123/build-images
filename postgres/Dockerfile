FROM postgres:17

COPY ./init-postgres.sh /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/init-postgres.sh
