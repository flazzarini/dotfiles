# bashrc
#
# Author: Frank Lazzarini

# Standard Ubuntu bashrc
# -----------------------------------------------------------------------------
#
[ -z "$PS1" ] && return
HISTCONTROL=ignoredups:ignorespace            # don't put duplicated to history
shopt -s histappend                           # append to hist not overwrite
HISTSIZE=1000                                 # History size length
HISTFILESIZE=2000                             # Hitstory filesize
shopt -s checkwinsize                         # Check window size after each
                                              # command update LINES COLUMNS

# Source bash aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Source bash completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# Helper functions
# -----------------------------------------------------------------------------
#
command_exists() {
    type "$1" &> /dev/null ;
}


# Environment Variables
# -----------------------------------------------------------------------------
#
EDITOR_CMD=vim
if [ -x "$(command -v nvim)" ]; then
    EDITOR_CMD=nvim
fi

export EDITOR=$EDITOR_CMD
export VISUAL=$EDITOR_CMD
export PGPASS="~/.pgpass"
export PGUSER="flazzarini"
export DISPLAY=":0"


# Keychain
# -----------------------------------------------------------------------------
#
if [[ $HOSTNAME != BBS*.ipsw.dt.ept.lu && $HOSTNAME != *.gefoo.org ]]; then
    if [ -f "$HOME/.ssh/id_rsa" ]; then
        $(which keychain) $HOME/.ssh/id_rsa
        . ~/.keychain/$HOSTNAME-sh
    fi
fi


# Colorize man pages
# -----------------------------------------------------------------------------
#
# make less more friendly
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

man() {
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


# Some functions
# -----------------------------------------------------------------------------
#
buf() {
    cp $1 $(date +%Y%m%d-%H_%M)-$1;
}


# Launchpad.net stuff
# -----------------------------------------------------------------------------
#
export DEBFULLNAME="Frank Lazzarini"
export DEBEMAIL="flazzarini@gmail.com"
export GPGKEY=C502163F


# My Prompt
# -----------------------------------------------------------------------------
#
source ~/dotfiles/lib/bash_colors

# Remap TERM environment variable
case "$TERM" in
    xterm*|rxvt-unicode*) TERM="xterm-256color" ;;
esac

# If we have a colorful terminal set color_prompt to yes
case "$TERM" in
    xterm-256color) color_prompt=yes ;;
    screen-256color) color_prompt=yes ;;
    rxvt-unicode-256color) color_prompt=yes ;;
esac


function prompt_command_function() {
    GIT_BRANCH="$(~/dotfiles/bin/gitbranch.sh)"
    SIZE="$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')"

    PS1_LINE1="${RESET}${BAR}┌(${BLUE111}\u@\h${BAR})─(${YELLOW220}\j${BAR})─(${WHITE}\t${BAR})─> ${RED}${GIT_BRANCH}${RESET}"
    PS1_LINE2="${RESET}${BAR}└─(${GREEN112}\w${BAR})─(${GREEN112}${SIZE}${BAR})──> ${RESET}$ "
    PS1="$PS1_LINE1\n$PS1_LINE2"
}

if [ "$color_prompt" = yes ]; then
    # Set prompt
    PROMPT_COMMAND=prompt_command_function

    # Set color theme
    COLOR_THEME=molokai
    source ~/dotfiles/terminal-color-theme/color-theme-${COLOR_THEME}/${COLOR_THEME}.sh
else
    PS1="${GREEN}\u@${BLUE}\h${RESET}:${RESET}\w \$ "
fi
unset color_prompt force_color_prompt


# Other global environment variables
# -----------------------------------------------------------------------------
#
export CHROMIUM_USER_FLAGS="--memory-model=low --audio-buffer-size=4096 --enable-webgl"
export GOPATH="$HOME/src"


# Add local binaries to path
# -----------------------------------------------------------------------------
#

# Add custom binaries in home folder to PATH
if [[ -d ~/bin ]]; then
    export PATH=~/bin:$PATH
fi

# Add Node JS environment to path
if [[ -d ~/opt/nodeenv/node_modules/.bin/ ]]; then
    export PATH=~/opt/nodeenv/node_modules/.bin/:$PATH
fi

# Add npm bin if avaiable
if [[ -d ~/node_modules/.bin ]]; then
    export PATH=/home/users/frank/node_modules/.bin:$PATH
fi

# CREATE Virtualenv environment variable
if [[ -d ~/.env ]]; then
    export VIRTUAL_ENV=~/.env
fi
