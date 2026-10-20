# Module 04 Solutions

## Quiz
1. It's destroyed.
2. `/var/lib/docker/volumes/NAME/_data`.
3. Live code editing in development, or mounting a specific host file/folder.
4. Append `:ro` (e.g. `-v vol:/data:ro`).
5. Docker; you.
6. No (use `docker rm -v` for anonymous volumes or `docker volume rm`).
7. The image requires a root-password variable such as `MYSQL_ROOT_PASSWORD`; check `docker logs`.
8. `pg_dump`; a live file copy can be inconsistent.
9. `-v` / `--volumes`.
10. An in-memory mount: fast and never written to disk; good for scratch data or sensitive temp files.

## Lab 4.4 question
Docker refuses to remove a volume that is in use ("volume is in use").

## A4.1 sample
dev code → bind · prod DB → volume · CI cache → volume · shared config file → bind (read-only) · must-not-touch-disk scratch → tmpfs · share between containers → volume.

## A4.3 sketch
```bash
# backup.sh VOLUME
docker run --rm -v "$1":/data -v "$(pwd)":/backup alpine tar czf "/backup/$1-$(date +%F-%H%M%S).tar.gz" -C /data .
# restore.sh VOLUME FILE
docker volume create "$1"
docker run --rm -v "$1":/data -v "$(pwd)":/backup alpine tar xzf "/backup/$2" -C /data
```
