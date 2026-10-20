# Module 06 Labs

Use a new directory per lab. Compose v2 command is `docker compose` (with a space).

## Lab 6.1: Hello Compose (from the video)
```yaml
services:
  web:
    container_name: myweb
    image: nginx
    ports:
      - "8080:80"
```
```bash
docker compose up -d
docker compose ps
curl -I localhost:8080
docker network ls            # find <dir>_default
docker compose stop && docker compose start
docker compose down
```
Predict: after `stop`, does `docker ps -a` still show it? After `down`?

## Lab 6.2: Two services talking by name
```yaml
services:
  web:
    image: nginx:1.27-alpine
    ports: ["8080:80"]
  tester:
    image: alpine
    command: sh -c "apk add --no-cache curl >/dev/null && while true; do curl -s -o /dev/null -w '%{http_code}\n' http://web; sleep 5; done"
```
```bash
docker compose up -d
docker compose logs -f tester
```
Explain how `http://web` resolved.

## Lab 6.3: Database with env_file, volume, healthcheck
`.env`:
```
POSTGRES_USER=app
POSTGRES_PASSWORD=change-me-locally
POSTGRES_DB=appdb
```
`docker-compose.yml`:
```yaml
services:
  db:
    image: postgres:16
    env_file: .env
    volumes:
      - pgdata:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U $${POSTGRES_USER} -d $${POSTGRES_DB}"]
      interval: 5s
      timeout: 3s
      retries: 10
    restart: unless-stopped
  client:
    image: postgres:16
    env_file: .env
    depends_on:
      db:
        condition: service_healthy
    command: sh -c 'PGPASSWORD=$$POSTGRES_PASSWORD psql -h db -U $$POSTGRES_USER -d $$POSTGRES_DB -c "select now();"'
volumes:
  pgdata:
```
```bash
docker compose up
docker compose ps -a
docker compose down            # volume survives
docker compose up -d db && docker compose down -v   # now it's deleted
```
Questions: Why `$$`? What does the healthcheck change about startup order? Why is `.env` in `.gitignore`?

## Lab 6.4: Bind-mount dev loop
Serve `./html` through nginx using a read-only bind mount; edit the file and refresh.

## Lab 6.5: Networks and isolation
Extend Lab 6.3: add an `adminer` UI on a `frontend` network and keep `db` only on `backend`. Make adminer reach db through a service that's on both networks, or put adminer on both. Verify with `docker compose exec`.

## Lab 6.6: Break-and-fix
1. Replace two spaces with a tab in the YAML → read the error; use `docker compose config`.
2. Reference a service name that doesn't exist in `depends_on`.
3. Publish the same host port from two services.
4. Run `docker compose up` in the wrong directory.

## Lab 6.7: Operating a stack
```bash
docker compose up -d --build
docker compose logs -f --tail 20 db
docker compose exec db psql -U app -d appdb
docker compose restart db
docker compose config
docker compose down --remove-orphans
```
