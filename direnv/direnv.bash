# direnv.bash
#
# Custom direnv eval script that only loads direnv if it exists on the system

# shellcheck disable=SC1090
source "$HOME/dotfiles/bash_functions"

DIRENV=$(which direnv)

if [ "$DIRENV" ]; then
  eval "$($DIRENV hook bash)"
fi
