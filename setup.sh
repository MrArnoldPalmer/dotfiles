#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# Install packages with homebrew
brew bundle install

## Alacritty
ALACRITTY_DIR=~/.config/alacritty
ALACRITTY_CONFIG=${ALACRITTY_DIR}/alacritty.toml
if [[ ! -d $ALACRITTY_DIR ]]; then
  echo "alacritty dir doesn't exist, make it!"
  mkdir $ALACRITTY_DIR
fi

if [[ -e $ALACRITTY_CONFIG ]]; then
  echo "alacritty config exists, remove it!"
  rm $ALACRITTY_CONFIG
fi
ln -sv $SCRIPT_DIR/alacritty.toml $ALACRITTY_CONFIG

## Nushell
NUSHELL_DIR=~/.config/nushell
NUSHELL_CONFIG=${NUSHELL_DIR}/config.nu
NUSHELL_ENV_CONFIG=${NUSHELL_DIR}/env.nu
if [[ ! -d $NUSHELL_DIR ]]; then
  echo "nushell dir doesn't exist, make it!"
  mkdir $NUSHELL_DIR
fi

if [[ -e $NUSHELL_CONFIG ]]; then
  echo "nu config exists, remove it!"
  rm $NUSHELL_CONFIG
fi
ln -sv $SCRIPT_DIR/nu/config.nu $NUSHELL_CONFIG

if [[ -e $NUSHELL_ENV_CONFIG ]]; then
  echo "nu env config exists, remove it!"
  rm $NUSHELL_ENV_CONFIG
fi
ln -sv $SCRIPT_DIR/nu/env.nu $NUSHELL_ENV_CONFIG

## Neovim
NVIM_DIR=~/.config/nvim
NVIM_CACHE_DIR=~/.local/share/nvim
if [[ -d $NVIM_DIR ]]; then
  echo "neovim dir exists, remove it!"
  rm -rf $NVIM_DIR
fi
if [[ -d $NVIM_CACHE_DIR ]]; then
  echo "neovim cache dir exists, remove it!"
  rm -rf $NVIM_CACHE_DIR
fi
# git clone https://github.com/NvChad/NvChad $NVIM_DIR --depth 1 && nvim

ln -sv $SCRIPT_DIR/nvim $NVIM_DIR

## Tmux
TMUX_CONFIG=~/.tmux.conf
if [[ -e $TMUX_CONFIG ]]; then
  echo "tmux config exists, remove it!"
  rm $TMUX_CONFIG
fi
ln -sv $SCRIPT_DIR/tmux.conf $TMUX_CONFIG

## Zellij
ZELLIJ_DIR=~/.config/zellij
ZELLIJ_CONFIG=${ZELLIJ_DIR}/config.kdl
if [[ ! -d $ZELLIJ_DIR ]]; then
  echo "zellij dir doesn't exist, make it!"
  mkdir $ZELLIJ_DIR
fi

if [[ -e $ZELLIJ_CONFIG ]]; then
  echo "zellij config exists, remove it!"
  rm $ZELLIJ_CONFIG
fi
ln -sv $SCRIPT_DIR/zellij.kdl $ZELLIJ_CONFIG

## ZSH
ZSH_CONFIG=~/.zshrc
if [[ -e $ZSH_CONFIG ]]; then
  echo "zsh config exists, remove it!"
  rm $ZSH_CONFIG
fi
ln -sv $SCRIPT_DIR/zshrc $ZSH_CONFIG

## Starship
STARSHIP_CONFIG=~/.config/starship.toml
if [[ -e $STARSHIP_CONFIG ]]; then
  echo "starship config exists, remove it!"
  rm $STARSHIP_CONFIG
fi
ln -sv $SCRIPT_DIR/starship.toml $STARSHIP_CONFIG

ZSH_DIR=~/.zsh
if [[ -d $ZSH_DIR ]]; then
  echo "zsh config dir exists, removing it"
  rm -rf $ZSH_DIR
fi
ln -sv $SCRIPT_DIR/zsh $ZSH_DIR

## Misc Tools Dir
MISC_TOOLS=~/dev/misc
mkdir $MISC_TOOLS

## Bat Theme
BAT_THEME_DIR=${MISC_TOOLS}/bat-theme
git clone git@github.com:catppuccin/bat.git $BAT_THEME_DIR
mkdir -p "$(bat --config-dir)/themes"
cp $BAT_THEME_DIR/*.tmTheme "$(bat --config-dir)/themes"
bat cache --build

