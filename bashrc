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

# make less more friendly
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi




# Colorize man pages
# -----------------------------------------------------------------------------
#
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


# Coloize my logs
# -----------------------------------------------------------------------------
#
alias lapache='colortail -f /var/log/apache2/*.log'
alias lapacheerr='colortail -n 50 -f /var/log/apache2/error.log'
alias lauth='colortail -n 50 -f /var/log/auth.log'
alias ldaemon='colortail -n 50 -f /var/log/daemon.log'
alias lmess='colortail -n 50 -f /var/log/messages'
alias lsyslog='colortail -n 50 -f /var/log/syslog'
alias lfetchmail='colortail -n 50 -f /var/log/fetchmail.log'
alias lfirebird='colortail -n 50 -f /var/log/firebird.log'
alias liptables='/sbin/iptables -L -n -v'
alias lmail='colortail -n 50 -f /var/log/mail.log'
alias lmysql='colortail -n 50 -f /var/log/mysql/mysql.log'
alias lopencms='colortail -f /var/lib/tomcat6/webapps/ROOT/WEB-INF/logs/opencms.log'
alias ltomcat='colortail -f /var/log/tomcat6/*'
alias lsamba='colortail -n 50 -f /var/log/samba/log.*'
alias ldrbd='watch -n1 cat /proc/drbd'


# Standard Posix aliases
# -----------------------------------------------------------------------------
#
alias ls='ls --color=auto'
alias la='ls -lhaF --color=auto'
alias lt='ls -lhFtr --color=auto'
alias lta='ls -lahFtr--color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias mv='mv -iv'
alias rd='rmdir'
alias rm='rm -i --preserve-root'
alias less='less -r'
alias dusort='du -hs $(ls -d */) 2>/dev/null | sort -nr'


# Uubuntu Stuff
# -----------------------------------------------------------------------------
#
alias aupdate='sudo aptitude update'
alias aupgrade='sudo aptitude update && sudo aptitude upgrade'


# Archlinux Stuff
# -----------------------------------------------------------------------------
#
#complete -cf sudo   # Autocompletion for sudo
#complete -cf man    # Autocompletion for man


# Python stuff
# -----------------------------------------------------------------------------
#
export PYTHONWARNINGS=default                       # Give more python warnings
alias pyserve='python -m SimpleHTTPServer 5015'     # server cwd via http
alias venv='virtualenv env && \
            ./env/bin/pip install ipython'          # prepare virtual env
alias inotebook='./env/bin/ipython notebook --notebook-dir ~/workspace/notebooks/'


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


# Execute Keychain ssh
# -----------------------------------------------------------------------------
#
if [[ $HOSTNAME != BBS*.ipsw.dt.ept.lu && $HOSTNAME != gefoo.org ]]; then
    if [ -f "$HOME/.ssh/id_rsa" ]; then
        /usr/bin/keychain $HOME/.ssh/id_rsa
        . ~/.keychain/$HOSTNAME-sh
    fi
fi


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
    PROMPT_COMMAND=prompt_command_function
else
    PS1="${GREEN}\u@${BLUE}\h${RESET}:${RESET}\w \$ "
fi
unset color_prompt force_color_prompt


# Other global environment variables
# -----------------------------------------------------------------------------
#
export CHROMIUM_USER_FLAGS="--memory-model=low --purge-memory-button \
                            --enable-internal-flash"


# Add local binaries to path
# -----------------------------------------------------------------------------
#
if [[ -d ~/bin ]]; then
    export PATH=~/bin:$PATH
fi



