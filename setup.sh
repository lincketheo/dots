#!/bin/bash
#

function install_treesitter() {
  if ! command -v tree-sitter &> /dev/null; then
    # TODO - Mac
    version=v0.20.4 # TODO - for older version of GLIBC
    exe=tree-sitter-linux-x64
    artifact=$exe.gz

    wget https://github.com/tree-sitter/tree-sitter/releases/download/$version/$artifact
    gunzip $artifact
    chmod u+x $exe
    mv $exe ~/.local/bin/tree-sitter
    rm -f $exe $artifact
  fi
}

function install_delta() {
  echo "TODO"
}

function install_nvim_confs() {
  # Used for linter in nvim
  pip3 install --user pynvim
  rm -rf ~/.config/nvim
  mkdir ~/.config/nvim
  ln -sf $(pwd)/neovim/init.vim ~/.config/nvim/init.vim

  # Setup
  # Setup node.js neovim provider
  npm install -g neovim
}

function install_tmux_conf() {
  if [ ! -d ~/.tmux/plugins/tpm ];
  then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  rm -rf ~/.config/tmux
  mkdir ~/.config/tmux

  # https://github.com/tmux/tmux/pull/3023
  IFS=' ' read -a tmux_out <<< "$(tmux -V)"
  tmux_version=${tmux_out[1]}
  if (( $(echo "tmux_version > 3.1" | bc -l) )); then
    chmod u+x ~/.config/tmux/plugins/tmux-kanagawa/kanagawa.tmux
    ln -sf $(pwd)/tmux/tmux.conf ~/.config/tmux/tmux.conf
  else
    chmod u+x ~/.tmux/plugins/tmux-kanagawa/kanagawa.tmux
    ln -sf $(pwd)/tmux/tmux.conf ~/.tmux.conf
  fi
}

function install_my_bins() {
  for script in ./bin/*.sh; do
    exe_ext=$(basename "$script")
    exe_no_ext="${exe_ext%.sh}"
    echo "Installing $script to ~/.local/bin/$exe_no_ext"
    cp $script ~/.local/bin/$exe_no_ext
  done
}

function install_commitizen() {
  npm install -g commitizen
  npm install -g cz-conventional-changelog
  rm -f ~/.czrc
  ln -sf $(pwd)/cz-cli/czrc ~/.czrc
}

function install_minor_cli_tools() {
  # zoxide and fzf
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  if [ ! -d ~/.fzf ];
  then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
  fi

  # Commitizen cli

}

function install_zsh() {
  if [ ! -d ~/.oh-my-zsh ];
  then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
  rm ~/.zshrc
  ln -sf $(pwd)/zsh/zshrc ~/.zshrc
}

#install_treesitter
#install_nvim_confs
#install_tmux_conf
#install_minor_cli_tools
#install_zsh
install_my_bins
install_commitizen
