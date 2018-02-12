# vim: set filetype=sh:

# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
cd_func ()
{
    local x2 the_new_dir adir index
    local -i cnt

    if [[ $1 ==  "--" ]]; then
        dirs -v
        return 0
    fi

    the_new_dir=$1
    [[ -z $1 ]] && the_new_dir=$HOME

    if [[ ${the_new_dir:0:1} == '-' ]]; then
        # Extract dir N from dirs
        index=${the_new_dir:1}
        [[ -z $index ]] && index=1
        adir=$(dirs +$index)
        [[ -z $adir ]] && return 1
        the_new_dir=$adir
    fi

    # '~' has to be substituted by ${HOME}
    [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

    # Now change to the new dir and add to the top of the stack
    pushd "${the_new_dir}" > /dev/null
    [[ $? -ne 0 ]] && return 1
    the_new_dir=$(pwd)

    # Trim down everything beyond 11th entry
    popd -n +11 2>/dev/null 1>/dev/null

    # Remove any other occurence of this dir, skipping the top of the stack
    for ((cnt=1; cnt <= 10; cnt++)); do
        x2=$(dirs +${cnt} 2>/dev/null)
        [[ $? -ne 0 ]] && return 0
        [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
        if [[ "${x2}" == "${the_new_dir}" ]]; then
            popd -n +$cnt 2>/dev/null 1>/dev/null
            cnt=cnt-1
        fi
    done

    return 0
}
alias cd=cd_func

# Quickly check if a port is open (alternative to netcat or telnet)
# Usage: testport <servername || ip> <port> <protocol>
testport() {
    server=$1; port=$2; proto=${3:-tcp}
    exec 6<>/dev/$proto/$server/$port 
    (( $? == 0 )) && exec 6<&- && exec 6>&-
}

# Find out which processes are listening on a port
# Usage listening <port>
listening() {
    lsof -n -i TCP:$1 | grep LISTENING
}

# Automatically pick the right application to unpack a compressed file based on
# file extension.
# Taken from http://dotshare.it/dots/1436/
unpack () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.tar.xz)    tar xvJf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *.xz)        unxz $1        ;;
            *.exe)       cabextract $1  ;;
            *)           echo "\`$1': Unknown method of file compression" ;;
        esac
    else
        echo "\`$1' no foud"
    fi
}
