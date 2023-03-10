# Allow the checkout of branches using shorter identifiers
# Branch must have been checked out locally before
# e.g. branch named INT-123-a-branch
#
#   (master)$ co 123
#   (INT-123-a-branch)$
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

# Branch auto-completion
[ -f ~/.git-completion.bash ] && source ~/.git-completion.bash
