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
    xterm-color) color_prompt=yes;;
esac

# Force color prompt for all terminal emulators, unless tput says the
# terminal can not do colors.
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
c_bold="\[\e[1m\]"
c_blue_bold="\[\e[1;34m\]"
c_red_bold="\[\e[1;31m\]"
c_reset="\[\e[0m\]"

# Display root's username in red.
#if [ $USER = root ]; then
#    user_color_prompt="${c_red_bold}\u${c_bold}"
#else
#    user_color_prompt="\u"
#fi

# PS1 when using ssh
if [ $( echo $SSH_CLIENT | wc -c) -gt 1 ]; then
    ssh_color_prompt="[${c_red_bold}ssh${c_reset}${c_bold}]─"
else
    ssh_color_prompt=""
fi

# Disable default python virtual environment notification
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Two line fancy prompt that inserts a newline before every
# command to visually separate things.
if [ "$color_prompt" = yes ]; then
    if [ $(uname -s) == "Darwin" ]; then
        PS1="\n┌─${ssh_color_prompt}\$(python_virtualenv)[${c_bold}${user_color_prompt}@\h${c_reset}]─[${c_blue_bold}\w${c_reset}]\n└──╼${c_reset} "
    else
        PS1="\n${c_bold}┌─${ssh_color_prompt}\$(python_virtualenv)[${user_color_prompt}@\h]─[${c_blue_bold}\w${c_reset}${c_bold}]\n└──╼${c_reset} "
    fi
else
    #PS1="\n┌─${ssh_color_prompt}\$(python_virtualenv)"
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
