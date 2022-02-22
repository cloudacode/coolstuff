# SQLALCHEMY

Official docs: https://flask-sqlalchemy.palletsprojects.com/en/2.x/quickstart/ 

SQLite cli docs: https://sqlite.org/cli.html

- Create DB via sqlalchemy orm

    ```bash
    >>> from app import db
    >>> db.create_all()

    >>> from yourapplication import User
    >>> admin = User(username='admin', email='admin@example.com')
    >>> guest = User(username='guest', email='guest@example.com')

    >>> db.session.add(admin)
    >>> db.session.add(guest)
    >>> db.session.commit()

    >>> User.query.all()
    >>> User.query.filter_by(username='admin').first()
    ```

- Check tables, data via sqlalchemy cli

    ```bash
    $ sqlite3 temp.sqlite 
    sqlite> .table
    sqlite> .schema user
    sqlite> select * from user;
    1|admin|admin@example.com|2022-02-22 21:48:33.680056
    2|guest|guest@example.com|2022-02-22 21:48:33.681204
    ```
