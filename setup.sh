#!/bin/bash

function install_treesitter() {
  if ! command -v tree-sitter &>/dev/null; then
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

function install_shfmt() {
  version=v3.8.0
  artifact=shfmt_${version}_linux_amd64

  wget https://github.com/mvdan/sh/releases/download/$version/$artifact
  chmod u+x $artifact
  cp $artifact "$HOME/.local/bin/shfmt"
  rm $artifact
}

function install_shellcheck() {
  version=stable
  outdir=shellcheck-stable
  artifact=$outdir.linux.x86_64.tar.xz
  exe=shellcheck

  wget https://github.com/koalaman/shellcheck/releases/download/$version/$artifact
  tar -xf $artifact
  cp $outdir/$exe ~/.local/bin
  rm -rf $outdir
  rm -rf $artifact
}

function install_delta() {
  echo "TODO"
}

function install_nvim_confs() {
  # Used for linter in nvim
  rm -rf ~/.config/nvim
  mkdir ~/.config/nvim
  ln -sf "$(pwd)/neovim/init.vim" ~/.config/nvim/init.vim

  # Setup
  # Setup node.js neovim provider
  npm install -g neovim
}

function other_npm_installs() {
  # These are mostly for nvim. Although I haven't gotten them to work yet and
  # my goto is to edit in vscode or webstorm. Someday I'll fix, for now, I'll
  # just install them
  npm install -g @tailwindcss/language-server
  npm install -g @vue/language-server
  npm install -g typescript-language-server typescript
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

function install_my_bins() {
  for script in ./bin/*.sh; do
    exe_ext=$(basename "$script")
    exe_no_ext="${exe_ext%.sh}"
    echo "Installing $script to ~/.local/bin/$exe_no_ext"
    cp "$script" "$HOME/.local/bin/$exe_no_ext"
  done
}

function install_commitizen() {
  npm install -g commitizen
  npm install -g cz-conventional-changelog
  rm -f ~/.czrc
  ln -sf "$(pwd)/cz-cli/czrc" ~/.czrc
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

install_shfmt
install_my_bins
install_treesitter
install_nvim_confs
install_tmux_conf
install_minor_cli_tools
install_zsh
install_commitizen
install_shellcheck
setup_user_python_env
other_npm_installs
