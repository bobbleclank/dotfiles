# Dot Files

Dot files for Bash, Clang-Format, Claude, Git, Neovim, tmux and Vim.

```
cd ~

ln -s ~/dotfiles/home/dot_bashrc .bashrc
ln -s ~/dotfiles/home/dot_gitconfig .gitconfig
ln -s ~/dotfiles/home/dot_tmux.conf .tmux.conf
ln -s ~/dotfiles/home/dot_vimrc .vimrc

mkdir -p .config/nvim
ln -s ~/dotfiles/home/dot_config/nvim/init.lua .config/nvim/init.lua

mkdir .claude
ln -s ~/dotfiles/home/dot_claude/CLAUDE.md .claude/CLAUDE.md

ln -s /usr/local/opt/clang-format/share/clang/clang-format.py
```
