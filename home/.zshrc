# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=3
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/dan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#autoload -U promptinit
PROMPT="[%W %@ $USERNAME %3~]%# "

setopt append_history
setopt inc_append_history
#setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_no_store
setopt hist_no_functions
setopt no_hist_beep
setopt hist_save_no_dups

# Set the xterm prompt
# make sure we're in an xterm!
case $TERM in (xterm*|rxvt)
    precmd () { print -Pn "\e]0;%n@%m: %~\a" }
    #preexec () { print -Pn "\e]0;%n@%m: $1\a" }
    ;;
esac

if [ -f $HOME/.shell ]; then
	. $HOME/.shell
fi
