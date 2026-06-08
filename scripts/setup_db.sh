#!/bin/bash
set -e

sudo apt-get update -qq && sudo apt-get install -y -qq postgresql postgresql-client

sudo service postgresql start

until sudo -u postgres pg_isready -q; do
  sleep 1
done

sudo -u postgres psql -c "DROP DATABASE IF EXISTS \"Spotify\";"
sudo -u postgres psql -c "CREATE DATABASE \"Spotify\";"

sudo -u postgres psql -d "Spotify" -f scripts/DDL-create-tables-Spotify.sql

sudo -u postgres psql -d "Spotify" -f scripts/DML-insert-Spotify.sql

sudo -u postgres psql -c "
  DO \$\$
  BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'spotifyuser') THEN
      CREATE USER spotifyuser WITH PASSWORD 'spotifypass';
    END IF;
  END
  \$\$;
  GRANT ALL PRIVILEGES ON DATABASE \"Spotify\" TO spotifyuser;
"

sudo -u postgres psql -d "Spotify" -c "
  GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO spotifyuser;
  GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO spotifyuser;
"
