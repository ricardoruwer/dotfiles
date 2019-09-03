# @ricardoruwer .dotfiles

macOS and developer environment preferences

## Installation

Clone this repository:

```bash
git clone https://github.com/ricardoruwer/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

Run the command to install everything:

```bash
rake install
```

## Syncing Applications

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

### Typora

1. Open articles folder at `Google Drive/Notes`
