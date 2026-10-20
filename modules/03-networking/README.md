# Module 03: Docker networking

**Video:** 2:08 to 2:38 (overview, drivers, bridge-mode labs)

## Objectives
- Explain the default bridge (`docker0`, `172.17.0.0/16`, gateway `172.17.0.1`) and veth pairs.
- Explain how containers reach the internet (NAT) and how the internet reaches containers (port publishing).
- Create user-defined bridge networks and use name-based service discovery.
- Choose between `bridge`, `host`, `none`, `overlay`.
- Isolate services by network.

## Concepts
- Default bridge = a virtual Layer-2 switch on the host. Each container gets an IP and a veth pair (one end on the host, `eth0` inside the container).
- Outbound: host iptables **NAT** (masquerade). Inbound: `-p HOST:CONTAINER` creates a DNAT rule.
- **Default bridge has no DNS by container name. User-defined bridges do** (extension beyond the video, but this is what Compose uses).
- Containers on different user-defined networks cannot talk unless connected to both.

| Driver | Use |
|---|---|
| bridge | single-host default |
| host | no isolation, no port mapping, max performance |
| none | no networking (loopback only) |
| overlay | multi-host (Swarm/Kubernetes-style clusters) |

Cheat sheet: [networking-storage](../../cheatsheets/networking-storage.md)
