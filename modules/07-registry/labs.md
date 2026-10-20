# Module 07 Labs

## Lab 7.1: Account and token
Create a Docker Hub account. Create a **personal access token** with read/write scope. Store it in a password manager.

## Lab 7.2: Build, tag, push
```bash
mkdir -p ~/labs/07 && cd ~/labs/07
printf 'FROM alpine\nCMD ["echo","hello from my registry"]\n' > Dockerfile
docker build -t repo_image .
docker login -u YOUR_USER            # paste the token as the password
docker tag repo_image YOUR_USER/app1:v1
docker tag repo_image YOUR_USER/app1:v2
docker images | grep -E 'repo_image|app1'   # same IMAGE ID?
docker push YOUR_USER/app1:v1
docker push YOUR_USER/app1:v2
```
Open Docker Hub and confirm. Why was the second push almost instant? (shared layers)

## Lab 7.3: Clean-host test
```bash
docker rmi repo_image YOUR_USER/app1:v1 YOUR_USER/app1:v2
docker run --rm YOUR_USER/app1:v1
```
Docker pulls it. Repeat on a **different machine** if you can (second EC2 or a friend's laptop).

## Lab 7.4: Digests
```bash
docker images --digests YOUR_USER/app1
docker pull YOUR_USER/app1@sha256:<digest>
```
Why is deploying by digest safer than by tag?

## Lab 7.5: Private repo
Make a private repo on Docker Hub, push to it, log out (`docker logout`), and try to pull. Read the error. Log in and pull.

## Lab 7.6: Second registry (GHCR)
```bash
echo $GITHUB_PAT | docker login ghcr.io -u YOUR_GH_USER --password-stdin
docker tag repo_image ghcr.io/YOUR_GH_USER/app1:v1
docker push ghcr.io/YOUR_GH_USER/app1:v1
```

## Lab 7.7 (optional): Run your own registry
```bash
docker run -d -p 5000:5000 --name registry registry:2
docker tag repo_image localhost:5000/app1:v1
docker push localhost:5000/app1:v1
curl localhost:5000/v2/_catalog
```
