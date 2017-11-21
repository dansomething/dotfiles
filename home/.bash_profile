if [ -f /etc/profile ]; then
  PATH=""
  source /etc/profile
fi

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

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

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Initialize fasd if available
hash fasd >/dev/null 2>&1 && {
  eval "$(fasd --init auto)"
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
[[ -s "/etc/bash_completion" ]] && source "/etc/bash_completion"

# These require Brew
hash brew >/dev/null 2>&1 && {
  [[ -s $(brew --prefix nvm)/nvm.sh ]] && {
    export NVM_DIR="$HOME/.nvm"
    source $(brew --prefix nvm)/nvm.sh
  }

  [[ -s $(brew --prefix)/etc/bash_completion ]] && source $(brew --prefix)/etc/bash_completion

  [[ -s $(brew --prefix)/etc/grc.bashrc ]] && source $(brew --prefix)/etc/grc.bashrc

  [[ -s $(brew --prefix)/etc/autojump.sh ]] && source $(brew --prefix)/etc/autojump.sh
}

[[ -s "$HOME/.homesick/repos/homeshick/homeshick.sh" ]] && {
  source "$HOME/.homesick/repos/homeshick/homeshick.sh"
  source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

  hash git >/dev/null 2>&1 && {
    homeshick --quiet refresh
  }
}

# Load Travis CI if available
[ -s "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
