#!/bin/bash
set -e

echo "Starting initialization script..."

echo "POSTGRES_USER: $POSTGRES_USER"
echo "POSTGRES_PASSWORD: $POSTGRES_PASSWORD"

echo "Waiting for PostgreSQL to be ready..."
until pg_isready -h postgres -U "$POSTGRES_USER"; do
    echo "Postgres not ready yet. Retrying in 2 seconds..."
    sleep 2
done

echo "PostgreSQL is ready. Checking and creating the 'metabase' database if it doesn't exist..."

PGPASSWORD="$POSTGRES_PASSWORD" psql -h postgres -U "$POSTGRES_USER" -d postgres -tc \
"SELECT 1 FROM pg_database WHERE datname = 'metabase'" | grep -q 1 || {
    echo "Database 'metabase' not found. Creating..."
    PGPASSWORD="$POSTGRES_PASSWORD" psql -h postgres -U "$POSTGRES_USER" -d postgres -c "CREATE DATABASE metabase;"
    echo "Database 'metabase' created successfully."
}

echo "Initialization complete!"