#!/bin/bash

set -e
cmd="$@"

until psql -h pg -U postgres -c "\l"; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

until redis-cli -h redis -r 1 KEYS test; do
  >&2 echo "Redis is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres & Redis are up - executing command(s)"
rails db:create
rails db:migrate
rails db:seed
