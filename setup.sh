#!/bin/bash

## Alacritty
if ![[-d "~/.config/alacritty"]]; then
  mkdir ~/.config/alacritty
fi

if [[-f "~/.config/alacritty/alacritty.yml"]]; then
  rm ~/.config/alacritty/alacritty.yml
fi
cp ./alacritty.yml ~/.config/alacritty/alacritty.yml

## Neovim
if ![[-d "~/.config/nvim"]]; then
  mkdir ~/.config/nvim
fi

if [[-f "~/.config/nvim/init.vim"]]; then
  rm ~/.config/nvim/init.vim
fi
cp ./neovim.vim ~/.config/nvim/init.vim

## Tmux
if [[-f "~/.tmux.conf"]]; then
  rm ~/.tmux.conf
fi
cp ./tmux.conf ~/.tmux.conf

## ZSH
if [[-f "~/.zshrc"]]; then
  rm ~/.zshrc
fi
cp ./zshrc ~/.zshrc

if [[-f "~/.p10k.zsh"]]; then
  rm ~/.p10k.zsh
fi
cp ./p10k.zsh ~/.p10k.zsh
