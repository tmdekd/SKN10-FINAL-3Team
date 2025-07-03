#!/bin/sh

python manage.py makemigrations
python manage.py migrate --noinput
python manage.py collectstatic --noinput

gunicorn config.wsgi:application --bind 0.0.0.0:8000 &
unlink /etc/nginx/sites-enabled/default

nginx -g 'daemon off;'