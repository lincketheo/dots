# My Dot Files

## Philosophy
I don't like the idea of "install". Just give me a bin and I can put it wherever. So, as much as I can, I avoid tying executables to file locations. See ./scripts/get_\*.sh for a list of my dependencies. I can't do it for everything, but it works for now. These scripts aren't perfect because no distributor is 100% consistent, so they're designed to be debuggable and intentionally run.

Therefore, I will try as hard as I can to not move any file to an unknown location. For those cases, I'll give instructions in this readme.

## Node 
### Design:
Everything will be installed inside ~/.js. No need to use sudo for npm 
```
$ mkdir -p ~/.js/npm
$ npm config set prefix ~/.js/npm 
$ npm install -g n 
$ export PATH=$HOME/.js/npm/bin:$PATH 
$ export N_PREFIX=~/.js/n 
$ n stable 
$ export PATH=$HOME/.js/n/bin:$PATH
```

## Neovim
```
$ ln -sf "$(pwd)/neovim/init.vim" ~/.config/nvim/init.vim
```

## Idea 
```
$ ln -sf "$(pwd)/idea/ideavimrc" ~/.ideavimrc"
```

## Tmux
```
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# See: https://github.com/tmux/tmux/pull/3023

# If tmux version > 3.1
$ chmod u+x ~/.config/tmux/plugins/tmux-kanagawa/kanagawa.tmux
$ ln -sf "./tmux/tmux.conf" ~/.config/tmux/tmux.conf

# else
$ chmod u+x ~/.tmux/plugins/tmux-kanagawa/kanagawa.tmux
$ ln -sf "./tmux/tmux.conf" ~/.tmux.conf
```

## CTags
```
$ ln -sf "$(pwd)/ctags/ctags" ~/.ctags
```

## ZOxide
```
$ curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

## fzf
```
$ git clone --depth 1 https://github.com/junegunn/fzf.git
$ ./fzf/install
```

## system wide python deps 
```
$ pip3 install --user -r ./requirements.txt
```

## zsh 
```
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$ rm ~/.zshrc
$ ln -sf "$(pwd)/zsh/zshrc" ~/.zshrc
```

## git
```
$ ln -sf $(pwd)/dots/git/gitconfig $(cd && pwd)/.gitconfig
$ git config --global core.excludesFile "$(pwd)/git/gitignore"
```

