# Module 02 Solutions

## Quiz
1. pull (if missing) → create → start.
2. `stop` sends SIGTERM then SIGKILL after the timeout (default 10 s); `kill` sends SIGKILL (or a chosen signal) immediately.
3. There is no running process/namespace to attach to.
4. Deletes the container automatically when it exits.
5. `-d` is after the image name, so it's passed to the container's command instead of Docker.
6. `docker exec -it C sh`; `docker run -it IMAGE sh`.
7. `docker inspect`.
8. Stopped/exited/created containers.
9. Killed by SIGKILL (128+9), often out-of-memory or `docker kill`.
10. `docker inspect -f '{{.NetworkSettings.IPAddress}}' C` (use `.NetworkSettings.Networks.<net>.IPAddress` on user-defined networks).

## A2.1 answers
1 `docker pull redis:7` · 2 `docker images -q` · 3 `docker create --name r1 redis:7` · 4 `docker start r1` · 5 `docker ps` · 6 `docker ps -a` ·
7 `docker run -d --name n1 -p 9090:80 nginx` · 8 `docker logs -f n1` · 9 `docker exec -it n1 bash` · 10 `docker inspect -f '{{.NetworkSettings.IPAddress}}' n1` ·
11 `docker inspect -f '{{.State.Pid}}' n1` · 12 `docker stop -t 2 n1` · 13 `docker rm n1` · 14 `docker rm -f r1` · 15 `docker run --rm alpine date` ·
16 `docker run --rm -e NAME=you ubuntu bash -c 'echo $NAME'` · 17 `docker cp n1:/etc/nginx/nginx.conf .` · 18 `docker stats --no-stream` ·
19 `docker rmi -f IMAGE` · 20 `docker image prune` · 21 `docker inspect -f '{{.State.ExitCode}}' C` · 22 `docker logs --tail 20 C` ·
23 `docker top C` · 24 `docker restart C` · 25 `docker system df`.

## A2.2
create: image→Created · start: Created/Exited→Running · stop/kill: Running→Exited · pause/unpause: Running⇄Paused · restart: stop+start · rm: Exited/Created→gone.

## A2.4
`ubuntu` has no long-running default command (it runs `bash`, which exits when there's no terminal). `nginx`'s default command is the server process, which stays in the foreground, so the container lives as long as that process does.
