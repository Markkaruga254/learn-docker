#!/usr/bin/env bash
# Verify that the published learning path has its expected files.
# This check is intentionally static: it does not require Docker or cloud credentials.
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

failures=0
checks=0

require_file() {
  local path="$1"
  checks=$((checks + 1))
  if [[ -f "$path" ]]; then
    printf 'PASS  %s\n' "$path"
  else
    printf 'FAIL  Missing required file: %s\n' "$path" >&2
    failures=$((failures + 1))
  fi
}

for module in \
  00-foundations \
  01-environment-setup \
  02-core-cli \
  03-networking \
  04-storage \
  05-dockerfiles \
  06-compose \
  07-registry \
  08-course-project \
  09-production-practices; do
  for file in README.md labs.md assignments.md quiz.md solutions.md; do
    require_file "modules/$module/$file"
  done
done

require_file "modules/10-capstones/README.md"
require_file "modules/10-capstones/tier1-static-site/README.md"
require_file "modules/10-capstones/tier2-api-db-proxy/README.md"
require_file "modules/10-capstones/tier3-secure-pipeline/README.md"

for file in \
  cheatsheets/docker-cli.md \
  cheatsheets/dockerfile.md \
  cheatsheets/compose.md \
  cheatsheets/networking-storage.md \
  cheatsheets/troubleshooting.md \
  assessment/final-exam.md \
  assessment/exam-solutions.md \
  assessment/broken-stack/docker-compose.yml \
  scripts/doctor.sh \
  scripts/cleanup.sh; do
  require_file "$file"
done

printf '\nChecked %d required paths; %d failure(s).\n' "$checks" "$failures"
if (( failures > 0 )); then
  exit 1
fi
