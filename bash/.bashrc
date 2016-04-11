# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
#case $- in
#    *i*) ;;
#      *) return;;
#esac

# If tmux is present, execute it when the shell starts
if command -v tmux>/dev/null; then
    [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Functions.
# Use a different file for functions
if [ -f "${HOME}/.bash_functions" ]; then
  source "${HOME}/.bash_functions"
fi

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

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
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

# Set some color variables to makes things easier on the eyes
c_bold="\[\e[1m\]"
c_blue_bold="\[\e[1;34m\]"
c_red_bold="\[\e[1;31m\]"
c_reset="\[\e[0m\]"

# Display root's username in red
if [ $USER = root ]; then
    user_color_prompt="${c_red_bold}\u${c_bold}"
else
    user_color_prompt="\u"
fi

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
    #PS1="${debian_chroot:+($debian_chroot)}\n${c_bold}┌─[${user_color_prompt}@\h]─[${c_blue_bold}\w${c_bold}]\$(python_virtualenv)\n${c_bold}└──╼${c_reset} "
    PS1="\n${c_bold}┌─${ssh_color_prompt}[${user_color_prompt}@\h]─[${c_blue_bold}\w${c_reset}${c_bold}]\$(python_virtualenv)\n└──╼${c_reset} "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
