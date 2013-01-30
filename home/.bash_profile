# Add `~/.bin` to the `$PATH`
export PATH="$HOME/.bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && source "$file"
done
unset file

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

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# If possible, add tab completion for many more commands
[[ -s "/etc/bash_completion" ]] && source "/etc/bash_completion"

# These require Brew
command -v brew >/dev/null 2>&1 && {
    # Brew Bash Completion
    [[ -s $(brew --prefix)/etc/bash_completion ]] && source $(brew --prefix)/etc/bash_completion

    # Enable Colourify
    GRC_BASHRC=$(brew --prefix)/etc/grc.bashrc
    [[ -s $GRC_BASHRC ]] && source $GRC_BASHRC
    unset GRC_BASHRC
}

# Macports Bash Completion
[[ -s "/opt/local/etc/profile.d/bash_completion.sh" ]] && source "/opt/local/etc/profile.d/bash_completion.sh"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Load Grails autocomplete
command -v gawk >/dev/null 2>&1 && {
    [[ -s "$HOME/.bash_completion.d/grails" ]] && source "$HOME/.bash_completion.d/grails"
}

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "$HOME/.gvm/bin/gvm-init.sh" && -z $(which gvm-init.sh | grep '/gvm-init.sh') ]] && source "$HOME/.gvm/bin/gvm-init.sh"
