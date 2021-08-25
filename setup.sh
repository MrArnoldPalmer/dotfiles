#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
## Alacritty
if [[ ! -d ~/.config/alacritty ]]; then
  echo "alacritty dir doesn't exist, make it!"
  mkdir ~/.config/alacritty
fi

if [[ -e ~/.config/alacritty/alacritty.yml ]]; then
  echo "alacritty config exists, remove it!"
  rm ~/.config/alacritty/alacritty.yml
fi
ln -sv $SCRIPT_DIR/alacritty.yml ~/.config/alacritty/alacritty.yml

## Neovim
if [[ ! -d ~/.config/nvim ]]; then
  echo "nvim dir doesn't exist, make it!"
  mkdir ~/.config/nvim
fi

if [[ -e ~/.config/nvim/init.vim ]]; then
  echo "nvim config exists, remove it!"
  rm ~/.config/nvim/init.vim
fi
ln -sv $SCRIPT_DIR/neovim.vim ~/.config/nvim/init.vim

## Tmux
if [[ -e ~/.tmux.conf ]]; then
  echo "tmux config exists, remove it!"
  rm ~/.tmux.conf
fi
ln -sv $SCRIPT_DIR/tmux.conf ~/.tmux.conf

## ZSH
if [[ -e ~/.zshrc ]]; then
  echo "zsh config exists, remove it!"
  rm ~/.zshrc
fi
ln -sv $SCRIPT_DIR/zshrc ~/.zshrc

if [[ -e ~/.p10k.zsh ]]; then
  echo "p10k config exists, remove it!"
  rm ~/.p10k.zsh
fi
ln -sv $SCRIPT_DIR/p10k.zsh ~/.p10k.zsh
