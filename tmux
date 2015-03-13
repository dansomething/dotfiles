#!/usr/bin/env bash

# Install tmux plugins manager
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Install tpm plugins.
# see: https://github.com/tmux-plugins/tpm/wiki/Installing-plugins-via-the-command-line-only
tmux start-server
tmux new-session -d
$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh
tmux kill-server
