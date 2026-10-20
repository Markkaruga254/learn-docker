# Module 02 Assignments

## A2.1: 25-command drill (write the command *without notes*, then test it)
1. Download `redis:7` · 2. List images, IDs only · 3. Create (don't start) a container `r1` from `redis:7` ·
4. Start `r1` · 5. Show only running containers · 6. Show all containers · 7. Run `nginx` detached as `n1`, host 9090 → 80 ·
8. Follow `n1`'s logs · 9. Open a bash shell in `n1` · 10. Print `n1`'s IP · 11. Print `n1`'s host PID ·
12. Stop `n1` with a 2-second timeout · 13. Remove `n1` · 14. Force-remove a running container `r1` ·
15. Run a throwaway Alpine that prints today's date · 16. Run Ubuntu with env var `NAME=you` and print it ·
17. Copy `/etc/nginx/nginx.conf` out of a running container · 18. Show live CPU/memory once ·
19. Remove an image forcibly · 20. Remove all dangling images · 21. Show the container's exit code ·
22. Show last 20 log lines · 23. Show the processes in a container · 24. Restart a container · 25. Show disk usage by Docker.

## A2.2: Lifecycle diagram
Draw the lifecycle (Created/Running/Paused/Exited/Removed) and label each command that moves between states, including `pause`, `unpause`, `restart`, `kill`.

## A2.3: Investigate
Run `docker run -d --name mystery nginx`. Without `docker exec`, answer using only `docker inspect`/`logs`/`top`: What image ID? What command? Which ports does it declare? What's its IP? Which environment variables exist?

## A2.4: Explain
In your own words: why does `docker run -d ubuntu` exit immediately, while `docker run -d nginx` keeps running?
