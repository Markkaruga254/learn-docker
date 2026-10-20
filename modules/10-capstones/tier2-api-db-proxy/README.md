# Capstone Tier 2: API + database + reverse proxy

**Brief:** Ship a small web API backed by PostgreSQL behind an nginx reverse proxy, runnable with one command.

## Architecture
```
client ──▶ proxy (nginx :8080) ──▶ api (Flask/gunicorn :8000) ──▶ db (Postgres, volume)
           [frontend net]          [frontend + backend nets]       [backend net only]
```

## Requirements
**API** (any language; reference is Python/Flask)
- `GET /health` → 200 (no DB needed)
- `GET /ready` → 200 only if the DB is reachable
- `GET /visits` → inserts a row and returns the total number of visits as JSON

**Containers**
1. `api` has its own Dockerfile: pinned base, deps layer cached, **non-root**, gunicorn, healthcheck, `.dockerignore`.
2. `db` is `postgres:16` (pinned) with a **named volume**; healthcheck with `pg_isready`.
3. `proxy` is nginx with a mounted, read-only config; the **only** published port.
4. Networks: `frontend` (proxy, api) and `backend` (api, db). The proxy **must not** be able to reach `db`.
5. API starts only after the DB is healthy (`depends_on: condition: service_healthy`).
6. Credentials come from `.env` (not committed); provide `.env.example`.
7. `restart: unless-stopped`, memory limit on the api service.

## Tests you must be able to demonstrate
- `curl localhost:8080/visits` increments across calls.
- `docker compose down` then `up -d`: the count **persists**.
- `docker compose down -v` resets it.
- `docker compose exec proxy sh -c 'nc -zv db 5432'` **fails**.
- Kill the api container: it restarts and traffic recovers.

## Deliverables
Repo folder with `docker-compose.yml`, `app/`, `nginx.conf`, `.env.example`, `README.md` (run/test/teardown), and a short `NOTES.md` on three problems you hit and how you solved them.

## Stretch
Add Redis caching for a `/stats` endpoint · migrations on startup · log shipping to a file volume · Compose `profiles` for an Adminer debug UI.

## Reference
A working solution is in `reference/`. **Try first.**
Run it: `cd reference && cp .env.example .env && docker compose up -d --build`.
