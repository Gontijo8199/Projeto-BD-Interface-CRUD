#!/bin/bash
set -e

# root execution
if [ "$EUID" -ne 0 ]; then
  exec sudo bash "$0" "$@"
fi

WORKSPACE_DIR=$(pwd)

apt-get update -qq && apt-get install -y -qq postgresql postgresql-client

pg_ctlcluster 16 main start 2>/dev/null || service postgresql start

until su - postgres -c "pg_isready -q"; do
  sleep 1
done

# safe copy
cp "$WORKSPACE_DIR/scripts/DDL-create-tables-Spotify.sql" /tmp/
cp "$WORKSPACE_DIR/scripts/DML-insert-Spotify.sql" /tmp/
chown postgres:postgres /tmp/*.sql

sudo -u postgres psql -c "DROP DATABASE IF EXISTS \"Spotify\";"
sudo -u postgres psql -c "CREATE DATABASE \"Spotify\";"

sudo -u postgres psql -d "Spotify" -f "/tmp/DDL-create-tables-Spotify.sql"

sudo -u postgres psql -d "Spotify" -f "/tmp/DML-insert-Spotify.sql"

# optimização de indice
sudo -u postgres psql -d "Spotify" -c "CREATE INDEX IF NOT EXISTS idx_musica_nome ON Musica (nome_musica);"

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

rm -f /tmp/DDL-create-tables-Spotify.sql /tmp/DML-insert-Spotify.sql

echo "Setup completo"