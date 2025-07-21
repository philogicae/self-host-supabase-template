#!/bin/bash
set -e

# File locations
COMPOSE_FILE="compose.yaml"
VOLUME="supabase_data"

docker compose -f $COMPOSE_FILE down -v
docker volume rm "$VOLUME"