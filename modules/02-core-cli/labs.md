# Module 02 Labs

## Lab 2.1: The long way round (lifecycle)
```bash
docker pull nginx
docker images
docker create --name count1 nginx
docker ps            # not listed. Why?
docker ps -a         # status: Created
docker start count1
docker ps            # Up
docker stop count1
docker ps -a         # Exited (0)
docker rm count1
```
Then do the same with one command: `docker run -d --name count1 nginx`. Compare.

## Lab 2.2: Prove a container is a process
```bash
docker run -d --name count1 nginx
PID=$(docker inspect -f '{{.State.Pid}}' count1)
echo $PID
ps -p $PID -o pid,ppid,user,cmd
ps aux | grep '[n]ginx: master'
```
The container has an ordinary PID on the **host**. Stop it and confirm the PID disappears.

## Lab 2.3: `exec`: three behaviours
```bash
docker run -d --name count2 nginx
docker exec count2 cat /etc/hostname      # runs and exits
docker exec -it count2 /bin/bash          # interactive shell
#   inside: ls /, ps aux (may be missing: why?), hostname, exit
docker exec -i count2 cat /etc/hostname   # -i without -t: what changes?
```

## Lab 2.4: One-off containers
```bash
docker run --rm ubuntu echo "this will self destruct"
docker ps -a        # nothing left behind
docker run -it --rm ubuntu bash
#   inside: cat /etc/os-release; apt list --installed | wc -l; exit
```

## Lab 2.5: Ports and env
```bash
docker run -d --name web -p 8080:80 nginx
curl -I localhost:8080
docker port web
docker run --rm -e GREETING=hi alpine sh -c 'echo $GREETING'
```

## Lab 2.6: Logs, inspect, stats
```bash
docker logs web
curl -s localhost:8080 >/dev/null; docker logs --tail 3 web
docker logs -f web          # Ctrl+C to leave; curl from another terminal to watch it stream
docker inspect web | head -50
docker inspect -f '{{.NetworkSettings.IPAddress}}' web
docker inspect -f '{{.State.Status}} {{.RestartCount}}' web
docker top web
docker stats --no-stream
```

## Lab 2.7: Break-and-fix (diagnose *before* you fix)
1. **Duplicate name:** `docker run -d --name web nginx` → read the error. Fix.
2. **Port clash:** `docker run -d -p 8080:80 nginx` while `web` holds 8080. Fix with a different host port.
3. **Flag after image:** `docker run ubuntu -it bash` → what happens? Why? Fix.
4. **Exec into stopped:** stop `web`, then `docker exec -it web sh`. Read the error; fix.
5. **Immediate exit:** `docker run -d ubuntu`. `docker ps -a` shows `Exited (0)`. Why? How do you keep one alive for debugging? (`docker run -dit ubuntu` or `sleep infinity`)
6. **Missing image tag:** `docker pull nginx:no-such-tag`. Read the error.

## Lab 2.8: Cleanup & disk
```bash
docker system df
docker container prune
docker image prune
docker rm -f $(docker ps -aq)       # careful: removes ALL containers
docker rmi $(docker images -q)      # removes all images
```
Run `scripts/cleanup.sh` for a guided version.
