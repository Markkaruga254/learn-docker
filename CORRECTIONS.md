# Corrections & caveats

The course notes this repo was built from were extracted from the video with an AI tool. Some text
was corrupted or is not best practice. This is what was changed, and why. **Check anything
version-specific against official docs**: <https://docs.docker.com>.

## Restored / fixed
1. **Docker install commands.** URLs were stripped in the extraction. Restored from Docker's official
   Ubuntu install procedure (apt repo at `download.docker.com/linux/ubuntu`, key at `/gpg`). The package
   list includes `containerd.io` (also dropped by the extraction). See Module 01.
2. **Custom network example.** The subnet was stripped; Module 03 uses `172.20.0.0/16` as an example.
3. **Capstone repo URL.** The `git clone` URL was lost. Module 08 ships its own `school-website` starter
   so you don't depend on an external repo.
4. **`mysql` needs a password variable.** `docker run -d -v vol1:/var/lib/mysql mysql` exits immediately; the
   image requires e.g. `-e MYSQL_ROOT_PASSWORD=...`. Module 04 uses PostgreSQL with the required variable.
5. **"Prove a container is a process".** `ps aux | grep <container-name>` won't match, because the
   container name is not in the host process list. Module 02 finds the PID with `docker inspect` instead.

## Security hardening (the video optimizes for convenience)
6. **Security group open to `0.0.0.0/0` on all ports.** Fine for a throwaway demo, risky otherwise. Module 01
   restricts SSH to *your IP* and opens only the ports each lab needs.
7. **`AdministratorAccess` for the daily user and `sudo su`.** Module 01 recommends MFA on the root account,
   an IAM admin user for daily work, and `sudo`/the `docker` group (with the caveat that docker-group
   membership is root-equivalent).
8. **SSM policy.** The notes name `AmazonEC2RoleforSSM`, an older managed policy. AWS currently recommends
   `AmazonSSMManagedInstanceCore`; use that.
9. **`latest` tags and running as root** appear throughout the video. Module 07 and 09 teach pinned tags and
   non-root users.

## Things that may have changed since the video
- **AWS Free Tier terms** change. Check the current terms for your account before launching anything.
- `t2.micro` isn't offered in every region; `t3.micro` is the usual substitute.
- Docker version numbers in the video (e.g. 28.1.1) will differ from yours. That's fine.
- The notes list the instructor's name differently than the YouTube description; the repo credits
  "DolfinEd" only.

## Not verified
Labs were written against standard Docker Engine behavior on Ubuntu 24.04. If a command behaves
differently on your machine, open an issue or fix it in a pull request.
