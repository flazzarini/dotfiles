# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# force xterm-256color TERM
if [ "$TERM" == "xterm" ]; then
    export TERM="xterm-256color"
elif [ "$TERM" == "rxvt-unicode-256color" ]; then
    export TERM="xterm-256color"
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
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
alias aupdate='sudo apt-get update'
alias aupgrade='sudo apt-get update && sudo apt-get upgrade'

# Python stuff
# -----------------------------------------------------------------------------
#
alias pyserve='python -m SimpleHTTPServer 5002'         # server cwd via http
alias venv='virtualenv env && \
            ./env/bin/pip install ipython'              # prepare virtual env
alias inotebook='ipython notebook --notebook-dir ~/workspace/notebooks/'


# Launchpad.net stuff
# -----------------------------------------------------------------------------
#
export DEBFULLNAME="Frank Lazzarini"
export DEBEMAIL="flazzarini@gmail.com"
export GPGKEY=C502163F


# Execute Keychain ssh
# -----------------------------------------------------------------------------
#
if [[ $HOSTNAME != *.ipsw.dt.ept.lu ]]; then
    /usr/bin/keychain $HOME/.ssh/id_rsa
    . ~/.keychain/$HOSTNAME-sh
fi


# My Prompt
# -----------------------------------------------------------------------------
#
#source ~/dotfiles/bashfunctions.sh


# Other global environment variables
# -----------------------------------------------------------------------------
#
export CHROMIUM_USER_FLAGS="--memory-model=low --purge-memory-button \
                            --enable-internal-flash"

# Proxy
# -----------------------------------------------------------------------------
#
if [[ $HOSTNAME == *.ipsw.dt.ept.lu ]]; then
    export http_proxy="http://bbs-pylon.ipsw.dt.ept.lu:3128"
    export https_proxy="http://bbs-pylon.ipsw.dt.ept.lu:3128"
    export no_proxy="localhost .ipsw.dt.ept.lu"
fi
