FROM mariadb:latest

ENV MYSQL_ROOT_PASSWORD=mysecret
ENV MYSQL_DATABASE=todo

COPY init-table-todo.sql /docker-entrypoint-initdb.d/
