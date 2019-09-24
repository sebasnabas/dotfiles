export ZSH="/home/sebastian/.oh-my-zsh"

ZSH_THEME="my_custom_zeta"

plugins=(git virtualenv autoswitch_virtualenv zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

export AUTOSWITCH_MESSAGE_FORMAT="$(tput setaf 2)Switching to %venv_name 🐍 %py_version $(tput sgr0)"

setopt histignorespace

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

alias mkvenv="mkvenv --system-site-packages"

source ~/.aliases
