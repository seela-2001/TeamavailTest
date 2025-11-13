#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="/home/sohila/Documents/TeamavailTest/TeamavailTest"
cd "$PROJECT_DIR"

# Determine docker compose command (docker-compose or docker compose)
if command -v docker-compose >/dev/null 2>&1; then
  COMPOSE_CMD="docker-compose"
elif docker compose version >/dev/null 2>&1; then
  COMPOSE_CMD="docker compose"
else
  echo "Error: docker-compose (or docker compose) is not installed or not in PATH." >&2
  exit 1
fi

echo "Stopping containers..."
$COMPOSE_CMD down || true
echo "Containers stopped."
