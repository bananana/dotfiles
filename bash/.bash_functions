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

# This function is used in PS1 prompt to notify user when python virtualenv
# is activated.
function python_virtualenv(){
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv="${VIRTUAL_ENV##*/}"
    else
        venv=""
    fi
    [[ -n "$venv" ]] && printf "[\e[35m$venv\e[0m\e[1m]─"
}
