#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; RED='\033[0;31m'; NC='\033[0m'
info()    { echo -e "${BLUE}[info]${NC} $*"; }
success() { echo -e "${GREEN}[ok]${NC}   $*"; }
warn()    { echo -e "${YELLOW}[warn]${NC} $*"; }

declare -a LINKS=(
    "zsh/.zprofile|$HOME/.zprofile"
    "zsh/.zshrc|$HOME/.zshrc"
    "git/.gitconfig|$HOME/.gitconfig"
    "git/.gitignore_global|$HOME/.gitignore_global"
    "ssh/config|$HOME/.ssh/config"
    "ghostty/config|$HOME/.config/ghostty/config"
    "starship/starship.toml|$HOME/.config/starship.toml"
    "nvim/.config/nvim|$HOME/.config/nvim"
    "karabiner/karabiner.json|$HOME/.config/karabiner/karabiner.json"
    "claude/settings.json|$HOME/.claude/settings.json"
)

link_file() {
    local src="$DOTFILES_DIR/$1"
    local dst="$2"

    if [[ ! -e "$src" ]]; then
        warn "Source missing, skipping: $src"
        return
    fi

    # Already the correct symlink — skip
    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
        success "Already linked: $dst"
        return
    fi

    # Backup any existing file or wrong symlink
    if [[ -e "$dst" || -L "$dst" ]]; then
        mkdir -p "$BACKUP_DIR/$(dirname "$1")"
        mv "$dst" "$BACKUP_DIR/$1"
        warn "Backed up: $dst → $BACKUP_DIR/$1"
    fi

    mkdir -p "$(dirname "$dst")"
    ln -sf "$src" "$dst"
    success "Linked: $dst"
}

do_link() {
    info "Creating symlinks from $DOTFILES_DIR..."
    for entry in "${LINKS[@]}"; do
        link_file "${entry%%|*}" "${entry##*|}"
    done

    # SSH permissions
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    if [[ -L "$HOME/.ssh/config" || -f "$HOME/.ssh/config" ]]; then
        chmod 600 "$HOME/.ssh/config"
    fi

    echo ""
    info "Done. Open a new terminal to pick up the new zsh config."
}

do_list() {
    printf "\n%-55s  %-10s\n" "TARGET" "STATUS"
    printf "%-55s  %-10s\n" "------" "------"
    for entry in "${LINKS[@]}"; do
        local src="$DOTFILES_DIR/${entry%%|*}"
        local dst="${entry##*|}"
        if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
            printf "%-55s  ${GREEN}linked${NC}\n" "$dst"
        elif [[ -e "$dst" ]]; then
            printf "%-55s  ${RED}conflict${NC}\n" "$dst"
        else
            printf "%-55s  ${YELLOW}missing${NC}\n" "$dst"
        fi
    done
    echo ""
}

do_unlink() {
    info "Removing dotfile symlinks..."
    for entry in "${LINKS[@]}"; do
        local src="$DOTFILES_DIR/${entry%%|*}"
        local dst="${entry##*|}"
        if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
            rm "$dst"
            success "Removed: $dst"
        fi
    done
}

case "${1:-link}" in
    link)   do_link   ;;
    list)   do_list   ;;
    unlink) do_unlink ;;
    *)
        echo "Usage: $(basename "$0") [link|list|unlink]"
        echo "  link   - Create all symlinks (backs up existing files)"
        echo "  list   - Show status of all managed symlinks"
        echo "  unlink - Remove all managed symlinks"
        exit 1
        ;;
esac
