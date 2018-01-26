# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything.
# Removing this can cause trouble with file transfers using 
# rcp, scp or sftp.
case $- in
    *i*) ;;
      *) return;;
esac

# If tmux is present, execute it when the shell starts.
if command -v tmux>/dev/null; then
    [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi


# ALIASES 
# Use .bash_aliases file to store aliases.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# FUNCTIONS
# Use .bash_functions file to store functions.
if [ -f "${HOME}/.bash_functions" ]; then
  source "${HOME}/.bash_functions"
fi


# COMPLETIONS
# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# HISTORY
# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Append to the history file, don't overwrite it
shopt -s histappend


# WINDOW
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# GLOBBING
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# Example: `ls dir/**/*.ext`
shopt -s globstar


# DEBIAN ONLY
# Make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi


# PROMPT
# Use color prompt if using xterm and xterm-color is enabled. 
case "$TERM" in
    xterm-*color) color_prompt=yes;;
esac

# Force color prompt for all terminal emulators, unless tput says the
# terminal can not do colors. Uncomment line below to stop this behaviour.
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
    	color_prompt=
    fi
fi

# Set some color variables to makes things easier on the eyes.
c_r="\[\e[0m\]"     # Reset all styling
c_b="\[\e[1m\]"     # Standard bold
c_rb="\[\e[31m\]" # Red bold
c_bb="\[\e[1;34m\]" # Blue bold
c_p="\[\e[35m\]"    # Purple

# Show a notice when connected through ssh
if [ $( echo $SSH_CLIENT | wc -c) -gt 1 ]; then
    p_ssh="[${c_rb}ssh${c_r}${c_b}]─"
else
    p_ssh=""
fi

# User name display, red if root.
if [ $USER = root ]; then
    p_user="${c_rb}\u${c_r}${c_b}"
else
    p_user="\u"
fi

# Host
p_host="\h"

# User + host
p_user_host="[${p_user}@${p_host}]"

# Working directory
p_wd="[${c_bb}\w${c_r}${c_b}]"

# Disable default python virtual environment notification. Use the one
# defined in .bash_functions called python_virtualenv()
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Two line fancy prompt that inserts a newline before every
# command to visually separate things.
if [ "$color_prompt" = yes ]; then
    if [ $(uname -s) == "Darwin" ]; then
        PS1="\n┌─${p_ssh}\$(python_virtualenv)[${c_b}${p_user}@\h${c_r}]─[${c_bb}\w${c_r}]\n└──╼${c_r} "
    else
        PS1="\n${c_b}┌─${p_ssh}\$(python_virtualenv)${p_user_host}─${p_wd}\n└──╼${c_r} "
    fi
else
    PS1="\n┌─[\u@\h]─[\w]\n└──╼ "
fi
unset color_prompt force_color_prompt
