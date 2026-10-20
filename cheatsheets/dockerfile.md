# Dockerfile cheat sheet

| Instruction | Runs at | Notes |
|---|---|---|
| `FROM image:tag` | build | First line. Pin the tag. `FROM x AS name` for multi-stage |
| `RUN cmd` | build | New layer. Chain with `&&`; clean caches in the same layer |
| `COPY src dest` | build | From build context only |
| `ADD` | build | COPY + URL/tar extras. Prefer COPY |
| `WORKDIR /path` | build | mkdir + cd, persists for later instructions |
| `ENV K=V` | build + run | Overridable with `-e` |
| `ARG K=V` | build only | `--build-arg`; not for secrets |
| `LABEL k=v` | metadata | Visible in `docker inspect` |
| `EXPOSE 80` | metadata | Documents a port; does **not** publish it |
| `USER name` | build + run | Drop root |
| `HEALTHCHECK` | run | Marks container healthy/unhealthy |
| `CMD [...]` | run | Default command; overridable; **only the last one counts** |
| `ENTRYPOINT [...]` | run | The fixed executable; CMD becomes its default args |

## CMD vs ENTRYPOINT
```dockerfile
ENTRYPOINT ["ping"]
CMD ["-c","3","8.8.8.8"]
# docker run img            -> ping -c 3 8.8.8.8
# docker run img -c 1 1.1.1.1 -> ping -c 1 1.1.1.1
```
Prefer **exec form** `["a","b"]` over shell form so signals reach your process.

## Caching rule
Put things that change **least** at the top, **most** at the bottom:
```dockerfile
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
```

## Must-have habits
`.dockerignore` · pinned tags · non-root `USER` · multi-stage for compiled apps · no secrets · one process per container
