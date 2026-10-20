# Module 05 Labs

Work in a fresh directory per lab (e.g. `~/labs/05/demo1`). The Dockerfile must be named `Dockerfile`.

## Lab 5.1: Alpine echo
```dockerfile
FROM alpine
CMD ["echo", "welcome", "hello from my first image"]
```
```bash
docker build -t image1 .
docker run image1
docker run image1 echo override       # CMD is replaced
docker history image1
```

## Lab 5.2: Ubuntu with tools: and the layer lesson
```dockerfile
FROM ubuntu:22.04
RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y git
CMD ["echo", "Ubuntu with vim and git"]
```
Build it as `u-bad`. Now rewrite it with one `RUN apt-get update && apt-get install -y --no-install-recommends vim git && rm -rf /var/lib/apt/lists/*` as `u-good`.
Compare `docker images` and `docker history` for both.
**Why must `update` and `install` share one RUN?** (stale cached package lists)

## Lab 5.3: EXPOSE vs publishing
```dockerfile
FROM nginx
EXPOSE 80
```
```bash
docker build -t image_exp .
docker run -d --name e1 image_exp
curl localhost:80                      # fails
docker run -d --name e2 -p 8080:80 image_exp
curl -I localhost:8080                 # works
docker run -d -P image_exp             # -P publishes all EXPOSEd ports to random host ports
docker ps
```

## Lab 5.4: COPY and build context
```bash
echo "testing copy" > test.txt
```
```dockerfile
FROM ubuntu
COPY test.txt /copy_test_app/test.txt
CMD ["cat", "/copy_test_app/test.txt"]
```
Then: (a) try `COPY ../something .` and read the error, (b) rename your file `dockerfile` and watch auto-detection fail, (c) use `docker build -f MyFile .`.

## Lab 5.5: WORKDIR
```dockerfile
FROM ubuntu
WORKDIR /app
RUN echo "this is /app" > app.txt
WORKDIR /app/code
RUN echo "this is /app/code" > app_code.txt
CMD ["ls"]
```
Predict `docker run` output, then check. Predict it again after adding `CMD ["ls", ".."]`.

## Lab 5.6: ENV and LABEL (and runtime override)
```dockerfile
FROM ubuntu
RUN apt-get update && apt-get install -y iputils-ping
ENV ACTION=ping
ENV TARGET=8.8.8.8
LABEL maintainer="you <you@example.com>"
CMD ["sh", "-c", "$ACTION -c 3 $TARGET"]
```
```bash
docker build -t image123 .
docker run image123
docker run -e TARGET=1.1.1.1 image123
docker inspect -f '{{.Config.Labels}}' image123
```
Why `["sh","-c",...]` and not `["$ACTION","$TARGET"]`? (variable expansion needs a shell)

## Lab 5.7: CMD vs ENTRYPOINT
```dockerfile
FROM alpine
ENTRYPOINT ["ping"]
CMD ["-c", "3", "8.8.8.8"]
```
```bash
docker build -t pinger .
docker run --rm pinger
docker run --rm pinger -c 1 1.1.1.1
docker run --rm --entrypoint echo pinger hi
```
Make a table of what is replaced in each case.

## Lab 5.8: Same app, four ways (size challenge)
Using `starter/app.py`, write four Dockerfiles that run it on port 8000:
1. `ubuntu:22.04` + `apt-get install python3`
2. `python:3.12`
3. `python:3.12-slim`
4. `python:3.12-alpine`

Build each (`app:ubuntu`, `app:full`, `app:slim`, `app:alpine`), run, `curl`, and record sizes:
```bash
docker images app --format 'table {{.Tag}}\t{{.Size}}'
```
Which would you ship? Why might alpine surprise you with compiled Python packages? (musl vs glibc)

## Lab 5.9: Layer caching challenge
In `starter/cache-demo/`:
1. Write a Dockerfile **in the naive order**: `COPY . .` then `pip install -r requirements.txt`. Build. Edit `app.py`; rebuild. Note: pip reruns.
2. Reorder: copy `requirements.txt` → `pip install` → `COPY . .`. Build. Edit `app.py`; rebuild. Note: pip is cached (look for `CACHED`).
3. Add `.dockerignore` (`__pycache__`, `.git`, `*.md`) and observe context size in build output.

## Lab 5.10: Break-and-fix
1. Two `CMD` lines: which wins? 2. `RUN` used where `CMD` was needed (container does nothing at run). 3. `COPY` of a path that is ignored by `.dockerignore`. 4. Missing `-y` on `apt-get install`. Diagnose each from the error text.
