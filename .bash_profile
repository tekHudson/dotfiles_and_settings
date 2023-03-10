export PATH="$HOME/bin:$PATH"
export NVM_DIR="$HOME/.nvm"

[ -s "/usr/local/opt/nvm/nvm.sh" ] && source "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && source "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Required to fix AWS cli cert discovery
export AWS_CA_BUNDLE='/etc/ssl/cert.pem'

# Required for OpenSSL to work
export PATH="/usr/local/opt/openssl@1.0/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.0/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.0/include"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl@1.0/lib/
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export DISABLE_SPRING=true
export EDITOR='subl'
export KUBE_EDITOR="/usr/local/bin/subl -w"

eval "$(rbenv init - bash)"


# Set the title for the window
export PROMPT_COMMAND='echo -ne "\033]0;"$(project_name)"\007"'

# Add history searching to up and down arrows
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

pgUpdateFromStaging() {
  REMOTE_DB_USER=${REMOTE_DB_USER:-'team_payments'}
  REMOTE_DB_PASS=${REMOTE_DB_PASS:-'F0p4GOsYdV04gOk0lHXI'}
  REMOTE_DB_HOST=${REMOTE_DB_HOST:-'cluster-db.internal.uniteusdev.com'}
  REMOTE_DB_NAME=${REMOTE_DB_NAME:-'uniteus_provider_core'}
  LOCAL_DB_USER=${LOCAL_DB_USER:-''}
  LOCAL_DB_PASS=${LOCAL_DB_PASS:-''}
  LOCAL_DB_HOST=${LOCAL_DB_HOST:-'localhost'}
  LOCAL_DB_NAME=${LOCAL_DB_NAME:-'core'}

  PGHOST=$REMOTE_DB_HOST
  PGUSER=$REMOTE_DB_USER
  PGPASSWORD=$REMOTE_DB_PASS
  PGDATABASE=$REMOTE_DB_NAME
  pg_dump -U {PGUSER} -W -F t {PGDATABASE} -h {PGHOST} > dump.tar

  PGDATABASE=$LOCAL_DB_NAME
  createdb -h localhost {PGDATABASE}
  pg_restore -h localhost --dbname='core' dump.tar
}

# Include Aliases
[ -f ~/.alias.bash ] && source ~/.alias.bash

# Include Git Helpers
[ -f ~/.git_helpers.bash ] && source ~/.git_helpers.bash

# Include AWS CLI Helpers
[ -f ~/.aws_cli_helpers.bash ] && source ~/.aws_cli_helpers.bash

# Custom prompt
[ -f ~/.custom_prompt.bash ] && source ~/.custom_prompt.bash
