
# Set the title for the window
function tabtitle {
    if [ -z "$1" ];
    then
        echo -ne "\033]0;"${PWD##*/}"\007"
    else
        echo -ne "\033]0;"$*"\007"
    fi
}

function co {
  BRANCHES="$(git branch | grep "$1")"
  BRANCHES=${BRANCHES//[[:blank:]]/}
  BRANCHES=${BRANCHES/\*/}

  SAVEIFS=$IFS
  IFS=$'\n'
  BRANCH_ARRAY=($BRANCHES)
  IFS=$SAVEIFS

  if [ ${#BRANCH_ARRAY[@]} -lt 1 ]; then
    echo "No branch containing '$1' found."
  elif [ ${#BRANCH_ARRAY[@]} -eq 1 ]; then
    git checkout "${BRANCH_ARRAY[0]}"
  else
    printf "There are more than one branches in the results: \n$BRANCHES\n"
  fi
}

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# User specific aliases and functions
## Git aliases
alias br='git br'
alias st='git st'
alias di='git di'
alias dic='git dic'
alias grp='git grp'
alias fc='git diff --name-only origin/master...'
alias rcc='git diff --name-only origin/master... | xargs bin/rubocop'
alias clbr='git branch --merged >/tmp/merged-branches && subl -w /tmp/merged-branches && xargs git branch -d </tmp/merged-branches'
## Rails
alias be='bundle exec'
alias ber='bundle exec rake'
alias spec='bin/rails test -v'
alias dbreset='bundle exec rake db:drop db:create db:migrate db:seed'
## Unix
alias ls='ls -G'
alias lsa='ls -lha'
alias be='bundle exec'
## Work
alias re='cd /Users/thudson/workspace/pulse360'
## Heroku
alias h='heroku'
alias hrc='heroku run rails c --size=performance-l --remote'
alias hrcs='heroku run rails c --sandbox --size=performance-l --remote'

# Pretify my terminal prompt
# Ruby version
#
function ruby_version {
  # echo -e "\033[1;31m🔻 \033[1;30m(\033[0;31m$(rbenv version-name)\033[1;30m)\033[m"
  echo -e "\033[1;31m🔻 \033[1;30m(\033[0;31m$(echo $RUBY_VERSION)\033[1;30m)\033[m"
}
# Python version
#
function python_version {
  echo -e "\033[1;33m🐍 \033[1;33m(\033[0;34m$(pyenv version-name)\033[1;33m)\033[m"
}
# Git branch and status
#
function git_branch {
  local branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/")
  if [ -n "$branch" ]; then echo -e "\033[1;33m($branch)\033[0;30m"; fi
}
function git_status {
  local symbol=""
  local status=$(git status 2> /dev/null)
  local staged_re='Changes to be committed'
  local unstaged_re='Changes not staged for commit'
  local untracked_re='Untracked files'
  local unmerged_re='Unmerged paths'
  if [[ $status =~ $staged_re    ]]; then symbol=$symbol"✏️ "; fi
  if [[ $status =~ $unstaged_re  ]]; then symbol=$symbol"🚽 "; fi
  if [[ $status =~ $untracked_re ]]; then symbol=$symbol"🌱  "; fi
  if [[ $status =~ $unmerged_re ]]; then symbol=$symbol"💀 💀 💀"; fi
  echo -e "$symbol"
}
# LifeMeter: Hearts that break over time
#
function lifemeter {
  local hour=$(date +%H)
  if [ $hour -lt 6 ] || [ $hour -ge 24 ]; then
    local hearts="\033[5m♡ ♡ ♡ ♡ ♡ "
  elif [ $hour -lt 12 ]; then
    local hearts="💙 💙 💙 💙 💙 "
  elif [ $hour -lt 15 ]; then
    local hearts="💙 💙 💙 💙 ♡ "
  elif [ $hour -lt 18 ]; then
    local hearts="💙 💙 💙 ♡ ♡ "
  elif [ $hour -lt 21 ]; then
    local hearts="💙 💙 ♡ ♡ ♡ "
  elif [ $hour -lt 24 ]; then
    local hearts="💙 ♡ ♡ ♡ ♡ "
  else
    echo "Invalid Argument!" >&2
    exit 1
  fi
  echo -e "\033[31m$hearts\033[m"
}
# Prompt
#
PS1='\n👾 '
PS1=$PS1' \[\033[01;32m\]\u\[\033[m\]'   # username
PS1=$PS1' $(lifemeter)'
# PS1=$PS1' $(ruby_version)'
# PS1=$PS1' $(python_version)'
PS1=$PS1' $(git_branch)$(git_status)' # git branch and status
PS1=$PS1'\n\[\033[01;34m\]\w\[\033[m\]' # directory
PS1=$PS1' \[\033[1;35m\]»\[\033[m\] ' # prompt

export PS1

# Add history searching to up and down arrows
#
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Branch auto-completion
#
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Flek autocompletion
#
# source completion/_flek.bash

# Other
#
export PATH="/usr/local/opt/icu4c/bin:$PATH"

export PATH="$HOME/bin:$PATH"

export NVM_DIR="$HOME/.nvm"

export DISABLE_SPRING=true

export DEV_CACHE_ENABLED=false

export EDITOR='subl'

source $(brew --prefix nvm)/nvm.sh

