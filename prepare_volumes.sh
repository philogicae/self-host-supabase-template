#!/bin/bash
set -e

# Add missing folders
mkdir -p "volumes/db/data"
mkdir -p "volumes/storage"
# Keep the tracked placeholder so reset/deploy cycles don't show it as deleted
touch "volumes/storage/.gitkeep"
