# Repository Guidelines

## Project Structure & Module Organization
Dotfile templates follow chezmoi naming rules: files prefixed with `dot_` become user-facing dotfiles (for example, `dot_zshrc` and `dot_gitconfig.tmpl`), while sensitive assets live under `private_` directories and stay encrypted at rest. Automation scripts are grouped by trigger: `run_once_*` for first-time provisioning, `run_onchange_*` for idempotent updates, and `dot_config/` for application-specific configs like `borders`. Keep new templates small, self-contained, and include inline comments only when they explain non-obvious platform logic.

## Build, Test, and Development Commands
- `chezmoi diff` — Preview the rendered filesystem before applying changes; run this before every commit.
- `chezmoi apply --dry-run --verbose` — Validate template rendering without mutating the host, helpful for catching syntax or permission issues.
- `chezmoi apply` — Apply changes locally after review; pair with `--limit` when validating a single template.
- `chezmoi doctor` — Confirm required external tools (git, age, brew) are installed before sharing new automation.

## Coding Style & Naming Conventions
Shell scripts use POSIX `sh` or `bash` with two-space indentation and explicit `#!/bin/...` shebangs. Templates should prefer Go text/template helpers already in use (e.g., `{{ if eq .chezmoi.os "darwin" }}`) and keep variable names descriptive (`p10k_dir`, `HOME`). Favor descriptive filenames (`run_once_setup-darwin.sh.tmpl`) and match existing prefixes (`dot_`, `private_`, `executable_`).

## Testing Guidelines
When touching provisioning scripts, rerun `chezmoi apply --dry-run --verbose` on macOS and Linux if relevant, and capture any output differences. For shell changes, lint with `shellcheck` locally when available, and ensure idempotency by running the script twice without error. Document manual validation steps in your pull request when automation is not feasible.

## Commit & Pull Request Guidelines
Commits are short, imperative, and scoped (“Enable ping notify”). Group related template edits together and avoid multi-purpose commits. Pull requests should summarize the change, note the primary templates affected, link to any related issues, and include before/after command output snippets when altering provisioning scripts or defaults.

## Security & Secrets
Never check decrypted secrets into the repo. Use `chezmoi age` commands to manage encrypted files, and confirm `key.txt.age` stays encrypted. When introducing new secrets, place them under the appropriate `private_` path and document any required environment variables in the PR description instead of committing plaintext.
