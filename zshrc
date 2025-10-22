# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/.local/share/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/.local/share/amazon-q/shell/zshrc.pre.zsh"
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

# Increase available heap memory to NodeJS
export NODE_OPTIONS=--max-old-space-size=8192

# Java
export JAVA_HOME="$HOMEBREW_PREFIX/Cellar/openjdk@17/17.0.15"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-21.jdk/Contents/Home"
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home
# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

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

# SSH port forwarding function
sshfwd() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: sshfwd <port1[,port2,...]> <hostname> [remote_port1[,remote_port2,...]]"
        echo "Example: sshfwd 8000 myserver"
        echo "Example: sshfwd 8000 myserver 3000"
        echo "Example: sshfwd 8000,8001,8002 myserver"
        echo "Example: sshfwd 8000,8001 myserver 3000,3001"
        return 1
    fi
    
    local ports=$1
    local hostname=$2
    local remote_ports=${3:-$1}
    
    # Split ports and remote_ports by comma
    local -a host_port_array=(${(s/,/)ports})
    local -a remote_port_array=(${(s/,/)remote_ports})
    
    # Build SSH command with multiple -L flags
    local ssh_cmd="ssh"
    local i=1
    
    for host_port in "${host_port_array[@]}"; do
        local remote_port=${remote_port_array[$i]:-$host_port}
        echo "Forwarding localhost:${host_port} -> ${hostname}:${remote_port}"
        ssh_cmd="${ssh_cmd} -L ${host_port}:127.0.0.1:${remote_port}"
        ((i++))
    done
    
    ssh_cmd="${ssh_cmd} ${hostname}"
    echo "Running: ${ssh_cmd}"
    eval $ssh_cmd
}

# Autocomplete function for sshfwd
_sshfwd() {
    local context state line
    
    _arguments \
        '1:port number:' \
        '2:hostname:_ssh_hosts' \
        '3:remote port number:'
}

# Register the completion function
compdef _sshfwd sshfwd

## zj autocomplete
. <( zellij setup --generate-completion zsh | sed -E "
/^autoload -U is-at-least/a\\
\\
_zellij_sessions() {\\
    local line sessions desc; sessions=(\"\${(@f)\$(zellij ls -n)}\")\\
    local -a session_names_with_desc\\
    for line in \"\${sessions[@]}\"; do\\
        session_name=\${line%% *}\\
        desc=\${line#* }\\
        session_names_with_desc+=(\"\$session_name:\$desc\")\\
    done\\
    _describe -t sessions 'active session' session_names_with_desc\\
}
s/^(attach)/\1|a/
s/::session-name -- Name of the session to attach to:/::session-name:_zellij_sessions/
s/^(kill-session)/\1|k/
s/::target-session -- Name of target session:/::target-session:_zellij_sessions/
s/^(delete-session)/\1|d/
s/^(_(zellij) ).*/compdef \1\2/
")

eval "$(starship init zsh)"

if [[ $(uname) == "Darwin" ]]; then
  export CDK_DOCKER="finch"
  alias docker="finch"
fi

if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

# Claude code Amazon Bedrock
export ANTHROPIC_MODEL='us.anthropic.claude-3-7-sonnet-20250219-v1:0'
export ANTHROPIC_SMALL_FAST_MODEL='us.anthropic.claude-3-5-haiku-20241022-v1:0'
export CLAUDE_CODE_USE_BEDROCK=1

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/.local/share/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/.local/share/amazon-q/shell/zshrc.post.zsh"

export MISE_SHELL=zsh
export __MISE_ORIG_PATH="$PATH"

mise() {
  local command
  command="${1:-}"
  if [ "$#" = 0 ]; then
    command mise
    return
  fi
  shift

  case "$command" in
  deactivate|shell|sh)
    # if argv doesn't contains -h,--help
    if [[ ! " $@ " =~ " --help " ]] && [[ ! " $@ " =~ " -h " ]]; then
      eval "$(command mise "$command" "$@")"
      return $?
    fi
    ;;
  esac
  command mise "$command" "$@"
}

_mise_hook() {
  eval "$(mise hook-env -s zsh)";
}
typeset -ag precmd_functions;
if [[ -z "${precmd_functions[(r)_mise_hook]+1}" ]]; then
  precmd_functions=( _mise_hook ${precmd_functions[@]} )
fi
typeset -ag chpwd_functions;
if [[ -z "${chpwd_functions[(r)_mise_hook]+1}" ]]; then
  chpwd_functions=( _mise_hook ${chpwd_functions[@]} )
fi

_mise_hook
if [ -z "${_mise_cmd_not_found:-}" ]; then
    _mise_cmd_not_found=1
    [ -n "$(declare -f command_not_found_handler)" ] && eval "${$(declare -f command_not_found_handler)/command_not_found_handler/_command_not_found_handler}"

    function command_not_found_handler() {
        if [[ "$1" != "mise" && "$1" != "mise-"* ]] && mise hook-not-found -s zsh -- "$1"; then
          _mise_hook
          "$@"
        elif [ -n "$(declare -f _command_not_found_handler)" ]; then
            _command_not_found_handler "$@"
        else
            echo "zsh: command not found: $1" >&2
            return 127
        fi
    }
fi

export PATH=$HOME/.toolbox/bin:$PATH
export NODE_PATH="$(dirname `mise exec node -- which node`)"
export PATH=$NODE_PATH:$PATH
