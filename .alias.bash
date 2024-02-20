#
# User specific aliases and functions
#

## Git aliases
alias br='git br'
alias st='git st'
alias di='git di'
alias pu='git pu'
alias dic='git dic'
alias grp='git grp'
alias fc='git diff --name-only origin/master...'
alias rcc='git diff --name-only origin/master... | xargs bin/rubocop'
alias clbr='git branch >/tmp/merged-branches && subl -w /tmp/merged-branches && xargs git branch -d </tmp/merged-branches'

## Front End
alias febuild='yarn && yarn build && npm i && npm start'

## Rails
alias td='tail -f log/development.log'
alias be='bundle exec'
alias ber='bundle exec rake'
alias spec='bin/rails test -v'
alias rtdb='RAILS_ENV=test rails db:drop db:create db:migrate'
alias dbreset='bundle exec rake db:drop db:create db:migrate db:seed'

# Kubectl
alias k='kubectl'
alias kdp='kubectl describe pod'

## Unix
alias ls='ls -G'
alias lsa='ls -lha'
alias psg='ps -ax | grep -v grep | grep -i'

## Work
alias cspec='USE_CACHED_DATA=1 bundle exec rspec --color'
alias nginx_conf='subl /usr/local/etc/nginx/nginx.conf'
