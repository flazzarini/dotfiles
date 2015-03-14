#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Keychain
eval `keychain --eval --agents ssh id_rsa`
