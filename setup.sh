#!/bin/bash

echo "🚀 Starting WordPress + MySQL + Apache setup..."

# Ensure .env exists
if [ ! -f .env ]; then
  echo "❌ .env file missing. Aborting."
  exit 1
fi

# Export .env variables
export $(grep -v '^#' .env | xargs)

# Stop and remove existing containers if they exist
echo "🧹 Cleaning up old containers..."
docker rm -f wp-db wp-app wp-phpmyadmin &>/dev/null || true

# Remove old volumes/networks
docker compose down -v &>/dev/null

# Build and start containers
echo "🔧 Building and starting containers..."
docker compose up -d --build

# Wait for MySQL
echo "⏳ Waiting for MySQL to be ready..."
until docker exec wp-db mysqladmin ping -u root -p${MYSQL_ROOT_PASSWORD} --silent &>/dev/null; do
  echo "🔄 Waiting for MySQL..."
  sleep 2
done

# Import DB if file exists
if [ -f db-dump.sql ]; then
  echo "📦 Importing db-dump.sql into MySQL..."
  docker cp db-dump.sql wp-db:/db-dump.sql
  docker exec wp-db bash -c "mysql -u root -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} < /db-dump.sql"
else
  echo "ℹ️ No db-dump.sql found. Skipping import."
fi

# Set correct permissions for wp-content
echo "🔒 Fixing file permissions..."
docker exec wp-app chown -R www-data:www-data /var/www/html/wp-content

# Success message
echo ""
echo "✅ WordPress is running at: http://localhost:${WP_PORT}"
echo "🔐 phpMyAdmin is running at: http://localhost:${PHPMYADMIN_PORT}"
