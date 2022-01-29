import sqlalchemy
from sqlalchemy.ext.declarative import declarative_base
import os
from datetime import datetime

Base = declarative_base()

engine = sqlalchemy.create_engine("mysql+pymysql://"+ os.environ['DB_USER'] + ":" + os.environ['DB_PASSWORD']+ "@" + os.environ['DB_HOST'] + ":3306/" + os.environ['DB_NAME'],  echo=True)

class Employee(Base):
     __tablename__ = 'todo'
     id = sqlalchemy.Column(sqlalchemy.Integer, primary_key=True)
     content = sqlalchemy.Column(sqlalchemy.String(200), nullable=False)
     date_created = sqlalchemy.Column(sqlalchemy.DateTime, default=datetime.utcnow)

Base.metadata.create_all(engine)
