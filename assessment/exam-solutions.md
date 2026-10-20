# Final exam solutions

## Part A (key points)
1. VM = own guest OS and kernel on a hypervisor; container = isolated process sharing the host kernel.
2. Namespaces isolate what a process sees (PID, net, mount, UTS, IPC, user); cgroups limit/account resources (CPU, memory, pids, I/O).
3. CLI → dockerd → containerd → runC → process.
4. Its default command (`bash`) exits without a TTY/stdin, so the main process ends.
5. `-p 80:80` is after the image name, so it's passed to the container's command rather than to Docker.
6. The default bridge lacks embedded DNS; use a user-defined network (or Compose).
7. It's deleted.
8. Live code editing in development or mounting a specific host path/file; use volumes for production state.
9. Each instruction is a read-only layer; unchanged layers (and everything before the first changed one) are reused from cache.
10. `FROM` → `COPY requirements.txt .` → `RUN pip install -r requirements.txt` → `COPY . .`.
11. ENTRYPOINT = fixed executable; CMD = default args/command that `docker run` args replace.
12. No.
13. Mutable and unpredictable: not reproducible, unclear rollbacks, surprise changes.
14. Values persist in image layers/metadata and are readable by anyone with the image.
15. A `healthcheck` defined on the dependency service.

## Part B (sample answers)
1. `docker run -d --name web -p 9000:80 --restart unless-stopped nginx`
2. `docker logs -f --tail 50 web`
3. `docker exec -it web sh` (or bash)
4. `docker inspect -f '{{.NetworkSettings.IPAddress}}' web`
5. `docker network create app-net && docker run -dit --name c1 --network app-net alpine sleep infinity`
6. `docker volume create data && docker run --rm -v data:/d:ro alpine ls -la /d`
7. `docker build -t me/app:1.2.0 -t me/app:1.2 .` (or `docker tag me/app:1.2.0 me/app:1.2`)
8. `docker push me/app:1.2.0 && docker push me/app:1.2`; elsewhere `docker pull me/app:1.2.0`
9. `docker run -d --memory 128m --read-only --cap-drop ALL IMAGE`
10. `docker container prune -f && docker image prune -f`

## Part C: the 4 bugs
1. **Compose port mapping:** `"8080:8080"` but nginx listens on 80 → use `"8080:80"`. *Symptom:* connection reset/refused on host 8080.
2. **nginx upstream name:** `proxy_pass http://application:8000` but the service is `app` → `http://app:8000`. *Symptom:* nginx logs `host not found in upstream` (the proxy may exit/restart or return 502).
3. **App binds loopback:** `HTTPServer(("127.0.0.1", 8000), ...)` → bind `0.0.0.0`. *Symptom:* 502 Bad Gateway / connection refused from the proxy.
4. **`.dockerignore` excludes `app.py`:** build fails with `"/app.py": not found` → remove it from `.dockerignore`.

Diagnosis tools: `docker compose build` output, `docker compose logs`, `docker compose ps`, `docker compose exec proxy wget -qO- http://app:8000`.

## Part D rubric (20)
Working API + cache (5) · persistence proven (4) · only API port published (3) · healthchecks on both (3) · `.env` used and not committed (2) · non-root API (3).
