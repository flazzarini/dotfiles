#!/usr/bin/env bash
#
# Bash completion support for Fabric (http://fabfile.org/)
#
# https://stackoverflow.com/questions/31810895/how-can-i-create-command-autocompletion-for-fabric
#

_fab() {
  local cur
  COMPREPLY=()
  # Variable to hold the current word
  cur="${COMP_WORDS[COMP_CWORD]}"

  # Build a list of the available tasks
  local cmds=$(fab --complete 2>/dev/null)

  # Generate possible matches and store them in the
  # array variable COMPREPLY
  COMPREPLY=($(compgen -W "${cmds}" $cur))
}

# Assign the auto-completion function for our command.
complete -F _fab fab
