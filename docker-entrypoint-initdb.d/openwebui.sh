#!/usr/bin/env bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<EOSQL
CREATE USER openwebui PASSWORD '$OPENWEBUI_PASSWORD';
CREATE DATABASE openwebui OWNER openwebui;
\c openwebui
CREATE EXTENSION vector;
SELECT * FROM pg_extension;
EOSQL
