FROM mariadb:latest

ENV MYSQL_ROOT_PASSWORD=mysecret
ENV MYSQL_DATABASE=cloud_user

COPY *.sql /docker-entrypoint-initdb.d/
