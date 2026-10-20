#!/usr/bin/env bash
# Usage: ./deploy.sh <image-tag>      e.g. ./deploy.sh git-abc1234
# Requires: DEPLOY_HOST (user@host), and the app directory already present on the server
#           (docker-compose.prod.yml, nginx.conf, .env). Rollback = run again with the previous tag.
set -euo pipefail

TAG="${1:?usage: deploy.sh <image-tag>}"
HOST="${DEPLOY_HOST:?set DEPLOY_HOST=user@host}"
APP_DIR="${APP_DIR:-/opt/app}"

# These values are embedded in a remote shell command below. Restrict them to
# conservative character sets before interpolation to prevent shell injection.
if [[ ! "$TAG" =~ ^[A-Za-z0-9_][A-Za-z0-9_.-]{0,127}$ ]]; then
  echo "Invalid image tag: use 1-128 letters, digits, underscores, dots, or hyphens; the first character must be a letter, digit, or underscore." >&2
  exit 2
fi

if [[ ! "$HOST" =~ ^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+$ ]]; then
  echo "Invalid DEPLOY_HOST: expected a simple user@host value." >&2
  exit 2
fi

if [[ ! "$APP_DIR" =~ ^/[A-Za-z0-9._/-]+$ ]] || [[ "$APP_DIR" == *"/../"* ]] || [[ "$APP_DIR" == */.. ]]; then
  echo "Invalid APP_DIR: use an absolute path without spaces or parent-directory segments." >&2
  exit 2
fi

command -v ssh >/dev/null 2>&1 || {
  echo "ssh is required but was not found in PATH." >&2
  exit 127
}

ssh "$HOST" "set -eu
  cd '$APP_DIR'
  export IMAGE_TAG='$TAG'
  docker compose -f docker-compose.prod.yml config -q
  docker compose -f docker-compose.prod.yml pull
  docker compose -f docker-compose.prod.yml up -d --remove-orphans
  docker compose -f docker-compose.prod.yml ps
  printf '%s\\n' '$TAG' > .last_deployed_tag"

echo "Deployed $TAG to $HOST"
