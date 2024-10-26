FROM postgres:17

COPY ./init-postgres.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/init-postgres.sh

CMD ["init-postgres.sh"]
