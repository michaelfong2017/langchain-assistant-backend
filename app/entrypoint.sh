#!/usr/bin/env bash

echo "Running entrypoint.sh"
cd /app
#if [ -z "$POSTGRES_HOST" ]; then
#  # wait for postgre
#  until pg_isready -h db; do
#    echo "Postgres is unavailable - sleeping"
#    sleep 1
#  done
#  echo "Postgres is up - executing command"
#fi

python manage.py collectstatic --noinput  # Collect static files
# yes $'1\nyes' | python3 manage.py makemigrations
yes | python3 manage.py makemigrations
yes | python3 manage.py migrate                  # Apply database migrations

echo "Start runserver processes"
python manage.py runserver 0.0.0.0:8000