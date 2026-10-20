# Contributing

Thanks for helping improve Docker Mastery. The goal is to keep the curriculum accurate, practical, safe, and reproducible for learners using Docker Engine on Ubuntu 24.04.

## Before you start

1. Check existing issues and pull requests for related work.
2. Open an issue first for substantial curriculum changes or new modules.
3. Fork the repository and create a focused branch from `main`.

Suggested branch names:

- `docs/fix-module-02-typo`
- `lab/add-volume-restore-exercise`
- `fix/cleanup-script-prompt`
- `ci/check-shell-scripts`

## Make a useful change

- Keep each pull request focused on one concern.
- Prefer small, runnable examples over large unexplained command dumps.
- Include expected output or a verification step when it helps learners know they succeeded.
- Check commands against current official documentation when behavior or flags may have changed.
- Explain any platform or version assumptions.
- Never commit passwords, access tokens, private keys, personal data, or real `.env` files.
- Keep destructive commands clearly labelled and include a safer alternative where possible.
- Do not remove persistent Docker volumes as part of routine cleanup without explicit confirmation.

## Validate your changes

For shell-script changes, run:

```bash
bash -n scripts/doctor.sh scripts/cleanup.sh
```

For documentation changes, check that:

- Markdown headings and code fences are balanced.
- Relative links point to existing files.
- Commands use the repository's actual paths and names.
- Any claim about security, cost, or data deletion is precise.

For Docker examples, run the relevant lab or validate Compose configuration when Docker is available. If you cannot run a check, state that in the pull request instead of claiming it passed.

## Commit messages

Use short, imperative, descriptive messages with a conventional prefix:

- `docs: clarify module 03 network lab`
- `feat: add volume backup and restore exercise`
- `fix: make cleanup prompts explicit`
- `test: validate shell scripts in CI`
- `security: document non-root container checks`

Each commit should represent one coherent change. Avoid vague messages such as `updates`, `stuff`, or `final changes`. Do not create empty commits or misrepresent when work happened.

## Pull request checklist

- [ ] The change solves one clearly described problem.
- [ ] Documentation and relative links were reviewed.
- [ ] Relevant checks were run, or unrun checks are disclosed.
- [ ] No secrets, generated junk, or unrelated files are included.
- [ ] Risky commands and cleanup behavior are explained.
- [ ] The pull request description explains what changed and how it was verified.

By contributing, you agree that your submission may be distributed under the repository's applicable license. If licensing is unclear, ask in an issue before contributing substantial material.
