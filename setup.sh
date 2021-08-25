#!/bin/bash

## Alacritty
if ![[-d "~/.config/alacritty"]]; then
  mkdir ~/.config/alacritty
fi

if [[-f "~/.config/alacritty/alacritty.yml"]]; then
  rm ~/.config/alacritty/alacritty.yml
fi
ln -sv ./alacritty.yml ~/.config/alacritty/alacritty.yml

## Neovim
if ![[-d "~/.config/nvim"]]; then
  mkdir ~/.config/nvim
fi

if [[-f "~/.config/nvim/init.vim"]]; then
  rm ~/.config/nvim/init.vim
fi
ln -sv ./neovim.vim ~/.config/nvim/init.vim

## Tmux
if [[-f "~/.tmux.conf"]]; then
  rm ~/.tmux.conf
fi
ln -sv ./tmux.conf ~/.tmux.conf

## ZSH
if [[-f "~/.zshrc"]]; then
  rm ~/.zshrc
fi
ln -sv ./zshrc ~/.zshrc

if [[-f "~/.p10k.zsh"]]; then
  rm ~/.p10k.zsh
fi
ln -sv ./p10k.zsh ~/.p10k.zsh
