#!/usr/bin/env bash
# End-to-end smoke test for the Tier 2 API/database/proxy capstone.
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CAPSTONE_DIR="$ROOT_DIR/modules/10-capstones/tier2-api-db-proxy/reference"
cd "$CAPSTONE_DIR"

cleanup() {
  docker compose down -v --remove-orphans >/dev/null 2>&1 || true
  rm -f .env
}
trap cleanup EXIT

fail() {
  echo "FAIL: $*" >&2
  docker compose ps >&2 || true
  docker compose logs --no-color >&2 || true
  exit 1
}

wait_for_ready() {
  local attempt
  for attempt in $(seq 1 60); do
    if curl --fail --silent --show-error http://127.0.0.1:8080/ready >/dev/null 2>&1; then
      return 0
    fi
    sleep 2
  done
  fail "API did not become ready through the reverse proxy within 120 seconds"
}

visit_count() {
  curl --fail --silent --show-error http://127.0.0.1:8080/visits |
    sed -n 's/.*"visits":[[:space:]]*\([0-9][0-9]*\).*/\1/p'
}

printf 'POSTGRES_DB=ci_test\nPOSTGRES_USER=ci_test\nPOSTGRES_PASSWORD=ci_test\n' > .env

echo "Starting Tier 2 capstone..."
docker compose up --build -d
wait_for_ready

health="$(curl --fail --silent --show-error http://127.0.0.1:8080/health)"
[[ "$health" == *'"status":"ok"'* ]] || fail "Unexpected /health response: $health"

ready="$(curl --fail --silent --show-error http://127.0.0.1:8080/ready)"
[[ "$ready" == *'"status":"ready"'* ]] || fail "Unexpected /ready response: $ready"

first="$(visit_count)"
second="$(visit_count)"
[[ "$first" == "1" && "$second" == "2" ]] ||
  fail "Visit counter should increment from 1 to 2; got '$first' then '$second'"

echo "Checking that the proxy cannot reach PostgreSQL directly..."
if docker compose exec -T proxy sh -c 'nc -z -w 2 db 5432' >/dev/null 2>&1; then
  fail "Proxy can reach PostgreSQL; network isolation is broken"
fi

echo "Checking named-volume persistence across container recreation..."
docker compose down
docker compose up -d
wait_for_ready
persisted="$(visit_count)"
[[ "$persisted" == "3" ]] ||
  fail "Expected persisted counter to continue at 3 after docker compose down/up; got '$persisted'"

echo "Checking API restart and recovery..."
docker compose restart api
wait_for_ready
recovered="$(visit_count)"
[[ "$recovered" == "4" ]] ||
  fail "Expected API to recover and counter to continue at 4; got '$recovered'"

echo "PASS: health, readiness, proxy routing, visit writes, network isolation, volume persistence, and API restart recovery."
