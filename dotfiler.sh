#!/bin/bash
#
# Version.....: 0.1.0
# Author......: Pavel Mamontov
# License.....: MIT (See LICENSE.md)
# Description.: This is a script used to manage dotfiles. It creates symlinks 
#               from a dotfiles directory to home directory. Basically functions
#               the same way as GNU Stow, but without having to install anything.
#

# Set the -e shell option so the script exits immediately if any command within
# it exits with a non-zero status.
set -e

# Set PATH environment variable
export PATH="/usr/local/bin:/usr/bin:/bin"

usage () {
# Variables for formatting
U=$(tput smul)  # Underline
RU=$(tput rmul) # Remove underline
B=$(tput bold)  # Bold
N=$(tput sgr0)  # Normal
cat << EOF
     _       _    __ _ _           
  __| | ___ | |_ / _(_| | ___ _ __ 
 / _\` |/ _ \| __| |_| | |/ _ | '__|
| (_| | (_) | |_|  _| | |  __| |   
 \__,_|\___/ \__|_| |_|_|\___|_|   

${B}Synopsis:${N}

    ${B}$0${N} is a script used to manage dotfiles from a central location. The dotfiles directory 
    should have subdirectories, corresponding to various applications, containing their respective
    config files (dotfiles). The script creates symlinks from these dotfiles to your home directory.
    You can then store the entire dotfiles directory on a VCS or the cloud and deploy it on any
    machine by simply cloning or copying it and this script. 

${B}Usage:${N}
    
    ${B}$0${N} [ options ] ${U}package${RU}

${B}Options:${N}

    ${B}-h${N}  Display this help message

    ${B}-l${N}  List all available packages 

    ${B}-L${N}  List all available packages, including their contents 

    ${B}-s${N} ${U}package${RU}, ${B}-c${N} ${U}package${RU}
        Create symlinks in $HOME for files found in ${U}package${RU} directory 

    ${B}-d${N} ${U}package${RU}
        Delete symlinks for given ${U}package${RU} from $HOME 

    ${B}-u${N} ${U}package${RU} 
        Update symlinks for given ${U}package${RU} 

${B}Examples:${N}

    $0 ${B}-s${N} ${U}vim${RU}
        Symlink dotfiles located in vim directory into $HOME  

EOF
}

list () {
    if command -v tree>/dev/null; then
        tree -d
    else 
        ls -d */
    fi
}

listLong () {
    if command -v tree>/dev/null; then
        find . -maxdepth 1 -type d -not \( -path '*git*' -o -path '.' \) \
               -exec tree --noreport -a -L 1 {} \;
    else
        ls -A */
    fi
}

store () {
    find $(pwd)/$1 -maxdepth 1 -name ".*" -exec ln -s {} $HOME \;
}

delete () {
    for lnk in $(find $1 -type f -exec basename {} \;)
    do 
        [ -L $HOME/$lnk ] && rm -f $HOME/$lnk
    done
}

# Process command line options
while getopts :hlLs:c:d:u: opt; do
    case $opt in
        h) 
            usage 
        ;;
        l)
            list
        ;;
        L)
            listLong
        ;;
        s|c) 
            store $OPTARG 
        ;;
        d) 
            delete $OPTARG
        ;;
        u)
            delete $OPTARG
            store $OPTARG 
        ;;
        ?) 
            echo "Invalid option: -$OPTARG" >&2
            exit 1 
        ;;
        :) 
            echo "Option -$OPTARG requires and arguement" >&2
            exit 1 
        ;;
    esac
done
shift $((OPTIND - 1))
