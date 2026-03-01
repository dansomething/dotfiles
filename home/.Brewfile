# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew "coreutils" if OS.mac?
# Install some other useful utilities like `sponge`.
brew "moreutils" if OS.mac?
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew "findutils" if OS.mac?
# Install a modern version of Bash.
brew "bash", postinstall: 'if ! grep -F -q "${HOMEBREW_PREFIX}/bin/bash" /etc/shells; then echo "${HOMEBREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells; chsh -s "${HOMEBREW_PREFIX}/bin/bash"; fi' if OS.mac?
brew "bash-completion@2" if OS.mac?

# Install more recent versions of some macOS tools.
brew "git" if OS.mac?
brew "grep" if OS.mac?

# Install other useful binaries.

# Symlink bash-git-prompt for cross-platform convenience
brew "bash-git-prompt", postinstall: "ln -sf ${HOMEBREW_PREFIX}/opt/bash-git-prompt/share ~/.bash-git-prompt"
brew "bat"
brew "cmake" if OS.mac? # for tmux-mem-cpu-load
brew "direnv"
brew "eza"
brew "fzf", postinstall: "${HOMEBREW_PREFIX}/opt/fzf/install --no-update-rc"
brew "gawk" if OS.mac? # for Morantron/tmux-fingers
brew "gh"
brew "git-delta"
brew "gnu-sed" if OS.mac? # for vim mergetool diffconflicts script
brew "grc"     # colourize log files and command output
brew "htop"
brew "jq"
brew "markdownlint-cli"
brew "ncdu"
brew "neovim"
brew "nodejs"
brew "prettier"
brew "pv"
brew "reattach-to-user-namespace" if OS.mac?
brew "rename" # for convenience
brew "ripgrep"
brew "shellcheck"
brew "shfmt"
brew "stylua"
brew "tmux"
brew "tree"
brew "vivid" # generator for LS_COLORS
brew "watch"
brew "watchman"
brew "yamllint"
brew "zoxide"

cask "appcleaner"
cask "coconutbattery"
cask "firefox"
cask "font-hack-nerd-font"
cask "google-chrome"
cask "google-drive"
cask "hammerspoon"
cask "handbrake-app"
cask "keepassxc"
cask "keepingyouawake"
cask "macvim-app"
cask "paragon-extfs"
cask "private-internet-access"
cask "silentknight"
cask "slack"
cask "the-unarchiver"
cask "tuxera-ntfs"
cask "utm"
cask "vlc"
