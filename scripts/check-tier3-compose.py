#!/usr/bin/env python3
"""Assert security and network invariants in rendered Tier 3 Compose JSON."""
import json
import sys


def require(condition: bool, message: str) -> None:
    if not condition:
        print(f"FAIL: {message}", file=sys.stderr)
        raise SystemExit(1)


try:
    config = json.load(sys.stdin)
except json.JSONDecodeError as exc:
    print(f"FAIL: Compose did not emit valid JSON: {exc}", file=sys.stderr)
    raise SystemExit(1)

services = config.get("services", {})
require({"api", "db", "proxy"} <= services.keys(), "expected api, db, and proxy services")

api = services["api"]
db = services["db"]
proxy = services["proxy"]

require(bool(api.get("image")), "API must use a published image")
require("build" not in api, "production API service must not build from source on the server")
require(api.get("read_only") is True, "API root filesystem must be read-only")
require("ALL" in api.get("cap_drop", []), "API must drop all Linux capabilities")
require(
    any("no-new-privileges:true" in option for option in api.get("security_opt", [])),
    "API must enable no-new-privileges",
)
require(api.get("mem_limit") is not None, "API must have a memory limit")
require(api.get("cpus") is not None, "API must have a CPU limit")
require(api.get("pids_limit") is not None, "API must have a PID limit")

require(not api.get("ports"), "API must not publish host ports")
require(not db.get("ports"), "database must not publish host ports")
require(bool(proxy.get("ports")), "proxy must publish the application entrypoint")
require(
    all(not service.get("ports") for name, service in services.items() if name != "proxy"),
    "proxy must be the only service publishing host ports",
)

api_networks = set(api.get("networks", {}))
db_networks = set(db.get("networks", {}))
proxy_networks = set(proxy.get("networks", {}))
require({"frontend", "backend"} <= api_networks, "API must join frontend and backend networks")
require("backend" in db_networks, "database must join the backend network")
require("frontend" in proxy_networks, "proxy must join the frontend network")
require("backend" not in proxy_networks, "proxy must not join the backend network")
require("pgdata" in config.get("volumes", {}), "database must use a named pgdata volume")

for name, service in services.items():
    require(
        service.get("restart") == "unless-stopped",
        f"{name} must use restart: unless-stopped",
    )

print("PASS: Tier 3 production Compose security and network invariants.")
