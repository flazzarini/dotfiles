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

# Helper functions
# -----------------------------------------------------------------------------
#
command_exists() {
    type "$1" &> /dev/null ;
}


# Environment Variables
# -----------------------------------------------------------------------------
#
export EDITOR="vim"
export VISUAL="vim"


# Keychain
# -----------------------------------------------------------------------------
#
if command_exists keychain ; then
    eval `keychain --eval --agents ssh id_rsa`
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

# Merged to journalctl
alias lmess='journalctl -f'


alias lapache='colortail -f /var/log/apache2/*.log'
alias lapacheerr='colortail -n 50 -f /var/log/apache2/error.log'
alias lauth='colortail -n 50 -f /var/log/auth.log'
alias ldaemon='colortail -n 50 -f /var/log/daemon.log'
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
alias chmox='chmod +x '
alias sc='systemctl'

# Archlinux Stuff
# -----------------------------------------------------------------------------
#

# Ubuntu Stuff
# -----------------------------------------------------------------------------
#
alias aupdate='sudo aptitude update'
alias aupgrade='sudo aptitude update && sudo aptitude upgrade'


# Exim Aliases (http://bradthemad.org/tech/notes/exim_cheatsheet.php)
# -----------------------------------------------------------------------------
#
alias eximqueue='sudo exim -bp'             # Show list of messages in queue
alias eximshow='sudo exim -Mvb'             # Show body of a message
alias eximlog='sudo exim -Mvl'              # Show log of a message
alias eximremove='sudo exim -Mrm'           # Removes a message from the queue
alias eximdeliver='sudo exim -M'            # Deliver a message wether its
                                            # frozen or not
alias eximremovefrozen='sudo exim -z -i | xargs exim -Mrm' # Removes all frozen
                                                           # messages


# Archlinux Stuff
# -----------------------------------------------------------------------------
#
#complete -cf sudo   # Autocompletion for sudo
#complete -cf man    # Autocompletion for man


# Python stuff
# -----------------------------------------------------------------------------
#
export PYTHONWARNINGS=ignore                         # Give no python warnings
export FLASKPORT=50020                               # My personal dev port
alias pyserve='python -m SimpleHTTPServer $1'        # server cwd via http
alias venv='virtualenv env && \
            ./env/bin/pip install ipython'           # prepare virtualenv
alias venv3='virtualenv -p /usr/bin/python3 env && \
             ./env/bin/pip install ipython'          # prepare virtualenv py3
alias inotebook='ipython notebook --notebook-dir ~/workspace/notebooks/'


# Perl stuff
# -----------------------------------------------------------------------------
#
alias perlshell='perl -d -e 1'


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
    PROMPT_COMMAND=prompt_command_function
else
    PS1="${GREEN}\u@${BLUE}\h${RESET}:${RESET}\w \$ "
fi
unset color_prompt force_color_prompt


# Other global environment variables
# -----------------------------------------------------------------------------
#
export CHROMIUM_USER_FLAGS="--memory-model=low --audio-buffer-size=4096 --enable-webgl"
export GOPATH="$HOME/src"
export ANSIBLE_CONFIG="~/workspace/ansible/ansible/ansible.cfg"


# Add local binaries to path
# -----------------------------------------------------------------------------
#

if [[ -d ~/bin ]]; then
    export PATH=~/bin:$PATH
fi
