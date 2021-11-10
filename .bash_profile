export PATH="$HOME/bin:$PATH"

#
# Required for OpenSSL to work
#
export PATH="/usr/local/opt/openssl@1.0/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.0/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.0/include"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl@1.0/lib/
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

export DISABLE_SPRING=true

export EDITOR='subl'

eval "$(rbenv init -)"
#
# Set the title for the window
#
export PROMPT_COMMAND='echo -ne "\033]0;"$(project_name)"\007"'
#
# Add history searching to up and down arrows
#
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
#
# Branch auto-completion
#
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
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
alias clbr='git branch --merged >/tmp/merged-branches && subl -w /tmp/merged-branches && xargs git branch -d </tmp/merged-branches'
## Rails
alias td='tail -f log/development.log'
alias be='bundle exec'
alias ber='bundle exec rake'
alias spec='bin/rails test -v'
alias dbreset='bundle exec rake db:drop db:create db:migrate db:seed'
## Unix
alias ls='ls -G'
alias lsa='ls -lha'
alias psg='ps -ax | grep -v grep | grep -i'
## Work
alias cspec='USE_CACHED_DATA=1 bundle exec rspec --color'
alias nginx_conf='subl /usr/local/etc/nginx/nginx.conf'
#
# Allow the checkout of branches using shorter identifiers
# Branch must have been checked out locally before
# e.g.
# branch named INT-123-a-branch,
# (master)$ co 123
# (INT-123-a-branch)$
#
function co {
  if [ "$1" = "-" ]; then
    git checkout -
  else
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
  fi
}
#
# Ruby version
#
function ruby_version {
  echo $(rbenv version-name)
}
#
# Python version
#
function python_version {
  echo $(pyenv version-name)
}
#
# Git branch and status
#
function git_branch {
  local branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/")
  if [ -n "$branch" ]; then echo $branch; fi
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
  if [[ $status =~ $untracked_re ]]; then symbol=$symbol"❓  "; fi
  if [[ $status =~ $unmerged_re ]]; then symbol=$symbol"💀 💀 💀"; fi
  echo -e "$symbol"
}
#
# LifeMeter: Hearts that break over time
#
function lifemeter {
  local hour=$(date +%H)
  if [ $hour -lt 6 ] || [ $hour -ge 24 ]; then
    local hearts="\033[5m♡ ♡ ♡ ♡ ♡ "
  elif [ $hour -lt 12 ]; then
    local hearts="💙💙💙💙💙"
  elif [ $hour -lt 15 ]; then
    local hearts="♡ 💙💙💙💙 "
  elif [ $hour -lt 18 ]; then
    local hearts="♡ ♡ 💙💙💙 "
  elif [ $hour -lt 21 ]; then
    local hearts="♡ ♡ ♡ 💙💙 "
  elif [ $hour -lt 24 ]; then
    local hearts="♡ ♡ ♡ ♡ 💙 "
  else
    echo "Invalid Argument!" >&2
    exit 1
  fi
  echo -e "$hearts"
}
#
# Project Name: Obtains the project name for use in terminal
#
function project_name {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    local name=$(basename `git rev-parse --show-toplevel`);
    name="$(tr '[:lower:]' '[:upper:]' <<< ${name:0:1})${name:1}"
    echo "$name";
  else
    echo ""
  fi
}
#
# Prompt
#
DARK_RED='\[\033[00;31m\]'
RED='\[\033[01;31m\]'
DARK_GREEN='\[\033[00;32m\]'
GREEN='\[\033[01;32m\]'
YELLOW='\[\033[01;33m\]'
BLUE='\[\033[01;34m\]'
PINK='\[\033[0;35m\]'
NC='\[\033[0m\]' # No Color

PS1="\n👾"
PS1=$PS1" ${GREEN}\u${NC}"
PS1=$PS1"${PINK}@${NC}"
PS1=$PS1"${GREEN}\$(project_name)${NC}"
PS1=$PS1" ${RED}\$(lifemeter)${NC}"
PS1=$PS1" 🔻(${DARK_RED}\$(ruby_version)${NC})"
# PS1=$PS1" 🐍(${DARK_GREEN}\$(python_version)${NC})"
PS1=$PS1" (${YELLOW}\$(git_branch)${NC})"
PS1=$PS1" \$(git_status)"
PS1=$PS1"\n" # NEW LINE
PS1=$PS1"${BLUE}\w${NC}"
PS1=$PS1" ${PINK}»${NC} "

export PS1
