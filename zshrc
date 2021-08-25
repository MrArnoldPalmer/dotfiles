# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#  _____    _
# |__  /___| |__  _ __ ___
#   / // __| '_ \| '__/ __|
#  / /_\__ \ | | | | | (__
# /____|___/_| |_|_|  \___|

# Aliases for a few useful commands
# alias mirrorUpdate="sudo reflector --latest 250 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
# alias yaourt="yaourt --pager --color"
# alias pacmanGhost="~/.pacman.sh"
# alias shivita="toilet -f mono12 -F rainbow 'andrea' | ponythink -f winona"
# alias emacs="emacs -nw"
# alias cat="bat"
# alias ls="colorls"
# alias ip="ip -c"
# alias rm="rm -i"
# alias x="ranger"
# alias c="cmus"
# alias h="htop"

export ZSH_CUSTOM="$HOME/.zsh"
export TERM="xterm-256color"

# Show OS info when opening a new terminal
# neofetch

# Font mode for powerlevel9k
# POWERLEVEL9K_MODE="nerdfont-complete"

# Prompt elements
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_user dir)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs aws)

# Set name of the theme to load.
# ZSH_THEME="powerlevel9k/powerlevel9k"
# source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme


# User with skull
# user_with_skull() {
#     echo -n " $(whoami)"
# }

# POWERLEVEL9K_CUSTOM_USER="user_with_skull"

# PowerLevel10K
source ~/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add ~/.bin to path
export PATH="$PATH:$HOME/.bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH=$HOME/.toolbox/bin:$PATH

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Java 8
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home"
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-8.jdk/Contents/Home

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
  eval "$(pyenv init -)"
fi

# Use neovim
alias vim="nvim"
alias vimdiff="nvim -d"
export EDITOR=nvim

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
