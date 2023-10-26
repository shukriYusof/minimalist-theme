# Author        : shukriyusof
# Email         : shuk.yusof@gmail.com
# Description   : Simple theme by shukri yusof.

PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
RPROMPT='%{$fg[cyan]%}%c%{$reset_color%} $(git_time_since_commit) $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"

function get_host {
  echo '@'$HOST
}

# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function git_time_since_commit() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Check if there is actually a commit
        if last_commit=$(git -c log.showSignature=false log --pretty=format:'%at' -1 2> /dev/null); then
            now=$(date +%s)
            seconds_since_last_commit=$((now - last_commit))

            # Calculate time in minutes and hours
            minutes=$((seconds_since_last_commit / 60))
            hours=$((seconds_since_last_commit / 3600))

            # Calculate days, sub-hours, and sub-minutes
            days=$((seconds_since_last_commit / 86400))
            sub_hours=$((hours % 24))
            sub_minutes=$((minutes % 60))

            if [[ -n $(git status -s 2> /dev/null) ]]; then
                if [ "$minutes" -gt 30 ]; then
                    color="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
                elif [ "$minutes" -gt 10 ]; then
                    color="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
                else
                    color="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
                fi
            else
                color="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            fi

            if [ "$hours" -gt 24 ]; then
                echo "$color${days}d${sub_hours}h${sub_minutes}m%{$reset_color%}"
            elif [ "$minutes" -gt 60 ]; then
                echo "$color${hours}h${sub_minutes}m%{$reset_color%}"
            else
                echo "$color${minutes}m%{$reset_color%}"
            fi
        else
            color="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            echo "$color"
        fi
    fi
}
