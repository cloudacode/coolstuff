#!/bin/sh
gunicorn main:app -w 2 --threads 2 -b 0.0.0.0:$PORT --access-logfile - --error-logfile -