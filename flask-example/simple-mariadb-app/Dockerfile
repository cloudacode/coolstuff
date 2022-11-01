FROM mariadb:latest

ENV MYSQL_ROOT_PASSWORD=mysecret
ENV MYSQL_DATABASE=cloud_user

COPY init-table-user.sql /docker-entrypoint-initdb.d/
