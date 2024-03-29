# bashrc
#
# Author: Frank Lazzarini

# Standard
# -----------------------------------------------------------------------------
#
[ -z "$PS1" ] && return


# Bash history settings
# -----------------------------------------------------------------------------
#
export HISTCONTROL=ignoredups:ignorespace:erasedups    # don't put duplicated to history
export HISTSIZE=10000                                  # History size length
export HISTFILESIZE=20000                              # Hitstory filesize
shopt -s histappend                                    # append to hist after each cmd
shopt -s checkwinsize                                  # Check window size after each
                                                       # command update LINES COLUMNS


# Bash Completion
# -----------------------------------------------------------------------------
#
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  source /etc/bash_completion
fi


# Global Environment Variables
# -----------------------------------------------------------------------------
#
EDITOR_CMD=vim
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=$EDITOR_CMD
export VISUAL=$EDITOR_CMD
export DOTFILES=$HOME/dotfiles
export GOPATH="$HOME/src"
export GTI_SPEED=5000
export DEVELOPMENT_PORTS="50020,50025"


# Launchpad.net Env vars
# -----------------------------------------------------------------------------
#
export DEBFULLNAME="Frank Lazzarini"
export DEBEMAIL="flazzarini@gmail.com"
export GPGKEY=C502163F

# Python Env vars
# -----------------------------------------------------------------------------
#
export PYTHONWARNINGS=default                         # Give python warnings



# Keychain
# -----------------------------------------------------------------------------
#
if [ -f "$HOME/.ssh/id_rsa" ]; then
  eval $(keychain --eval id_rsa)
fi


# Customizations
# -----------------------------------------------------------------------------
#
[ -x /usr/bin/lesspipe ] && \
  eval "$(SHELL=/bin/sh lesspipe)"  # makes less suck less


# Expand PATH variables with custom folders
# -----------------------------------------------------------------------------
#
FOLDERS="
  $HOME/bin
  $HOME/opt/nodeenc/node_modules/.bin
  $HOME/node_modules/.bin
  $HOME/.local/bin
  $HOME/.cargo/bin
"
for FOLDER in $FOLDERS; do
  [ -d "$FOLDER" ] && PATH="$FOLDER:$PATH"
done


# Source extra bash files
# -----------------------------------------------------------------------------
#
# Add custom bash functions
# Ticket opened https://github.com/koalaman/shellcheck/issues/769
# shellcheck disable=SC1090
[ -f "$DOTFILES/bash_functions" ] && source "$DOTFILES/bash_functions"

# Adds custom bash_aliases
# shellcheck disable=SC1090
[ -f "$DOTFILES/bash_aliases" ] && source "$DOTFILES/bash_aliases"

# Adds Host specific configurations
# shellcheck disable=SC1090
[ -f "$DOTFILES/host_specific.d/$HOSTNAME.sh" ] && source "$DOTFILES/host_specific.d/$HOSTNAME.sh"

# Adds fzf key bindings
# shellcheck disable=SC1090
[ -f "$DOTFILES/fzf/shell/key-bindings.bash" ] && source "$DOTFILES/fzf/shell/key-bindings.bash"



# My Prompt
# -----------------------------------------------------------------------------
#
# Remap TERM environment variable
case "$TERM" in
  xterm*|rxvt-unicode*) TERM="xterm-256color" ;;
  alacritty) TERM="xterm-256color" ;;
esac

# If we have a colorful terminal set color_prompt to yes
case "$TERM" in
  xterm-256color) color_prompt=yes ;;
  tmux-256color) color_prompt=yes ;;
  screen-256color) color_prompt=yes ;;
  rxvt-unicode-256color) color_prompt=yes ;;
  alacritty) color_prompt=yes ;;
esac

if [ "$color_prompt" = yes ]; then
  # Set prompt
  PROMPT_COMMAND=prompt_command_function

  # Set color theme
  # COLOR_THEME=molokai

  # Ticket opened https://github.com/koalaman/shellcheck/issues/769
  # shellcheck disable=SC1090
  # source ~/dotfiles/terminal-color-theme/color-theme-${COLOR_THEME}/${COLOR_THEME}.sh
else

  # shellcheck disable=SC2153
  PS1="${GREEN}\u@${BLUE}\h${RESET}:${RESET}\w \$ "
fi

# Load direnv if available on the system
# direnv reads `.envrc` files from directories and sets environment variables
# based on these files
if [ -f /usr/bin/direnv ]; then
  eval "$(/usr/bin/direnv hook bash)"
fi

unset color_prompt force_color_prompt


# Load pyenv stuff
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Citrix Receiver
export ICAROOT="/opt/icaclient/linuxx64"

# Use ASDF
test -f "$HOME/.asdf/asdf.sh" && source $HOME/.asdf/asdf.sh

# Enable Fabric Bash Completion
source "$HOME/dotfiles/fabric-completion.bash"
