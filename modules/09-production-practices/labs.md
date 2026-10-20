# Module 09 Labs

## Lab 9.1: Multi-stage build (Go): see the size drop
Files in `starter/go-app/`.
1. Write a **single-stage** Dockerfile based on `golang:1.22` that builds and runs the app. Build as `go:single`.
2. Write a **multi-stage** Dockerfile: build stage `golang:1.22`, final stage `gcr.io/distroless/static-debian12:nonroot`, copying only the binary (build with `CGO_ENABLED=0`). Build as `go:multi`.
3. Compare: `docker images go --format 'table {{.Tag}}\t{{.Size}}'`.
4. Run both on port 8080 and `curl`. Try `docker exec -it <c> sh` on the distroless one. What happens and why is that good?

## Lab 9.2: Non-root users
In `starter/py-app/`:
1. Build a Dockerfile (python slim) that runs as root. Run it and `curl localhost:8000`: note `uid=0`.
2. Add a user (`RUN useradd --create-home --uid 10001 app` and `USER app`), rebuild, observe `uid=10001`.
3. Try to write to `/` from a shell inside: `docker exec -it C sh -c 'touch /x'`.

## Lab 9.3: Harden at runtime
```bash
docker run -d --name hard -p 8000:8000 \
  --read-only --tmpfs /tmp \
  --cap-drop ALL --security-opt no-new-privileges:true \
  --memory 128m --cpus 0.5 --pids-limit 100 \
  py-app:nonroot
```
Verify it still works. Then break it deliberately (remove `--tmpfs /tmp` for an app that writes there) and read the error.
```bash
docker stats --no-stream hard
docker inspect -f '{{.HostConfig.Memory}} {{.HostConfig.ReadonlyRootfs}}' hard
```

## Lab 9.4: Healthchecks and restart policies
Add to the py-app Dockerfile:
```dockerfile
HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
  CMD python -c "import urllib.request,sys; sys.exit(0 if urllib.request.urlopen('http://localhost:8000/healthz').status==200 else 1)"
```
```bash
docker run -d --name h1 --restart unless-stopped -p 8000:8000 py-app:health
docker ps                      # STATUS shows (health: starting) → (healthy)
docker inspect -f '{{json .State.Health}}' h1
docker kill h1                 # restart policy brings it back? (kill → SIGKILL counts as failure)
docker stop h1                 # unless-stopped will not restart it after you stop it
```

## Lab 9.5: Secrets: the wrong way and the right way
**Wrong:**
```dockerfile
FROM python:3.12-slim
ENV API_KEY=supersecret123
```
Build it, then `docker history --no-trunc IMAGE | grep API_KEY` and `docker inspect IMAGE | grep API_KEY`. Anyone with the image has your key.

**Better:** supply at runtime.
```bash
docker run -d -e API_KEY="$(cat ./api_key.txt)" py-app     # env var: visible in `docker inspect` of the *container*
docker run -d -v $(pwd)/api_key.txt:/run/secrets/api_key:ro py-app   # file mount
```
**Compose secrets:**
```yaml
services:
  app:
    image: py-app
    secrets: [api_key]
secrets:
  api_key:
    file: ./api_key.txt
```
Inside the container the secret appears at `/run/secrets/api_key`. For real deployments use a secret manager (AWS Secrets Manager, Vault, etc.).
Build-time secrets: `RUN --mount=type=secret,id=npmrc ...` with `docker build --secret id=npmrc,src=.npmrc .`

## Lab 9.6: Scan for vulnerabilities
```bash
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image --severity HIGH,CRITICAL py-app:nonroot
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image --severity HIGH,CRITICAL python:3.12      # fat image
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image --severity HIGH,CRITICAL gcr.io/distroless/static-debian12:nonroot
```
Compare finding counts. Note: mounting the Docker socket gives that container control of the host's Docker; accept it only for trusted tools in a lab. Alternatively install Trivy natively or use `docker scout cves IMAGE` (Docker Desktop/CLI plugin).
Fix one finding by upgrading the base image or a dependency, then rescan.

## Lab 9.7: `.dockerignore` and context size
Add junk (`node_modules/`, a 200 MB file, `.env`, `.git`) to a build directory. Build without a `.dockerignore` and watch "transferring context". Add one and rebuild.

## Lab 9.8: Pin and digest
```bash
docker pull python:3.12-slim
docker images --digests python
```
Rewrite a `FROM` as `python:3.12-slim@sha256:<digest>`. Explain the trade-off: reproducible vs. missing security updates, and how Renovate/Dependabot help.

## Lab 9.9: CI pipeline
See Capstone Tier 3 for the full workflow. Minimum: a GitHub Actions job that builds, scans with Trivy, and pushes on `main`.
