export PATH="$HOME/bin:$PATH"

# NVM stuffs
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

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

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Set the title for the window
export PROMPT_COMMAND='echo -ne "\033]0;"$(project_name)"\007"'

# Add history searching to up and down arrows
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Include Aliases
[ -f ~/.alias.bash ] && source ~/.alias.bash

# Include Git Helpers
[ -f ~/.git_helpers.bash ] && source ~/.git_helpers.bash

# Include AWS CLI Helpers
[ -f ~/.aws_cli_helpers.bash ] && source ~/.aws_cli_helpers.bash

# Custom prompt
[ -f ~/.custom_prompt.bash ] && source ~/.custom_prompt.bash
