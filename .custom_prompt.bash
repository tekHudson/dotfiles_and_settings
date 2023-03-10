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
PS1=$PS1" ${GREEN}TekHudson ${NC}"
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
