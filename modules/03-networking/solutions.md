# Module 03 Solutions

## Quiz
1. `172.17.0.0/16`, gateway `172.17.0.1`.
2. A veth (virtual Ethernet) pair.
3. NAT/masquerade through the host's iptables.
4. Publishes container port 80 on host port 8080 (host is left of the colon).
5. No, it's documentation only.
6. Only user-defined networks run Docker's embedded DNS.
7. `none`.
8. If one is attached to both networks, or both are connected to a shared network.
9. `overlay`.
10. Binding to `127.0.0.1` only accepts connections from inside the container's own namespace, so published ports and other containers can't reach it.

## Lab 3.8 hints
1. Loopback inside the container is a different loopback from the host's; bind `0.0.0.0`.
2. `docker network connect` one container to the other's network, or put both on one network from the start.
3. Remove or disconnect containers first.

## A3.2 shape
```bash
docker network create frontend; docker network create backend
docker run -d --name db --network backend -e POSTGRES_PASSWORD=x postgres:16
docker run -dit --name api --network backend alpine sleep infinity
docker network connect frontend api
docker run -dit --name proxy --network frontend alpine sleep infinity
docker exec proxy ping -c1 api     # ok
docker exec api ping -c1 db        # ok
docker exec proxy ping -c1 db      # bad address (different network)
```
