# @ricardoruwer .dotfiles

macOS configuration files and utilities.

## Install

Copy this command into the terminal, and the setup will start.

```bash
git clone https://github.com/ricardoruwer/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

## Sync Applications

### Sublime Text

```bash
# When your User folder is synced in Google Drive...
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
rm -r User
ln -s ~/Google\ Drive/Sublime/User
```

### Alfred

1. Open Alfred Preferences
2. Click on **Set sync folder...**
3. Choose `~/Google Drive/Alfred`

### iTerm2

1. Open iTerm2 Preferences
2. Browse `Google Drive/iTerm` folder
3. Go to Profiles -> Colors -> Color Presets -> Import
4. Choose the `itermcolor` file in `Google Drive/iTerm` folder
