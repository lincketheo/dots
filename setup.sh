#!/bin/bash

# Move nvim stuff
rm -rf ~/.config/nvim
mkdir ~/.config/nvim
ln -s $(pwd)/neovim/init.vim ~/.config/nvim/init.vim
#ln -s $(pwd)/neovim/plugged ~/.config/nvim/plugged
