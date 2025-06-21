#!/bin/bash

echo "⚠️  This will stop all services and delete containers, volumes, and networks."
read -p "Are you sure you want to proceed? (y/N): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "❌ Teardown cancelled."
  exit 0
fi

echo "🛑 Stopping and removing containers..."
docker compose down -v --remove-orphans

echo "🧼 Removing any leftover named containers (just in case)..."
docker rm -f wp-db wp-app wp-phpmyadmin &>/dev/null || true

echo "🧹 Cleaning Docker system cache (optional)..."
read -p "Also remove Docker build cache? (y/N): " cache_confirm
if [[ "$cache_confirm" == "y" || "$cache_confirm" == "Y" ]]; then
  docker builder prune -f
fi

echo "✅ Teardown complete. Your system is clean."
