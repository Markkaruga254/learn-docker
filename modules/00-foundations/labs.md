# Module 00 Labs

These labs need a **Linux shell** (a Linux VM, WSL2, or the EC2 host from Module 01). No Docker required yet.

## Lab 0.1: Meet processes
```bash
ps aux | head
echo $$                    # PID of your shell
ps -o pid,ppid,cmd -p $$
sleep 300 &                # start a background process
jobs; ps aux | grep '[s]leep'
kill %1
```
**Questions:** What is PID 1 on your system? Which process is the parent of your shell?

## Lab 0.2: Namespaces by hand (what Docker automates)
```bash
sudo unshare --pid --fork --mount-proc bash
ps aux          # you now see only a handful of processes; bash is PID 1
echo $$
exit
```
**Questions:** Why does `ps` show so few processes? Which kernel feature did that? How does this relate to
a container's "own process tree"?

## Lab 0.3: cgroups peek
```bash
cat /proc/self/cgroup
ls /sys/fs/cgroup | head -20
```
**Question:** Which cgroup controllers could limit memory and CPU?

## Lab 0.4: Architecture from memory
On paper, draw: CLI, daemon, containerd, runC, image, container, registry. Draw arrows for
`docker run nginx`. Compare with the diagram in the README. Fix and redo until you can do it blind.

## Lab 0.5: Cost of a VM (thought experiment)
You must run 20 small web services. Estimate RAM/disk for 20 VMs (assume 2 GB RAM + 10 GB disk each) vs
20 containers (assume 50 MB each). Write both numbers down.
