#!/bin/bash
set -e

echo "Stopping Docker Compose services..."
docker compose down -v --remove-orphans
rm -r volumes
git reset --hard
./prepare_volumes.sh