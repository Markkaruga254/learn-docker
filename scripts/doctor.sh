#!/usr/bin/env bash
# Quick environment check for the labs.
ok(){ printf '  [ok]   %s\n' "$1"; }
bad(){ printf '  [FAIL] %s\n' "$1"; FAILED=1; }
echo "Docker Mastery environment check"
command -v docker >/dev/null && ok "docker CLI found: $(docker -v)" || bad "docker CLI not found (Module 01)"
if docker info >/dev/null 2>&1; then ok "daemon reachable"; else bad "cannot talk to daemon (is it running? are you in the docker group? try: sudo systemctl status docker)"; fi
docker compose version >/dev/null 2>&1 && ok "compose plugin: $(docker compose version --short 2>/dev/null)" || bad "docker compose plugin missing"
docker buildx version >/dev/null 2>&1 && ok "buildx present" || bad "buildx missing (optional until Module 09)"
command -v curl >/dev/null && ok "curl found" || bad "curl not found"
command -v git  >/dev/null && ok "git found"  || bad "git not found"
df -h / | awk 'NR==2{print "  [info] disk free on /: "$4" ("$5" used)"}'
[ -z "$FAILED" ] && echo "All good." || { echo "Fix the failures above."; exit 1; }
