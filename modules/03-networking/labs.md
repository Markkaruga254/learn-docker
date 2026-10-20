# Module 03 Labs

## Lab 3.1: Look at the default network
```bash
docker network ls
docker network inspect bridge          # note Subnet, Gateway, Containers
ip addr show docker0
```

## Lab 3.2: Containers on the default bridge
```bash
docker run -dit --name c1 alpine sh
docker run -dit --name c2 alpine sh
docker network inspect bridge          # both listed with IPs
docker exec c1 ping -c 3 <IP of c2>    # works
docker exec c1 ping -c 3 c2            # fails: no name resolution on the default bridge
docker exec c1 ip addr                 # find eth0 and its @ifNN partner
ip link | grep veth                    # host-side ends
```

## Lab 3.3: Outbound traffic (NAT)
```bash
docker exec c1 ping -c 2 8.8.8.8
sudo iptables -t nat -L POSTROUTING -n | head
```
Explain how a private `172.17.x.x` address reaches the internet.

## Lab 3.4: User-defined bridge + DNS
```bash
docker network create --subnet 172.20.0.0/16 labnet
docker run -dit --name c3 --network labnet alpine sh
docker run -dit --name c4 --network labnet alpine sh
docker exec c3 ping -c 2 c4            # by NAME: works
docker network inspect labnet
```

## Lab 3.5: Publishing ports
```bash
docker run -d --name web1 -p 8080:80 nginx
curl -I localhost:8080
docker port web1
sudo iptables -t nat -L DOCKER -n
docker run -d --name web2 nginx        # no -p
curl -I localhost:80                   # fails: not published
curl -I $(docker inspect -f '{{.NetworkSettings.IPAddress}}' web2)   # works from the host via container IP
```
On EC2: add an inbound rule for 8080 from **My IP**, then browse `http://<public-ip>:8080`.

## Lab 3.6: `none` and `host`
```bash
docker run --rm --network none alpine ip addr        # only lo
docker run --rm --network host alpine ip addr        # the host's interfaces
```
When is each appropriate? When is `host` dangerous?

## Lab 3.7: Isolation and connect/disconnect
```bash
docker network create net_a; docker network create net_b
docker run -dit --name a1 --network net_a alpine sh
docker run -dit --name b1 --network net_b alpine sh
docker exec a1 ping -c 2 b1                         # fails
docker network connect net_a b1
docker exec a1 ping -c 2 b1                         # works
docker network disconnect net_a b1
```

## Lab 3.8: Break-and-fix
1. Start an app listening on `127.0.0.1` inside the container (e.g. `docker run -d -p 8081:8000 python:3.12-slim python -m http.server 8000 --bind 127.0.0.1`); `curl localhost:8081` fails. Why? Fix by binding `0.0.0.0`.
2. Two containers on different networks can't ping by name. Fix two ways.
3. Remove a network that still has containers attached; read the error; fix.

## Cleanup
`docker rm -f c1 c2 c3 c4 a1 b1 web1 web2; docker network rm labnet net_a net_b`
