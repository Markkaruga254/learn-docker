# Module 08 Labs (guided build)

> Try each step yourself from the deliverables before opening `solutions.md`.

## Lab 8.1: Prepare
```bash
git clone <YOUR_FORK_OF_THIS_REPO> && cd docker-mastery/modules/08-course-project/starter
ls
```
Open `school-website/` and identify the entry point (`index.html`).

## Lab 8.2: Dockerfile
Create `Dockerfile` next to the `school-website/` folder (build context = `starter/`).
Requirements: nginx base image with a **pinned tag**, copies the site to nginx's web root, documents port 80.

## Lab 8.3: Build and run
```bash
docker build -t web-school .
docker run -d -p 80:80 --name web-school web-school
curl -I localhost
```
On EC2: open port 80 in your security group **from My IP**, browse `http://<public-ip>`.

## Lab 8.4: Inspect
```bash
docker history web-school
docker logs web-school
docker exec web-school ls /usr/share/nginx/html
docker exec web-school nginx -t
```

## Lab 8.5: Tag and push
```bash
docker tag web-school YOUR_USER/school-website:v1
docker login -u YOUR_USER
docker push YOUR_USER/school-website:v1
```

## Lab 8.6: Clean-host proof
```bash
docker rm -f web-school
docker rmi web-school YOUR_USER/school-website:v1
cd .. && rm -rf starter          # simulate "no source code on this machine"
docker run -d -p 8080:80 YOUR_USER/school-website:v1
curl -I localhost:8080
```
Open port 8080 (My IP) if testing from a browser on EC2.

## Lab 8.7: Ship a change
Edit the headline, rebuild as `v2`, push, and run `v2` on the host **without** touching `v1`'s container.
Then roll back to `v1`. Time how long both operations take.

## Lab 8.8: Write DEPLOY.md
Document prerequisites, build, run, push, verify and rollback commands.
