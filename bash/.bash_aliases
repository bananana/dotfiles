# enable color support of directory listing and grep 
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# directory listing 
alias ll='ls -alFh'
alias la='ls -Ah'
alias l='ls -CFh'

# directory navigation
alias .='cd ../'
alias ..='cd ../../'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../../'

# Show open ports
alias ports='netstat -tulanp'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
if [ -x /usr/bin/notify-send ]; then
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi
