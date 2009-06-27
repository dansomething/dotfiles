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
#promptinit
#prompt redhat
#PROMPT="[%W%@ $USERNAME@%m %3~]%# "
PROMPT="[%W%@ $USERNAME %3~]%# "

HISTSIZE=100000
SAVEHIST=100000
HISTFILE=$HOME/.zsh_history

# Set the xterm prompt
# make sure we're in an xterm!
case $TERM in (xterm*|rxvt)
    precmd () { print -Pn "\e]0;%n@%m: %~\a" }
    #preexec () { print -Pn "\e]0;%n@%m: $1\a" }
    ;;
esac

if [ -f ~/.shell_exports ]; then
	. ~/.shell_exports
fi

if [ -f ~/.shell_aliases ]; then
	. ~/.shell_aliases
fi
