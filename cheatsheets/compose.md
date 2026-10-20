# Docker Compose cheat sheet

```yaml
services:
  api:
    build: ./app              # or image: name:tag
    ports: ["8000:8000"]
    environment:
      DB_HOST: db
    env_file: .env
    depends_on:
      db: { condition: service_healthy }
    volumes:
      - ./app:/app            # bind mount
      - data:/var/lib/x       # named volume
    networks: [backend]
    restart: unless-stopped
    healthcheck:
      test: ["CMD","curl","-f","http://localhost:8000/health"]
      interval: 10s
      timeout: 3s
      retries: 5
volumes:
  data:
networks:
  backend:
```

| Command | Purpose |
|---|---|
| `docker compose up -d` | Create/start everything (`--build` to rebuild) |
| `docker compose ps` | Status |
| `docker compose logs -f [svc]` | Logs |
| `docker compose exec svc sh` | Shell into a service |
| `docker compose stop` / `start` | Stop / start without removing |
| `docker compose down` | Remove containers + networks |
| `docker compose down -v` | …and named volumes (**deletes data**) |
| `docker compose config` | Validate and print the final config |
| `docker compose pull` / `build` | Fetch / build images |

Services reach each other by **service name** (`db`, `api`). YAML: **spaces only, no tabs**.
