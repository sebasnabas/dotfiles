autoload -U colors && colors

HISTSIZE=10000
SAVEHIST=10000

setopt histignorespace

autoload -U compaudit compinit
compinit

for config_file ($ZDOTDIR/lib/*.zsh); do
  [ -f "$config_file" ] && source $config_file
done

# Basic tab/autocomplete
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)
zstyle ':completion:*' special-dirs false

setopt extendedglob

######
# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
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

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

bindkey '^n' end-of-line
bindkey '^p' beginning-of-line

 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi
######

export AUTOSWITCH_MESSAGE_FORMAT="$(tput setaf 2)Switching to %venv_name 🐍 %py_version $(tput sgr0)"

export VIRTUAL_ENV_DISABLE_PROMPT=1

alias mkvenv="mkvenv --system-site-packages"

# Completion for kitty
which kitty > /dev/null 2>&1 && kitty + complete setup zsh | source /dev/stdin

[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

plugins=(git fzf autoswitch_virtualenv zsh-syntax-highlighting zsh-autosuggestions)

for plugin ($plugins); do
    plugin_path="$ZDOTDIR/plugins/$plugin/$plugin.plugin.zsh"
    [ -f $plugin_path ] && source $plugin_path
done

# fzf
export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow -g '!.git' -g '!.wine' -g'!*[sS]team*' -g '!lutris' -g '!Trash' -g '!.cache' 2>/dev/null . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--select-1 --exit-0"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# thefuck
python="python"
python_version="$(${python} --version 2>&1 | cut -d' ' -f2 | grep '^2\.')"
if [ -n "$python_version" ]; then
    python="python3"
fi
${python} -m pip freeze 2>&1 | grep thefuck > /dev/null || (${python} -m pip install --user thefuck > /dev/null 2>&1 && echo "Installed thefuck.")
eval $(thefuck --alias)

# mkdir and change to it
mdc()  {
    mkdir -p $1 && cd $_
}

source $ZDOTDIR/theme.zsh-theme

