#!/usr/bin/env bash
# Idempotent macOS system preferences
# Run: bash macos/defaults.sh

echo "Applying macOS defaults..."

# -- Dock --
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 48

# -- Finder --
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"  # search current folder

# -- Keyboard --
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false  # key repeat, not accent picker

# -- Trackpad --
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true  # tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# -- Screenshots --
defaults write com.apple.screencapture location "$HOME/Desktop"
defaults write com.apple.screencapture type "png"
defaults write com.apple.screencapture disable-shadow -bool true

# -- Misc --
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Restart affected apps
for app in "Dock" "Finder" "SystemUIServer"; do
    killall "$app" &>/dev/null || true
done

echo "Done. Some changes require a full logout/restart."
