# Nushell Environment Config File

def create_left_prompt [] {
    let path_segment = if (is-admin) {
        $"(ansi red_bold)($env.PWD)"
    } else {
        $"(ansi green_bold)($env.PWD)"
    }

    $path_segment
}

def create_right_prompt [] {
    let time_segment = ([
        (date now | date format '%m/%d/%Y %r')
    ] | str collect)

    $time_segment
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = { "〉" }
let-env PROMPT_INDICATOR_VI_INSERT = { ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = { "〉" }
let-env PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str collect (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str collect (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# Set Neovim as EDITOR
let-env EDITOR = 'nvim'

# Misc vars
let-env GOPATH = $'($env.HOME)/go'
let-env PYENV_ROOT = $'($env.HOME)/.pyenv'
let-env JAVA_HOME = '/usr/local/opt/openjdk@11/'


# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# Brew setup
let-env PATH = ($env.PATH | prepend '/usr/local/bin')
let-env PATH = ($env.PATH | prepend '/home/linuxbrew/.linuxbrew/bin')
# Local bin to path
let-env PATH = ($env.PATH | append $'($env.HOME)/.bin')
# Go
let-env PATH = ($env.PATH | append $'($env.GOPATH)/bin')
let-env PATH = ($env.PATH | append $'/usr/local/go/bin')
# PyEnv
let-env PATH = ($env.PATH | append $'($env.PYENV_ROOT)/bin')
# Cargo
let-env PATH = ($env.PATH | append $'($env.HOME)/.cargo/bin')
# FNM
# load env variables
fnm env --json | from json | load-env
let-env PATH = ($env.PATH | append $'($env.FNM_MULTISHELL_PATH)/bin')
# Local User binaries
let-env PATH = ($env.PATH | append $'($env.HOME)/.toolbox/bin')
# Wasmer
let-env WASMER_DIR = "/home/mitchellvaline/.wasmer"
let-env WASMER_CACHE_DIR = $'($env.WASMER_DIR)/cache'
let-env PATH = ($env.PATH | append $'($env.WASMER_DIR)/globals/wapm/packages/.bin') 
# Java11
let-env PATH = ($env.PATH | prepend '/usr/local/opt/openjdk@11/bin')

# Enable starship prompt
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

# add dynamic fnm path
let-env PATH = ($env.PATH | split row (char esep) | prepend ([$env.FNM_MULTISHELL_PATH "bin"] | path join))

# add fnm with cd
def-env fnmcd [path?: string] {
  if ($path == null) {
    cd
  } else {
    cd ($path | path expand)
  }
  if (['.node-version' '.nvmrc'] | any {|it| $env.PWD | path join $it | path exists}) {
     fnm use --silent-if-unchanged
  }
}

alias cd = fnmcd

# -- pyenv --
let-env PATH = ($env.PATH | append $"($env.HOME)/.pyenv/bin")
let-env PATH = ($env.PATH | append $"($env.HOME)/.pyenv/shims")

# replicate pyenv init - | source
let-env PYENV_VERSION = ""
let-env PYENV_VERSION_OLD = ""
let-env PYENV_SHELL = "nu"

#TODO: replicate source '/home/XXXX/.pyenv/libexec/../completions/pyenv.bash'

def-env pyenv [command, ...args] {
    let newenv = if $command in ["activate", "deactivate", "rehash", "shell"] {
        if $command == "shell" {
            { PYENV_VERSION_OLD: $env.PYENV_VERSION PYENV_VERSION: $args.0 }
        } else {
            error make { msg: $"`($command)` command is not supported yet" }
        }
    } else {
        ^pyenv $command $args
        {}
    }
    load-env $newenv
}

# -- pipenv --

# use pipenv function made for bash to edit the env
# TODO: add poetry support
def pshell [] {
    bash "-c" "pipenv run nu"
}
let-env PIPENV_PYTHON = $"($env.HOME)/.pyenv/shims/python"
let-env PIPENV_VENV_IN_PROJECT = 1 # optional but recommended
