#!/bin/bash
set -e

# Add missing folders
mkdir -p "volumes/db/data"
mkdir -p "volumes/storage"

echo "Starting Docker Compose services..."
docker compose up -d