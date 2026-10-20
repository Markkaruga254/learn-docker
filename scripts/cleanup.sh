#!/usr/bin/env bash
# Safe-ish cleanup between modules. Shows what it will remove and asks first.
set -u
echo "Containers (all):"; docker ps -a --format '  {{.Names}}\t{{.Image}}\t{{.Status}}'
echo; echo "Disk usage:"; docker system df
echo
read -r -p "Remove ALL stopped containers, unused networks and dangling images? [y/N] " a
[ "${a:-N}" = "y" ] && { docker container prune -f; docker network prune -f; docker image prune -f; }
read -r -p "Also remove ALL unused volumes (DELETES DATA)? [y/N] " b
[ "${b:-N}" = "y" ] && docker volume prune -f
echo "Done."; docker system df
