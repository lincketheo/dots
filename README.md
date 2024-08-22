# My Dot Files

## Philosophy
I don't like the idea of "install". Just give me a bin and I can put it wherever. So, as much as I can, I avoid tying executables to file locations. See ./scripts/get_\*.sh for a list of my dependencies. I can't do it for everything, but it works for now. These scripts aren't perfect because no distributor is 100% consistent, so they're designed to be debuggable and intentionally run.

Therefore, I will try as hard as I can to not move any file to an unknown location. For those cases, I'll give instructions in this readme.

## Neovim
```
$ ln -sf "$(pwd)/neovim/init.vim" ~/.config/nvim/init.vim
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
$ git config --global core.excludesFile "$(pwd)/git/gitignore"
```

