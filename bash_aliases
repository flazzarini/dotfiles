# enable color support of ls and also add handy aliases

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# Logging aliases
# -----------------------------------------------------------------------------
#
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
alias lpgstat='sudo -u postgres psql -c "select * from pg_stat_activity;"'


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
alias pong='ping 8.8.8.8'
alias dmesg="dmesg --color=auto --reltime --human --nopager --decode"
alias tree="tree --dirsfirst -C"
alias cat="bat -p"
alias versiondate="date '+%Y.%m.%d.01'"


# Archlinux Stuff
# -----------------------------------------------------------------------------
#
complete -cf sudo   # Autocompletion for sudo
complete -cf man    # Autocompletion for man


# Ubuntu Stuff
# -----------------------------------------------------------------------------
#
alias aupdate='sudo aptitude update'
alias aupgrade='sudo aptitude update && sudo aptitude upgrade'
alias aptpkgsizes='dpkg-query -Wf "${Installed-Size}\t${Package}\n" | sort -n'


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


# Openssl aliases
# -----------------------------------------------------------------------------
#
alias osslenddate='openssl x509 -enddate -noout -in '   # Get expiration date


# Python Stuff
# -----------------------------------------------------------------------------
#
alias pyserve='python3 -m ComplexHTTPServer'         # Needs ComplexHTTPServer
alias venv='virtualenv env &&
            ./env/bin/pip install -U pip wheel'           # prepare virtualenv
alias venv3='python3 -m venv env &&
             ./env/bin/pip install -U pip wheel'          # prepare virtualenv py3
alias inotebook='ipython notebook --notebook-dir ~/workspace/notebooks/'
alias jsonpp="python3 -mjson.tool"


# ANSIBLE stuff
# -----------------------------------------------------------------------------
#
alias ansi='cd $ANSIBLE_HOME'
alias vault='$ANSIBLE_HOME/env/bin/ansible-vault'
alias play='$ANSIBLE_HOME/env/bin/ansible-playbook'
alias mkansiblerole='mkdir -p {tasks,handlers,files,defaults}'
alias freerad_rules='cd $ANSIBLE_HOME/playbooks/server_setup/freeradius/files/freerad/auth_rules'
alias freerad_profiles='cd $ANSIBLE_HOME/playbooks/server_setup/freeradius/files/freerad/auth_profiles'


# Dotfiles stuff
# -----------------------------------------------------------------------------
#
alias dotfiles='cd ~/dotfiles'



# Perl stuff
# -----------------------------------------------------------------------------
#
alias perlshell='perl -d -e 1'


# Docker aliases
# -----------------------------------------------------------------------------
#
alias dis="docker images --format '{{.Size}}\t{{.Repository}}\t{{.Tag}}\t{{.ID}}' | column -t | sort -hs"


# Radius related aliases
# -----------------------------------------------------------------------------
#
alias sniffrad="radsniff -x -szopp -S"


# Git related aliases
# -----------------------------------------------------------------------------
#
alias pushall="git co master && git push && git push --tags && git co develop && git push"


# Neovim Alias
# -----------------------------------------------------------------------------
#
alias vim="nvim"
alias vi="nvim"


# vim: filetype=sh
