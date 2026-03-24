#!/usr/bin/env bash
# Bootstrap a new macOS machine with dotfiles
# Usage: /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/YOURUSER/dotfiles/main/bootstrap.sh)"
set -euo pipefail

DOTFILES_REPO_SSH="git@github.com:HarryKitchener/dotfiles.git"
DOTFILES_REPO_HTTPS="https://github.com/HarryKitchener/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

echo "==> Dotfiles bootstrap starting..."

# 1. Xcode Command Line Tools (provides git)
if ! xcode-select -p &>/dev/null; then
    echo "==> Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "    Waiting for installation... (click Install in the dialog)"
    until xcode-select -p &>/dev/null; do sleep 5; done
fi

# 2. Homebrew
if ! command -v brew &>/dev/null; then
    echo "==> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

# 3. Clone dotfiles
if [[ -d "$DOTFILES_DIR" ]]; then
    echo "==> Dotfiles already exist, pulling latest..."
    git -C "$DOTFILES_DIR" pull origin main
else
    echo "==> Cloning dotfiles..."
    git clone "$DOTFILES_REPO_SSH" "$DOTFILES_DIR" 2>/dev/null \
        || git clone "$DOTFILES_REPO_HTTPS" "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

# 4. Homebrew packages
echo "==> Installing Homebrew packages..."
brew bundle install --file="$DOTFILES_DIR/Brewfile"

# 5. Symlinks
echo "==> Linking dotfiles..."
bash install.sh link

# 6. macOS defaults (optional)
read -r -p "==> Apply macOS system defaults? [y/N] " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    bash macos/defaults.sh
fi

echo ""
echo "==> Bootstrap complete!"
echo ""
echo "Next steps:"
echo "  1. Edit git/identities/github.gitconfig and gitlab.gitconfig with your name/email"
echo "  2. Generate SSH keys:"
echo "       ssh-keygen -t ed25519 -C 'you@email.com' -f ~/.ssh/id_ed25519_github"
echo "       ssh-keygen -t ed25519 -C 'you@work.com'  -f ~/.ssh/id_ed25519_gitlab"
echo "       ssh-add --apple-use-keychain ~/.ssh/id_ed25519_github"
echo "       ssh-add --apple-use-keychain ~/.ssh/id_ed25519_gitlab"
echo "  3. Add public keys to github.com and gitlab.com"
echo "  4. Install JetBrains Mono Nerd Font for Ghostty"
echo "  5. Open a new terminal window"
