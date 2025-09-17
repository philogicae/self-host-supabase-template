#!/bin/bash
set -e

docker compose down -v --remove-orphans
rm -r volumes
git reset --hard