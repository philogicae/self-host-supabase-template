#!/bin/bash
set -e

./prepare_volumes.sh
echo "Starting Docker Compose services..."
docker compose up -d