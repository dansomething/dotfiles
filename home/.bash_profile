#!/usr/bin/env bash

if [ -f /etc/profile ]; then
  # Prevent duplication of paths in tmux on macos
  if [ -n "$TMUX" ] && [ "$(uname)" == 'Darwin' ]; then
    # shellcheck disable=SC2123
    PATH=""
  fi
  # shellcheck source=/dev/null
  source /etc/profile
fi

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  # shellcheck source=/dev/null
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# ---------------
# General Options
# ---------------

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Enable VI mode
set -o vi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null
done

# ------------------------------------------
# SMARTER TAB-COMPLETION (Readline bindings)
# ------------------------------------------

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

# ----------------
# Additional Tools
# ----------------

# https://github.com/junegunn/fzf
hash fzf >/dev/null 2>&1 && {
  export FZF_DEFAULT_OPTS='--bind ctrl-d:page-down,ctrl-u:page-up'
  hash ag >/dev/null 2>&1 && {
    export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
  }
  hash rg >/dev/null 2>&1 && {
    export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
  }
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  # shellcheck source=/dev/null
  [ -r "$HOME/.fzf.bash" ] && source "$HOME/.fzf.bash"
}

# https://github.com/clvv/fasd
hash fasd >/dev/null 2>&1 && {
  fasd_cache="$HOME/.fasd-init-bash"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache
  _fasd_bash_hook_cmd_complete v m j o
}

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# If possible, add tab completion for many more commands
# shellcheck source=/dev/null
[[ -r "/etc/bash_completion" ]] && source "/etc/bash_completion"

# These require Brew
hash brew >/dev/null 2>&1 && {
  HOMEBREW_PREFIX=$(brew --prefix)

  [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]] && . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  [[ -r "${HOMEBREW_PREFIX}/etc/grc.bashrc" ]] && . "${HOMEBREW_PREFIX}/etc/grc.bashrc"

  unset HOMEBREW_PREFIX
}

HOMESHICK="$HOME/.homesick/repos/homeshick"
[[ -r "${HOMESHICK}/homeshick.sh" ]] && {
  . "${HOMESHICK}/homeshick.sh"
  . "${HOMESHICK}/completions/homeshick-completion.bash"

  hash git >/dev/null 2>&1 && {
    homeshick --quiet refresh 2
  }
}
