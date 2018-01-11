# @ricardoruwer .dotfiles
macOS and developer environment preferences with Homebrew/GIT/rbenv/ZSH.

## Install

Copy this command into the terminal, and the setup will start.

```bash
cd ~/
git clone https://github.com/ricardoruwer/dotfiles.git .dotfiles
cd .dotfiles && ./install.sh
```

## Sublime Text

1. Close Sublime Text
2. Open Terminal

**First machine**

```bash
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
mkdir ~/Google\ Drive/Sublime
mv User ~/Google\ Drive/Sublime/
ln -s ~/Google\ Drive/Sublime/User
```

**Other machine(s)**

```bash
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
rm -r User
ln -s ~/Google\ Drive/Sublime/User
```
