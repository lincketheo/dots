#!/bin/bash

function install_nvim_confs() {
  # Used for linter in nvim
  pip3 install --user pynvim
  rm -rf ~/.config/nvim
  mkdir ~/.config/nvim
  ln -s $(pwd)/neovim/init.vim ~/.config/nvim/init.vim
}

function install_tmux_conf() {
  if [ ! -d ~/.tmux/plugins/tpm ];
  then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
  rm -rf ~/.config/tmux
  mkdir ~/.config/tmux
  ln -s $(pwd)/tmux/tmux.conf ~/.config/tmux/tmux.conf

  echo "Install Tmux plugins"
  chmod u+x ~/.config/tmux/plugins/tmux-kanagawa/kanagawa.tmux
}

function install_cli_tools() {
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  if [ ! -d ~/.fzf ];
  then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
  fi
}

function install_zsh() {
  if [ ! -d ~/.oh-my-zsh ];
  then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
  rm ~/.zshrc
  ln -s $(pwd)/zsh/zshrc ~/.zshrc
}

install_nvim_confs
install_tmux_conf
install_cli_tools
install_zsh
