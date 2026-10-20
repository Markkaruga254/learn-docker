#!/usr/bin/env bash
# Usage: ./deploy.sh <image-tag>      e.g. ./deploy.sh git-abc1234
# Requires: DEPLOY_HOST (user@host), and the app directory already present on the server
#           (docker-compose.prod.yml, nginx.conf, .env). Rollback = run again with the previous tag.
set -euo pipefail
TAG="${1:?usage: deploy.sh <image-tag>}"
HOST="${DEPLOY_HOST:?set DEPLOY_HOST=user@host}"
APP_DIR="${APP_DIR:-/opt/app}"

ssh "$HOST" "set -euo pipefail
  cd '$APP_DIR'
  export IMAGE_TAG='$TAG'
  docker compose -f docker-compose.prod.yml pull
  docker compose -f docker-compose.prod.yml up -d --remove-orphans
  docker compose -f docker-compose.prod.yml ps
  echo \"$TAG\" > .last_deployed_tag"
echo "Deployed $TAG to $HOST"
