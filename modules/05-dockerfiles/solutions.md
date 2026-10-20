# Module 05 Solutions

## Quiz
1. `Dockerfile` (or use `-f`).
2. `FROM`.
3. RUN during **build** (creates a layer); CMD at **container start** (default command).
4. The last one.
5. No, it is metadata. Use `-p` or `-P`.
6. A cached `update` layer can leave stale package indexes for a later changed `install` step; one layer keeps them consistent.
7. The directory (and subdirs) you pass to `docker build`; COPY can only read inside it.
8. Copy dependency manifests → install → copy source.
9. ENTRYPOINT is the fixed executable; CMD supplies default arguments (and is replaced by args in `docker run`). `--entrypoint` overrides ENTRYPOINT.
10. Exec form doesn't use a shell; use `["sh","-c","$ACTION $TARGET"]` or shell form.
11. `docker run -e KEY=VAL`.
12. Each layer, the instruction that created it, and its size.

## Lab 5.8 reference Dockerfiles
```dockerfile
# ubuntu
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y --no-install-recommends python3 && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY app.py .
EXPOSE 8000
CMD ["python3", "app.py"]
```
```dockerfile
# full / slim / alpine: change only the first line
FROM python:3.12-slim
WORKDIR /app
COPY app.py .
EXPOSE 8000
CMD ["python", "app.py"]
```
Typical sizes: ubuntu+python3 ≈ 150 to 200 MB, full ≈ 1 GB, slim ≈ 120 to 150 MB, alpine ≈ 50 to 80 MB (exact numbers vary).

## Lab 5.9 reference
```dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["python", "app.py"]
```
