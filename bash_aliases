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


# Archlinux Stuff
# -----------------------------------------------------------------------------
#
#complete -cf sudo   # Autocompletion for sudo
#complete -cf man    # Autocompletion for man


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


# Python Stuff
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


# ANSIBLE stuff
# -----------------------------------------------------------------------------
#
export ANSIBLE_HOME="$HOME/workspace/ansible"
export ANSIBLE_CONFIG="$ANSIBLE_HOME/ansible.cfg"
export ANSIBLE_VAULT_PASSWORD_FILE="$HOME/workspace/ansible/vault_password"

alias ansi='cd $ANSIBLE_HOME'
alias vault='$ANSIBLE_HOME/env/bin/ansible-vault'
alias play='$ANSIBLE_HOME/env/bin/ansible-playbook'
alias mkansiblerole='mkdir -p {tasks,handlers,files,defaults}'


# Perl stuff
# -----------------------------------------------------------------------------
#
alias perlshell='perl -d -e 1'


# vim: filetype=sh
