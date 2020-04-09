# Host specific environment variables for BBS-nexus.ipsw.dt.ept.lu
export DEVOPS_PATH="$HOME/devops"


# ANSIBLE variables
# -----------------------------------------------------------------------------
#
export ANSIBLE_HOME="$DEVOPS_PATH/ansible/ansible"
export ANSIBLE_CONFIG="$ANSIBLE_HOME/ansible.cfg"
export ANSIBLE_CONFIG_PATH="$DEVOPS_PATH/config"
export ANSIBLE_VAULT_PASSWORD_FILE="$ANSIBLE_CONFIG_PATH/vault_password"
export TOWER_TOKEN="$(cat $DEVOPS_PATH/ansible/config/awx_token)"
export TOWER_HOST="https://awx.dtt.ptech.lu"
