#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

## Alacritty
ALACRITTY_DIR=~/.config/alacritty
ALACRITTY_CONFIG=${ALACRITTY_DIR}/alacritty.yml
if [[ ! -d $ALACRITTY_DIR ]]; then
  echo "alacritty dir doesn't exist, make it!"
  mkdir $ALACRITTY_DIR
fi

if [[ -e $ALACRITTY_CONFIG ]]; then
  echo "alacritty config exists, remove it!"
  rm $ALACRITTY_CONFIG
fi
ln -sv $SCRIPT_DIR/alacritty.yml $ALACRITTY_CONFIG

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
NVIM_LUA_DIR=${NVIM_DIR}/lua
NVIM_CONFIG=${NVIM_DIR}/init.vim
if [[ ! -d $NVIM_DIR ]]; then
  echo "nvim dir doesn't exist, make it!"
  mkdir $NVIM_DIR
fi

if [[ -e $NVIM_CONFIG ]]; then
  echo "nvim config exists, remove it!"
  rm $NVIM_CONFIG
fi
ln -sv $SCRIPT_DIR/neovim.vim $NVIM_CONFIG

if [[ -d $NVIM_LUA_DIR ]]; then
  echo "nvim lua dir exists, remove it"
  rm -rf $NVIM_LUA_DIR
fi
ln -sv $SCRIPT_DIR/lua $NVIM_DIR

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
