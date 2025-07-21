#!/bin/bash
set -e

# File locations
COMPOSE_FILE="compose.yaml"
VOLUME="supabase_data"

$DOCKER compose -f $COMPOSE_FILE down -v
$DOCKER volume rm "$VOLUME"