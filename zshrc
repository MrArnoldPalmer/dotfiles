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
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
source ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH=$HOME/.toolbox/bin:$PATH

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
if [[ ! -d $NVM_DIR ]]; then
  mkdir $NVM_DIR
fi
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# Java 8
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home"
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-8.jdk/Contents/Home
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

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

if [[ `uname` == "Darwin" ]]; then
  alias docker="finch"
fi

# CDK Aliases
# runs an npm script via lerna for a the current module
alias lr='lerna run --stream --scope $(node -p "require(\"./package.json\").name")'

# runs "yarn build" (build + test) for the current module
alias lb='lr build'
alias lt='lr test'

# build up/down
alias up='~/dev/aws-cdk/scripts/buildup'
alias down='~/dev/aws-cdk/scripts/builddown'

# runs "yarn watch" for the current module (recommended to run in a separate terminal session):
alias lw='lr watch'

alias run-superchain='docker run --rm --net=host -it -v $PWD:$PWD -w $PWD superchain'
alias cdk-local='~/dev/aws-cdk/packages/aws-cdk/bin/cdk'
alias jsii-local='~/dev/jsii/packages/jsii/bin/jsii'

fixZsh() {
	for f in $(compaudit)
	do 
		sudo chown -R $(whoami):root $f
		sudo chmod -R 755 $f
	done
}

eval "$(starship init zsh)"
