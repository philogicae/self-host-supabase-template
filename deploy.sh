#!/bin/bash
set -e

# File locations
COMPOSE_FILE="compose.yaml"
VOLUME="supabase_data"
INIT_VOLUMES="init_volumes"

# Create data volume if it doesn't exist
echo "Checking if volume '$VOLUME' exists..."
if ! docker volume inspect "$VOLUME" &> /dev/null; then
    docker volume create "$VOLUME" &> /dev/null
    echo "Volume '$VOLUME' created."
    echo "Copying content from '$INIT_VOLUMES' to '$VOLUME'..."
    docker run -d --name tmp -v $VOLUME:/tmp_data alpine tail -f /dev/null &> /dev/null
    docker cp $INIT_VOLUMES/. tmp:/tmp_data &> /dev/null
    docker rm tmp -f &> /dev/null
else
    echo "Volume '$VOLUME' already exists. Skipping creation."
fi

echo "Starting Docker Compose services..."
docker compose -f $COMPOSE_FILE up -d