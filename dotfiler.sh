#!/bin/bash
#
# Version.....: 0.1.2
# Author......: Pavel Mamontov
# License.....: MIT (See LICENSE.md)
# Description.: Script used to manage dotfiles. It creates symlinks 
#               from a dotfiles directory to home directory.

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

    ${B}$0${N} is a script used to manage dotfiles from a central location. 
    The dotfiles directory should have subdirectories, corresponding to various 
    applications, containing their respective config files (dotfiles). 
    The script creates symlinks from these dotfiles to your home directory. 
    You can then store the entire dotfiles directory on a VCS or the cloud and 
    deploy it on any machine by simply cloning or copying it and this script. 

${B}Usage:${N}
    
    ${B}$0${N} [options] [${U}package${RU}]

${B}Options:${N}

    ${B}-h${N}, ${B}--help${N}
        Display this help message

    ${B}-l${N}, ${B}--list${N}
        List all available packages 

    ${B}-L${N}, ${B}--list-long${N}
        List all available packages, including their contents 

    ${B}-u${N}, ${B}--update${N}
        Perform a git pull, update and init any git submodules. Equivalent to:
        \`git pull; git submodule update --init\`

    ${B}-s${N}, ${B}--symlink${N} ${U}package${RU}
        Create symlinks in $HOME for files found in ${U}package${RU} directory 

    ${B}-r${N}, ${B}--remove-symlinks${N} ${U}package${RU}
        Remove symlinks for given ${U}package${RU} from $HOME 

${B}Examples:${N}

    $0 ${B}-s${N} ${U}bash${RU}
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
               -exec tree --noreport -a -L 3 {} \;
    else
        ls -A */
    fi
}

symlink () {
    find $(pwd)/$1 -maxdepth 1 -name ".*" -exec ln -siv {} $HOME \;
}

removeSymlinks () {
    for lnk in $(find $1 -type f -exec basename {} \;)
    do 
        [ -L $HOME/$lnk ] && rm -iv $HOME/$lnk
    done
}

update () {
    (set -x; git pull; git submodule update --init)
}

# Transform long options to short ones to get around getopts limitation
for arg in "$@"; do
    shift
    case "$arg" in
        "--help"            ) set -- "$@" "-h" ;;
        "--list"            ) set -- "$@" "-l" ;;
        "--list-long"       ) set -- "$@" "-L" ;;
        "--update"          ) set -- "$@" "-u" ;;
        "--symlink"         ) set -- "$@" "-s" ;;
        "--remove-symlinks" ) set -- "$@" "-r" ;;
        "--"*               ) echo "Invalid option: $arg" >&2; exit 1 ;;
        *                   ) set -- "$@" "$arg" ;;
    esac
done

# Process command line options
while getopts :hlLps:c:d:u opt; do
    case $opt in
        h ) usage ;;
        l ) list ;;
        L ) listLong ;;
		u ) update ;;
        s ) symlink $OPTARG ;;
        r ) removeSymlinks $OPTARG ;;
        \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
        : ) echo "Option -$OPTARG requires and arguement" >&2; exit 1 ;;
    esac
done

# Remove options from positional parameters
shift $((OPTIND - 1))
