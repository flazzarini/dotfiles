# Collection of helper functions
# -----------------------------------------------------------------------------
#
. "$HOME/dotfiles/lib/bash_colors"
. "$HOME/dotfiles/git-prompt.sh"

# Public: Verifies if a command exists on the system
#
# Takes a arbitary binary or file an verifies if that file exists
#
# $1 - File to verify
#
# Examples
#   command_exits foo
#
# Produces an exit code of 0 if command exists
command_exists() {
  # shellcheck disable=SC2039
  type "$1" &> /dev/null ;
}

# Public: Alternative man command
#
# Overwrites the man command with some color enhancements
man() {
  # shellcheck disable=SC2046
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;94m") \
    LESS_TERMCAP_md=$(printf "\e[1;94m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}


# Public: Backup up File
#
# Creates a copy of a file with the current timestamp preceding the filename
#
# $1 - File to backup #
# Examples
#   buf my_filename.txt
#
# Creates a backup of `filename.txt` to `20200101-12_00-filename.txt`
buf() {
  test -f "$1" || echo "$1 does not exist" && return 1
  cp "$1" "$(date +%Y%m%d-%H_%M)-$1";
}


# Fetch last exit code and produce either checkmark or crossmark depndening on
# the exit-code
exit_code() {
  if [ $? -eq 0 ]; then
    echo "${GREEN112}✓${RESET}"
  else
    echo "${RED}❌${RESET}"
  fi
}


# Public: Prompt Command for PS1
prompt_command_function() {
  EXIT_CODE=$(exit_code)
  SIZE="$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')"
  GIT_PS1_DESCRIBE_STYLE="contains"
  GIT_BRANCH=$(__git_ps1)  # Using bash-git-prompt https://github.com/magicmonty/bash-git-prompt

  # Save history
  history -a; history -c; history -r

  PS1_LINE1="${RESET}${BAR}┌(${BLUE111}\u@\h${BAR})─(${YELLOW220}\j${BAR})─(${WHITE}\t${BAR})${RED}${GIT_BRANCH}${RESET}"
  PS1_LINE2="${RESET}${BAR}└─(${GREEN112}\w${BAR})─(${GREEN112}${SIZE}${BAR})-(${EXIT_CODE}${BAR})──> ${RESET}$ "
  PS1="$PS1_LINE1\n$PS1_LINE2"
}


# Public: Login on docker registry with openshift creds
oc_docker_login() {
  which oc
  oc whoami
  which docker
  docker login \
    --username "$(oc whoami)" \
    --password "$(oc whoami -t)" \
    registry.ipsw.dt.ept.lu
}

# Git Tag Alias show only latest 10 tags
gitags() {
  git tag --sort=-v:refname | head -n 10 | tac
}


# vim: set filetype=sh:
