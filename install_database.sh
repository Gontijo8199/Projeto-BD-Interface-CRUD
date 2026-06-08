#!/bin/bash

sudo apt-get update && sudo apt-get install -y postgresql-client postgresql 
sudo service postgresql start

pg_isready

psql -U postgres -c "CREATE DATABASE \"Spotify\";"

psql -U postgres -d Spotify -f scripts/DDL-create-tables-Spotify.sql
psql -U postgres -d Spotify -f scripts/DML-insert-Spotify.sql

