# @ricardoruwer .dotfiles

macOS and developer environment preferences

## Installation

Clone this repository:

```bash
git clone https://github.com/ricardoruwer/dotfiles.git ~/.dotfiles
```
```bash
cd ~/.dotfiles
```

Run the command to install everything:

```bash
./dotfiles install
```

## Syncing Applications

### Alfred

1. Open Alfred Preferences
2. Go to Advanced
3. Click on **Set preferences folder...**
4. Choose `GOOGLE_DRIVE_DIR/Alfred`

### iTerm2

The preferences (theme, profiles, colors, triggers) are loaded from `GOOGLE_DRIVE_DIR/iTerm` by `dotfiles install`. Just open iTerm2 and check that Profiles |> Text |> Font is `FiraCode Nerd Font` (needed for the prompt icons).

### Obsidian

1. Open Obsidian
2. Click on **Open folder as vault**
3. Choose `GOOGLE_DRIVE_DIR/Obsidian/obsidian`

### Other applications

Now you can open and set up other applications:
- `1Password`: Sign in
- `Alfred`: Import the credentials
- `Clocker`: Add San Francisco time
- `Dropshare`: Select "Amazon S3" and import the credentials
- `Rectangle`: Config the shortcuts
