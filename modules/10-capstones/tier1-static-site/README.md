# Capstone Tier 1: Static site → registry → live

**Brief:** A friend runs a small bakery and has a static site. Containerize it, publish it, and run it
on a fresh server straight from the registry.

## Requirements
1. Any static site (your own, a template, or Module 08's starter).
2. Dockerfile on a pinned nginx base; `.dockerignore`.
3. Custom `nginx.conf`: gzip on, `/healthz` returns 200, custom 404 page, security headers (`X-Content-Type-Options`, `X-Frame-Options`).
4. Image pushed to Docker Hub or GHCR with tags `1.0.0`, `1.0`, and `git-<sha>`.
5. Compose file for running it (`restart: unless-stopped`, healthcheck).
6. **Clean-host proof:** on a machine with no source code, one command brings the site up from the registry.
7. README with architecture, run, update and rollback instructions.

## Stretch
Run as non-root (`nginx-unprivileged`); image under 30 MB; add HTTPS with a reverse proxy (Caddy/Traefik) and a real domain.

## Self-check
- [ ] `docker run` from a clean host works
- [ ] `curl -I /healthz` → 200
- [ ] Image has no `.git` or README inside
- [ ] Rollback to `1.0.0` tested
