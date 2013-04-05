function find_git_branch() {
    local branch
    if branch=`git rev-parse --abbrev-ref HEAD 2> /dev/null`; then
        if [[ "$branch" == "HEAD" ]]; then
            branch="(detached head)"
        fi
        git_branch="($branch)"
    else
        git_branch=""
    fi
}
