autoload -U compinit
compinit

export ZSH_CUSTOM="$HOME/.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add ~/.bin to path
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.local/bin"

if [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
else
  export HOMEBREW_PREFIX="/opt/homebrew"
fi
export PATH="$HOMEBREW_PREFIX/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/sbin:$PATH"

# ZSH Syntax Highlighting
source ~/.zsh/catppuccin_latte-zsh-syntax-highlighting.zsh
source ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH=$HOME/.toolbox/bin:$PATH

# Add llvm stuff to path, notably lld
export PATH="$PATH:$HOMEBREW_PREFIX/opt/llvm/bin"

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
if [[ ! -d $NVM_DIR ]]; then
  mkdir $NVM_DIR
fi
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
# Increase available heap memory to NodeJS
export NODE_OPTIONS=--max-old-space-size=8192

# Java
# export JAVA_HOME="$HOMEBREW_PREFIX/Cellar/openjdk/20.0.1/"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-21.jdk/Contents/Home"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home
# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Python
# alias python=/usr/local/bin/python3
# alias pip=/usr/local/bin/python3
# PyEnv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Use neovim
alias vim="nvim"
alias vimdiff="nvim -d"
export EDITOR=nvim

alias zj="zellij"
alias cat="bat"

export BAT_THEME=Catppuccin-latte

eval "$(starship init zsh)"

if [[ $(uname) == "Darwin" ]]; then
  export CDK_DOCKER="finch"
  alias docker="finch"
fi

if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi
