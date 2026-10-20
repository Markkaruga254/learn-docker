# Module 06 Assignments

**A6.1: WordPress + MySQL (or MariaDB).** Write a Compose file with `wordpress` + `db`, a named volume for the DB, env vars from a `.env` file (never committed), port 8080 → 80. Bring it up, finish the WordPress install, `down` and `up` again, and prove your site persisted.

**A6.2: Translate.** Convert this into Compose and back:
`docker run -d --name cache --network appnet -p 6379:6379 -v redisdata:/data --restart unless-stopped redis:7`

**A6.3: Add a healthcheck** to any service of yours and use `depends_on: condition: service_healthy`. Show the stack start in the right order.

**A6.4:** Explain the difference between `docker compose stop`, `down`, and `down -v`. When is each correct?

**A6.5 (stretch):** Use Compose `profiles` so that a `debug` service (e.g. adminer) only starts with `--profile debug`.
