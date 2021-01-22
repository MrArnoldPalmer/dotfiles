#!/bin/bash

rm ~/.config/alacritty/alacritty.yml
cp ./alacritty.yml ~/.config/alacritty/alacritty.yml

rm ~/.config/nvim/init.vim
cp ./neovim.vim ~/.config/nvim/init.vim

rm ~/.tmux.conf
cp ./tmux.conf ~/.tmux.conf

rm ~/.zshrc
cp ./zshrc ~/.zshrc

rm ~/.p10k.zsh
cp ./p10k.zsh ~/.p10k.zsh
