#!/bin/sh

python manage.py makemigrations --no-input
python manage.py migrate --no-input
python manage.py collectstatic --no-input

# DJANGO_SUPERUSER_PASSWORD=$SUPER_USER_PASSWORD python manage.py createsuperuser --username $SUPER_USER_NAME --email $SUPER_USER_EMAIL --noinput
if [ "$SUPER_USER_NAME" ] && [ "$SUPER_USER_EMAIL" ] && [ "$SUPER_USER_PASSWORD" ]; then
    echo "슈퍼유저 자동 생성..."
    DJANGO_SUPERUSER_PASSWORD=$SUPER_USER_PASSWORD python manage.py createsuperuser \
        --username "$SUPER_USER_NAME" \
        --email "$SUPER_USER_EMAIL" --noinput || true
fi

# Gunicorn WSGI 서버를 통해 Django 애플리케이션을 실행
# config.wsgi:application 을 엔트리 포인트로 사용하며, 0.0.0.0:8000 포트로 바인딩하여 외부 요청을 수신
gunicorn config.wsgi:application --bind 0.0.0.0:8000
