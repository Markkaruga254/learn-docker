# Module 03 Assignments

**A3.1:** Draw the packet path for (a) a container pinging 8.8.8.8, and (b) a browser hitting `host:8080` mapped to nginx. Label bridge, veth, NAT/DNAT.

**A3.2: Three-tier isolation.** Create networks `frontend` and `backend`. Run `proxy` (nginx) on frontend only, `db` (e.g. `postgres:16` with a password) on backend only, and `api` (alpine with `sleep infinity` is fine) on both. Prove: proxy→api works, api→db works, proxy→db **fails**. Submit the commands and ping/nc output.

**A3.3:** Write a table: for 5 scenarios, which driver and why (local dev, performance-critical packet processing, batch job that must have no network, multi-host cluster, default web app).

**A3.4:** Find the IP, MAC address, gateway and network name of a running container using only `docker inspect -f`.

**A3.5 (stretch):** Create a network with your own subnet and run two containers with fixed IPs (`--ip`). Document what breaks if the IP is outside the subnet.
