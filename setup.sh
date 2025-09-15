#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# Install packages with homebrew
brew bundle install

## Alacritty
ALACRITTY_DIR=~/.config/alacritty
ALACRITTY_CONFIG=${ALACRITTY_DIR}/alacritty.toml
mkdir -p $ALACRITTY_DIR
ln -svf $SCRIPT_DIR/alacritty.toml $ALACRITTY_CONFIG

## Alacritty
CLAUDE_DIR=~/.claude
CLAUDE_CONFIG=${CLAUDE_DIR}/settings.json
mkdir -p $CLAUDE_DIR
ln -svf $SCRIPT_DIR/claude_settings.json $CLAUDE_CONFIG

## Wezterm
WEZTERM_DIR=~/.config/wezterm
ln -svf $SCRIPT_DIR/wezterm $WEZTERM_DIR

## Ghostty
GHOSTTY_DIR=~/.config/ghostty
GHOSTTY_CONFIG=${GHOSTTY_DIR}/config
mkdir -p $GHOSTTY_DIR
ln -svf $SCRIPT_DIR/ghostty/config $GHOSTTY_CONFIG

## Ghostty Theme
GHOSTTY_THEME_DIR=${GHOSTTY_DIR}/themes
mkdir -p $GHOSTTY_THEME_DIR
TEMP_DIR=$(mktemp -d)
curl -L https://github.com/catppuccin/ghostty/archive/main.tar.gz | tar -xz -C $TEMP_DIR
cp $TEMP_DIR/ghostty-main/themes/* $GHOSTTY_THEME_DIR/
rm -rf $TEMP_DIR

## Nushell
NUSHELL_DIR=~/.config/nushell
NUSHELL_CONFIG=${NUSHELL_DIR}/config.nu
NUSHELL_ENV_CONFIG=${NUSHELL_DIR}/env.nu
mkdir -p $NUSHELL_DIR
ln -svf $SCRIPT_DIR/nu/config.nu $NUSHELL_CONFIG
ln -svf $SCRIPT_DIR/nu/env.nu $NUSHELL_ENV_CONFIG

## Neovim
NVIM_DIR=~/.config/nvim
NVIM_CACHE_DIR=~/.local/share/nvim
ln -svf $SCRIPT_DIR/nvim $NVIM_DIR

## Tmux
TMUX_CONFIG=~/.tmux.conf
ln -svf $SCRIPT_DIR/tmux.conf $TMUX_CONFIG

## Zellij
ZELLIJ_DIR=~/.config/zellij
ZELLIJ_CONFIG=${ZELLIJ_DIR}/config.kdl
mkdir -p $ZELLIJ_DIR
ln -svf $SCRIPT_DIR/zellij.kdl $ZELLIJ_CONFIG

## ZSH
ZSH_CONFIG=~/.zshrc
ln -svf $SCRIPT_DIR/zshrc $ZSH_CONFIG

## Starship
STARSHIP_CONFIG=~/.config/starship.toml
ln -svf $SCRIPT_DIR/starship.toml $STARSHIP_CONFIG

ZSH_DIR=~/.zsh
ln -svf $SCRIPT_DIR/zsh $ZSH_DIR

## Misc Tools Dir
MISC_TOOLS=~/dev/misc
mkdir -p $MISC_TOOLS

## Bat Theme
BAT_THEME_DIR=${MISC_TOOLS}/bat-theme
git clone git@github.com:catppuccin/bat.git $BAT_THEME_DIR
mkdir -p "$(bat --config-dir)/themes"
cp $BAT_THEME_DIR/*.tmTheme "$(bat --config-dir)/themes"
bat cache --build

