# dotfiles

Personal macOS dotfiles managed with plain symlinks. No extra tools required beyond `git` and `bash`.

## Quick start (new machine)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/YOURUSER/dotfiles/main/bootstrap.sh)"
```

## Manual setup

```bash
git clone git@github.com:YOURUSER/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make install
```

## What's managed

| Config | Symlink |
|--------|---------|
| Zsh | `~/.zprofile`, `~/.zshrc` |
| Git | `~/.gitconfig`, `~/.gitignore_global` |
| SSH config | `~/.ssh/config` |
| Ghostty | `~/.config/ghostty/config` |
| Starship prompt | `~/.config/starship.toml` |
| Neovim | `~/.config/nvim/` |
| Karabiner | `~/.config/karabiner/karabiner.json` |
| Claude CLI | `~/.claude/settings.json` |

## Multiple git identities

Repos under `~/github/` use the GitHub identity, repos under `~/gitlab/` use the GitLab identity. Edit `git/identities/` to set your name and email for each. Everything else uses the global default in `git/.gitconfig`.

## Machine-local overrides

These files are gitignored and never tracked. Create them for machine-specific settings:

- `~/.zshrc.local` — sourced at the end of `.zshrc`
- `~/.gitconfig.local` — included at the end of `.gitconfig`

## After bootstrapping

1. **Set git identity** — edit `git/identities/github.gitconfig` and `gitlab.gitconfig`
2. **Generate SSH keys**
   ```bash
   ssh-keygen -t ed25519 -C "you@email.com" -f ~/.ssh/id_ed25519_github
   ssh-keygen -t ed25519 -C "you@work.com"  -f ~/.ssh/id_ed25519_gitlab
   ssh-add --apple-use-keychain ~/.ssh/id_ed25519_github
   ssh-add --apple-use-keychain ~/.ssh/id_ed25519_gitlab
   ```
3. **Add public keys** to github.com and gitlab.com
4. **Install font** — JetBrains Mono Nerd Font (used by Ghostty config)
5. **Open a new terminal** to pick up the zsh config

## Commands

```
make install     Full install: brew packages + symlinks
make link        Create/refresh symlinks only
make list        Show symlink status
make update      Pull latest and re-link
make brew-dump   Regenerate Brewfile from installed packages
make macos       Apply macOS system defaults
```
