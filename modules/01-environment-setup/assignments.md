# Module 01 Assignments

**A1.1:** Write a one-page `SETUP-NOTES.md` in your fork: region used, instance type, how you connect, how you stop the instance, and your budget alert threshold. Do not include secrets or the .pem.

**A1.2:** Break and fix: remove the IAM role from the instance and observe Session Manager. Re-attach it and fix it.

**A1.3:** Narrow your security group further: allow SSH only from your current IP. Prove another source can't connect (or explain how you'd test).

**A1.4:** Explain in your own words (3 sentences each): (a) what `apt` does with the GPG key, (b) why `systemctl enable` matters after a reboot, (c) why `docker` group ≈ root.

**A1.5 (stretch):** Launch a second instance from the same setup with a user-data script that installs Docker automatically. Terminate it afterwards.
