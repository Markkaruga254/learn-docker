# Module 09 Solutions

## Reference Dockerfiles
**Go multi-stage (`starter/go-app`)**
```dockerfile
FROM golang:1.22 AS build
WORKDIR /src
COPY go.mod main.go ./
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /out/hello .

FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=build /out/hello /hello
EXPOSE 8080
USER nonroot
ENTRYPOINT ["/hello"]
```
Typical sizes: single-stage ~ 800 MB+, multi-stage ~ 5 to 10 MB.

**Python non-root + healthcheck (`starter/py-app`)**
```dockerfile
FROM python:3.12-slim
ENV PYTHONUNBUFFERED=1
RUN useradd --create-home --uid 10001 app
WORKDIR /home/app
COPY --chown=app:app app.py .
USER app
EXPOSE 8000
HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
  CMD python -c "import urllib.request,sys; sys.exit(0 if urllib.request.urlopen('http://localhost:8000/healthz').status==200 else 1)"
CMD ["python", "app.py"]
```
`.dockerignore`:
```
.git
__pycache__
*.md
.env
*.pem
```

## Quiz
1. Builds in one stage and ships only the artifacts from it in a small final stage, leaving compilers and build tools behind.
2. If the app or a library is exploited, the attacker starts as root, which makes container escapes and host damage easier.
3. No. Each layer is stored; the earlier layer still contains the value.
4. It adds a health state (starting/healthy/unhealthy), usable by Compose conditions and orchestrators.
5. `--read-only` makes the container's root filesystem read-only; `:ro` makes one mounted path read-only.
6. Removes all Linux capabilities, so you add back only what's needed.
7. Not reproducible; may change unexpectedly (including breaking changes or new vulnerabilities); unclear what version is running.
8. The container can talk to the host's Docker daemon, which is effectively root on the host.
9. Killed by SIGKILL (128+9); commonly the OOM killer or `docker kill`.
10. Environment variable at run time, a mounted secret file, Compose/Swarm secrets, or fetched from a secret manager.
11. A minimal image with just the app's runtime and no shell or package manager: small and low attack surface, but harder to debug (use ephemeral debug containers).
12. Build, test, scan (fail on critical findings), tag immutably (e.g. by commit SHA), then push.

## Lab 9.5 note
`docker inspect` on a running container shows its environment variables, so env vars are visible to anyone with Docker access. Mounted files are better, and a secret manager is better again.
