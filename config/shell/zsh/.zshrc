autoload -U colors && colors

HISTSIZE=100000
SAVEHIST=100000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

autoload -U compaudit compinit
compinit

# Bash autocomplete compatibility
autoload -U +X bashcompinit
bashcompinit

for config_file ($ZDOTDIR/lib/*.zsh); do
  [ -f "$config_file" ] && source $config_file
done

# Basic tab/autocomplete
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)  # show hidden files and directories
zstyle ':completion:*' special-dirs false  # don't show '.' and '..'

setopt extendedglob

# Renaming
autoload -Uz zmv

######
# vi mode
bindkey -v

# Use nvim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in nvim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done

autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $m $c select-bracketed
    done
done

# Implementation of some functionality of the popular nvim surround plugin.
# Allows "surroundings" to be changes: parentheses, brackets and quotes.
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

bindkey '^n' end-of-line
bindkey '^p' beginning-of-line

bindkey '^[[3~' delete-char
bindkey '\033[1~' beginning-of-line
bindkey '\033[4~' end-of-line

export KEYTIMEOUT=1

export AUTOSWITCH_MESSAGE_FORMAT="$(tput setaf 2)Switching to %venv_name 🐍 %py_version $(tput sgr0)"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export AUTOSWITCH_VIRTUAL_ENV_DIR="venv"

# fzf
export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow -g '!.git' -g '!.wine' -g'!*[sS]team*' -g '!lutris' -g '!Trash' -g '!.cache' -g '!node_modules' -g '!__pycache__' -g '!*.o' -g '!.pytest_cache' -g '!obj/' -g '!venv/' 2>/dev/null"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--select-1 --exit-0"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_COMPLETION_OPTS='+c -x'

# Plugins
source /usr/share/zsh/share/antigen.zsh
# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle fzf
antigen bundle "zsh-users/zsh-autosuggestions"
antigen bundle "zsh-users/zsh-syntax-highlighting"
antigen bundle "MichaelAquilina/zsh-autoswitch-virtualenv"

antigen apply

eval "$(zoxide init zsh)"

# theme
source $ZDOTDIR/theme.zsh-theme

[ -f "$HOME/.aliases" ] && source "$HOME/.aliases" || true
[ -f "$HOME/.aliases_work" ] && source "$HOME/.aliases_work" || true

skim-git-branch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
        grep -v HEAD |
        sk --height 50% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
}
