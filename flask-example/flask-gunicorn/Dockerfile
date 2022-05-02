FROM python:3.9-slim
COPY requirements.txt /
RUN pip3 install -r /requirements.txt
COPY . /app
WORKDIR /app
ENV PORT 8000
ENTRYPOINT ["./gunicorn.sh"]