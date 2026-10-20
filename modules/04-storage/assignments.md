# Module 04 Assignments

**A4.1:** Fill in a table of 6 scenarios (dev code editing, prod DB, CI cache, shared config file, scratch data that must never touch disk, sharing data between two containers) → volume / bind / tmpfs, with a reason.

**A4.2: Notes app persistence.** Run `postgres:16` with a named volume, create a table, destroy and recreate the container, prove the data survived. Submit commands + output.

**A4.3: Backup drill.** Write `backup.sh` that backs up a named volume to a timestamped `.tar.gz` using an Alpine container, and `restore.sh` that restores into a new volume. Test both.

**A4.4:** Run an nginx container serving a host folder read-only. Prove the container cannot modify it, but you can edit on the host.

**A4.5 (stretch):** Two containers share one named volume (writer appends a timestamp every 2 s; reader tails it). Explain the risks of two writers.
