#!/bin/bash

echo "🚀 Starting WordPress + MySQL + Apache setup..."

# Check .env exists
if [ ! -f .env ]; then
  echo "❌ .env file missing. Aborting."
  exit 1
fi

# Export environment variables
export $(grep -v '^#' .env | xargs)

# Build and run Docker containers
docker compose up -d --build

echo "⏳ Waiting for MySQL to be ready..."
until docker exec wp-db mysqladmin ping -u root -p${MYSQL_ROOT_PASSWORD} --silent &>/dev/null; do
  echo "🔄 MySQL not ready yet. Retrying..."
  sleep 2
done

# Optional DB import
if [ -f db-dump.sql ]; then
  echo "📦 Importing db-dump.sql..."
  docker cp db-dump.sql wp-db:/db-dump.sql
  docker exec wp-db bash -c "mysql -u root -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} < /db-dump.sql"
else
  echo "ℹ️ No db-dump.sql found. Skipping import."
fi

echo "✅ WordPress is running at: http://localhost:${WP_PORT}"
echo "🔐 phpMyAdmin is available at: http://localhost:${PHPMYADMIN_PORT}"
