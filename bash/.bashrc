# ~/.bashrc: executed by bash(1) for non-login shells.

# STARTUP
# ----------------------------------------------------------------------------- 
# If not running interactively, don't do anything. Removing this can cause 
# trouble with file transfers using rcp, scp or sftp.
case $- in
    *i*) ;;
      *) return;;
esac

# If tmux is present, execute it when the shell starts.
if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
    exec tmux new-session -A
fi


# ALIASES 
# ----------------------------------------------------------------------------- 
# Use .bash_aliases file to store aliases.
if [ -f "${HOME}/.bash_aliases" ]; then
    . "${HOME}/.bash_aliases"
fi


# FUNCTIONS
# ----------------------------------------------------------------------------- 
# Use .bash_functions file to store functions.
if [ -f "${HOME}/.bash_functions" ]; then
    . "${HOME}/.bash_functions"
fi


# PROMPT
# ----------------------------------------------------------------------------- 
# Use .bash_prompt file to modify PS1 prompt.
if [ -f "${HOME}/.bash_prompt" ]; then
    . "${HOME}/.bash_prompt"
fi


# COMPLETIONS
# ----------------------------------------------------------------------------- 
# Enable programmable completion features (you don't need to enable this, if 
# it's already enabled in /etc/bash.bashrc and /etc/profile sources 
# /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /usr/local/etc/bash_completion ]; then
        . /usr/local/etc/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi


# HISTORY
# ----------------------------------------------------------------------------- 
# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Set history size and history file size to something sensible. For more 
# info on setting history length see HISTSIZE and HISTFILESIZE in bash(1).
HISTSIZE=1000
HISTFILESIZE=2000

# Append to the history file, don't overwrite it.
shopt -s histappend


# WINDOW
# ----------------------------------------------------------------------------- 
# Check the window size after each command and, if necessary, update the values 
# of LINES and COLUMNS.
shopt -s checkwinsize


# GLOBBING
# ----------------------------------------------------------------------------- 
# If set, the pattern "**" used in a pathname expansion context will match all 
# files and zero or more directories and subdirectories.
# Example: `ls dir/**/*.ext`
#shopt -s globstar
