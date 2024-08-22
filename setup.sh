#!/bin/bash

function install_nvim_confs() {
  # Used for linter in nvim
  rm -rf ~/.config/nvim
  mkdir ~/.config/nvim
  ln -sf "$(pwd)/neovim/init.vim" ~/.config/nvim/init.vim

  # Setup
  # Setup node.js neovim provider
  npm install -g neovim
}

function install_tmux_conf() {
  if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  rm -rf ~/.config/tmux
  mkdir ~/.config/tmux

  # https://github.com/tmux/tmux/pull/3023
  IFS=' ' read -ar tmux_out <<<"$(tmux -V)"
  tmux_version=${tmux_out[1]}
  if (($(echo "$tmux_version > 3.1" | bc -l))); then
    chmod u+x ~/.config/tmux/plugins/tmux-kanagawa/kanagawa.tmux
    ln -sf "$(pwd)/tmux/tmux.conf" ~/.config/tmux/tmux.conf
  else
    chmod u+x ~/.tmux/plugins/tmux-kanagawa/kanagawa.tmux
    ln -sf "$(pwd)/tmux/tmux.conf" ~/.tmux.conf
  fi
}

function setup_ctags() {
  ln -sf "$(pwd)/ctags/ctags" ~/.ctags
}

function install_my_bins() {
  for script in ./bin/*.sh; do
    exe_ext=$(basename "$script")
    exe_no_ext="${exe_ext%.sh}"
    echo "Installing $script to ~/.local/bin/$exe_no_ext"
    cp "$script" "$HOME/.local/bin/$exe_no_ext"
  done
}


function install_minor_cli_tools() {
  # zoxide and fzf
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  if [ ! -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
  fi
}

function setup_user_python_env() {
  pip3 install --user -r ./requirements.txt
}

function install_zsh() {
  if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
  rm ~/.zshrc
  ln -sf "$(pwd)/zsh/zshrc" ~/.zshrc
}

function install_git() {
  git config --global core.excludesFile "$(pwd)/git/gitignore"
}

