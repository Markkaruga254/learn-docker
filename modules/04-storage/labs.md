# Module 04 Labs

## Lab 4.1: Prove container data is ephemeral
```bash
docker run -it --name tmp1 ubuntu bash
#   inside: echo "hello" > /data.txt; cat /data.txt; exit
docker start tmp1 && docker exec tmp1 cat /data.txt     # still there (same container)
docker rm tmp1
docker run --rm ubuntu cat /data.txt                    # gone
```

## Lab 4.2: Named volumes
```bash
docker volume create vol1
docker volume inspect vol1                               # note Mountpoint
docker run -d --name w1 -v vol1:/data alpine sh -c 'echo from-w1 > /data/a.txt && sleep infinity'
docker exec w1 cat /data/a.txt
docker rm -f w1
docker run --rm -v vol1:/data alpine cat /data/a.txt     # persisted
sudo ls /var/lib/docker/volumes/vol1/_data               # see it on the host
docker run --rm -v vol1:/data:ro alpine sh -c 'echo x > /data/b.txt'   # read-only file system
docker volume ls
```

## Lab 4.3: Bind mount for live editing
```bash
mkdir -p ~/host_folder && echo "<h1>v1</h1>" > ~/host_folder/index.html
docker run -d --name site -p 8080:80 -v ~/host_folder:/usr/share/nginx/html:ro nginx
curl localhost:8080
echo "<h1>v2</h1>" > ~/host_folder/index.html
curl localhost:8080            # updated without restarting
docker run -it --rm -v "$(pwd)":/app ubuntu bash     # shorthand with $(pwd)
```

## Lab 4.4: A database that survives
```bash
docker volume create pgdata
docker run -d --name pg -e POSTGRES_PASSWORD=labpass -v pgdata:/var/lib/postgresql/data postgres:16
sleep 8
docker exec pg psql -U postgres -c "CREATE TABLE notes(id serial, body text); INSERT INTO notes(body) VALUES ('survives');"
docker rm -f pg
docker run -d --name pg2 -e POSTGRES_PASSWORD=labpass -v pgdata:/var/lib/postgresql/data postgres:16
sleep 8
docker exec pg2 psql -U postgres -c "SELECT * FROM notes;"
```
**Question:** what happens if you `docker volume rm pgdata` while pg2 runs? (Try it; read the error.)

## Lab 4.5: Backup & restore a volume
```bash
docker stop pg2        # consistent file-level backup needs the DB stopped
docker run --rm -v pgdata:/data -v "$(pwd)":/backup alpine tar czf /backup/pgdata.tar.gz -C /data .
ls -lh pgdata.tar.gz
docker volume create pgdata_restore
docker run --rm -v pgdata_restore:/data -v "$(pwd)":/backup alpine tar xzf /backup/pgdata.tar.gz -C /data
docker run -d --name pg3 -e POSTGRES_PASSWORD=labpass -v pgdata_restore:/var/lib/postgresql/data postgres:16
sleep 8; docker exec pg3 psql -U postgres -c "SELECT * FROM notes;"
```
For a **live** database the proper tool is a logical dump:
`docker exec pg3 pg_dump -U postgres postgres > dump.sql`

## Lab 4.6: tmpfs
```bash
docker run --rm --tmpfs /scratch alpine sh -c 'echo hi > /scratch/f && cat /scratch/f && mount | grep scratch'
```

## Cleanup
`docker rm -f pg2 pg3 site; docker volume rm vol1 pgdata pgdata_restore; rm -rf ~/host_folder pgdata.tar.gz`
