#!/usr/bin/env bash
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

# Obtain the directory where the script is located
readonly DIR="$(cd "$(dirname "${0}")" && pwd)"

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

    ${B}$0${N} is a script to manage dotfiles from a central directory. 
    The dotfiles directory should have subdirectories, corresponding to various
    programs, containing their respective config files (dotfiles). The script 
    creates symlinks from these dotfiles to your home directory. You can store 
    the entire dotfiles directory on a VCS or the cloud and deploy it on any 
    machine by simply cloning or copying it. 

${B}Usage:${N}
    
    ${B}$0${N} [${B}-hlLu${N}] [${B}-s${N}|${B}-r${N}|${B}-x${N}|${B}-i${N} ${U}dir${RU}] 

${B}Options:${N}

    ${B}-h${N}, ${B}--help${N}
        Display this help message

    ${B}-l${N}, ${B}--list${N}
        List all available config directories 

    ${B}-L${N}, ${B}--list-long${N}
        List all available config directories, including their contents 

    ${B}-u${N}, ${B}--update${N}
        Perform a git pull, update and init any git submodules

    ${B}-s${N}, ${B}--symlink${N} ${U}dir${RU}
        Create symlinks in $HOME for files found in ${U}dir${RU}

    ${B}-r${N}, ${B}--remove-symlinks${N} ${U}dir${RU}
        Remove symlinks for given ${U}dir${RU} from $HOME 

    ${B}-x${N}, ${B}--exclude${N} ${U}dir${RU}
        Exclude ${U}dir${RU} from git index and remove it from $DIR

    ${B}-i${N}, ${B}--include${N} ${U}dir${RU}
        Reverse ${B}--exclude${N} by removing ${U}dir${RU} from .git/info/exclude
        and checking it out from the repo

${B}Examples:${N}

    $0 ${B}-s${N} ${U}bash${RU}
        Symlink dotfiles located in bash directory into $HOME  

EOF
}

list () {
    #cd $DIR
    if command -v tree>/dev/null; then
        tree -d
    else 
        ls -d */
    fi
}

listLong () {
    #cd $DIR
    if command -v tree>/dev/null; then
        find . -maxdepth 1 -type d -not \( -path '*git*' -o -path '.' \) \
               -exec tree --noreport -a -L 3 {} \;
    else
        ls -A */
    fi
}

symlink () {
    find $DIR/$1 -maxdepth 1 -name ".*" -exec ln -siv {} $HOME \;
}

removeSymlinks () {
    for lnk in $(find $DIR/$1 -type f -exec basename {} \;)
    do 
        [ -L $HOME/$lnk ] && rm -iv $HOME/$lnk
    done
}

update () {
    (set -x; git pull; git submodule update --init)
}

remote () {
    if [ -d $DIR/$OPTARG ]; then
        dir_base="$(basename $DIR)"
        src="$DIR/$OPTARG"

        # Get the remote login credentials
        read -p "Remote user@host: " dest

        (set -x; \
         rsync -e ssh --rsync-path="mkdir -p ~/$dir_base/ && rsync" \
               -r $src $dest:~/$dir_base/)
    else
        echo "Config directory does not exist: $OPTARG"
    fi
}

exclude () {
    # Exclude unwanted config from git index and remove it. 
    # To list excluded run: git ls-files -v | grep "^[[:lower:]]"
    if [ -d $DIR/$OPTARG ]; then
        (set -x; \
         git ls-files -z $DIR/$OPTARG | \
         xargs -0 git update-index --assume-unchanged; \
         rm -r $DIR/$OPTARG)
        echo "$OPTARG added to .git/info/exclude"
    else
        echo "Config directory does not exist: $OPTARG"
    fi
}

include () {
    # Include previously excluded config and check it out from the repo
    if [ ! "$(git ls-files -v | grep -q $OPTARG)" ]; then
        inc="$(git ls-files -v | grep $OPTARG | cut -d ' ' -f 2)"
        (set -x; \
         git update-index --no-assume-unchanged $inc; \
         git fetch; \
         git checkout -- $OPTARG/)
    else
        echo "$OPTARG is not in .git/info/exclude"
    fi
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
        "--remote"          ) set -- "$@" "-e" ;;
        "--exclude"         ) set -- "$@" "-x" ;;
        "--include"         ) set -- "$@" "-i" ;;
        "--"*               ) echo "Invalid option: $arg" >&2; exit 1 ;;
        *                   ) set -- "$@" "$arg" ;;
    esac
done

# Process command line options
while getopts :hlLus:r:e:x:i: opt; do
    case $opt in
        h ) usage ;;
        l ) list ;;
        L ) listLong ;;
		u ) update ;;
        s ) symlink $OPTARG ;;
        r ) removeSymlinks $OPTARG ;;
        e ) remote ;;
        x ) exclude ;;
        i ) include ;;
        \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
        : ) echo "Option -$OPTARG requires and arguement" >&2; exit 1 ;;
    esac
done

# Remove options from positional parameters
shift $((OPTIND - 1))
