
# Bugs
- For some reason, when I opened up tmux I got something along the lines saying: `register-python-argcomplete permission denied`. I'm pretty sure this has something to do with oh-my-zsh. Not sure why it only happened in tmux - maybe stderr wasn't shown in regular terminal and it was always happening? Not sure. Fix was just running `chmod u+x`.
