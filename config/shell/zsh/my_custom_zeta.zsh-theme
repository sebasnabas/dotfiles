#!/bin/zsh
# {% raw %}
# vim: syntax=bash
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

# Colors: black|red|blue|green|yellow|magenta|cyan|white
local black=$fg[black]
local red=$fg[red]
local blue=$fg[blue]
local green=$fg[green]
local yellow=$fg[yellow]
local magenta=$fg[magenta]
local cyan=$fg[cyan]
local white=$fg[white]

local black_bold=$fg_bold[black]
local red_bold=$fg_bold[red]
local blue_bold=$fg_bold[blue]
local green_bold=$fg_bold[green]
local yellow_bold=$fg_bold[yellow]
local magenta_bold=$fg_bold[magenta]
local cyan_bold=$fg_bold[cyan]
local white_bold=$fg_bold[white]

local highlight_bg=$bg[red]

local zeta='→'

# Machine name.
function get_box_name {
    if [ -f ~/.box-name ]; then
        cat ~/.box-name
    else
        echo $HOST
    fi
}

# User name.
function get_usr_name {
    local name="%n"
    if [[ "$(whoami)" == 'root' ]]; then
        name="%{$red_bold%}$name%{$reset_color%}"
    else
        name="%{$green_bold%}$name"
    fi
    echo $name
}

# Directory info.
function get_current_dir {
    basename "${PWD/#$HOME/~}"
}

# Git info.
ZSH_THEME_GIT_PROMPT_PREFIX="%{$blue_bold%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$green_bold%} ✔ "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$red_bold%} ✘ "

# Git status.
ZSH_THEME_GIT_PROMPT_ADDED="%{$green_bold%}+"
ZSH_THEME_GIT_PROMPT_DELETED="%{$red_bold%}-"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$magenta_bold%}*"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$blue_bold%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$cyan_bold%}="
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$yellow_bold%}?"

# Git sha.
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="[%{$yellow%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}]"

function get_git_prompt {
    if [[ -n $(git rev-parse --is-inside-work-tree 2>/dev/null) ]]; then
        local git_status="$(git_prompt_status)"
        if [[ -n $git_status ]]; then
            git_status="[$git_status%{$reset_color%}]"
        fi
        local git_prompt=" %{$cyan%} $(git_prompt_info)$git_status"
        echo $git_prompt
    fi
}

function get_time_stamp {
    echo "%*"
}

function get_space {
    local str=$1$2
    local zero='%([BSUbfksu]|([FB]|){*})'
    local len=${#${(S%%)str//$~zero/}}
    local size=$(( $COLUMNS - $len - 1 ))
    local space=""
    while [[ $size -gt 0 ]]; do
        space="$space "
        let size=$size-1
    done
    echo $space
}

function get_virtualenv {
    local virtualenv_path=""
    if [ -n "$VIRTUAL_ENV" ]; then
        virtualenv_path="(`basename \"$VIRTUAL_ENV\"`) "
    fi

    echo $virtualenv_path
}

function get_ssh_prompt {
    if [[ -n "$SSH_CONNECTION" ]]; then
        echo "%{$yellow_bold%}@%{$red_bold%}[%{$cyan_bold%}$(get_box_name)%{$red_bold%}]"
    fi
}

# Prompt: VIRTUAL_ENV USER@MACHINE: DIRECTORY <BRANCH [STATUS]> --- (TIME_STAMP)
# > command
function print_prompt_head {
    local left_prompt="\
%{$cyan_bold%}$(get_virtualenv)\
%{$green_bold%}$(get_usr_name)\
%{$cyan_bold%}@\
%{$blue_bold%}$(get_box_name): \
%{$yellow%}$(get_current_dir)%{$reset_color%}\
$(get_git_prompt) "

    local right_prompt="%{$blue%}($(get_time_stamp))%{$reset_color%} "

    local short_left_prompt="%{$cyan_bold%}$(get_virtualenv)$(get_usr_name)$(get_ssh_prompt)%{$blue%}: %{$cyan%}$(get_current_dir)%{$reset_color%}$(get_git_prompt) "

    print -rP "$short_left_prompt$(get_space $short_left_prompt $right_prompt)$right_prompt"
}

function get_prompt_indicator {
    if [[ $? -eq 0 ]]; then
        echo "%{$cyan%}$zeta %{$reset_color%}"
    else
        echo "%{$red%}$zeta %{$reset_color%}"
    fi
}

autoload -U add-zsh-hook
add-zsh-hook precmd print_prompt_head
setopt prompt_subst

PROMPT='$(get_prompt_indicator)'
RPROMPT='$(git_prompt_short_sha) '

# {% endraw %}
