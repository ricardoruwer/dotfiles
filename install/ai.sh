source ~/.dotfiles/shell/colors.sh
source ~/.dotfiles/shell/functions.sh

PRIVY_CONFIGS=~/.dotfiles/privy/configs

# Both installers put the binary in ~/.local/bin and keep it updated on their own
echo "${Blue}=> Installing Claude Code${ColorOff}"
if command_exists claude; then
  echo "${Green}Claude Code already installed${ColorOff}"
else
  curl -fsSL https://claude.ai/install.sh | bash
fi

echo "${Blue}=> Installing Cursor CLI${ColorOff}"
if command_exists cursor-agent; then
  echo "${Green}Cursor CLI already installed${ColorOff}"
else
  curl -fsSL https://cursor.com/install | bash
fi

if [ ! -d "$PRIVY_CONFIGS/claude" ]; then
  echo "${Red}Missing ${PRIVY_CONFIGS}/claude${ColorOff}"
  echo "Clone privy with ${Green}git clone --recurse-submodules git@github.com:ricardoruwer/privy.git ~/.dotfiles/privy${ColorOff} and run ${Green}dotfiles ai${ColorOff} again"
  exit 1
fi

# Claude Code global config
mkdir -p ~/.claude

echo "${Green}Linking ~/.claude/CLAUDE.md${ColorOff}"
ln -sf "$PRIVY_CONFIGS/claude/CLAUDE.md" ~/.claude/CLAUDE.md

echo "${Green}Linking ~/.claude/skills${ColorOff}"
ln -sfn "$PRIVY_CONFIGS/claude/skills" ~/.claude/skills

echo "${Green}Linking ~/.claude/rules${ColorOff}"
ln -sfn "$PRIVY_CONFIGS/claude/rules" ~/.claude/rules

echo "${Green}Linking ~/.claude/settings.json${ColorOff}"
ln -sf "$PRIVY_CONFIGS/claude/settings.json" ~/.claude/settings.json

echo "${Green}Linking ~/.claude/format-hook.sh${ColorOff}"
ln -sf "$PRIVY_CONFIGS/claude/format-hook.sh" ~/.claude/format-hook.sh

# Generate ~/.claude/RTK.md and the Claude Code and Cursor hooks (rtk is installed via Brewfile)
if command_exists rtk; then
  echo "${Green}Initializing RTK for Claude Code and Cursor${ColorOff}"
  rtk init --global --auto-patch
  rtk init --global --agent cursor --auto-patch
fi

# Cursor reads .cursor/rules from every ancestor of the opened folder, so these apply anywhere under $HOME.
# Runs after rtk because the rules inline ~/.claude/RTK.md.
echo "${Green}Generating Cursor rules in ~/.cursor/rules/personal${ColorOff}"
python3 "$PRIVY_CONFIGS/cursor/sync-personal-rules.py"

echo "${Blue}=> Log in to the AI tools${ColorOff}"
echo "Run ${Green}claude${ColorOff} and ${Green}cursor-agent login${ColorOff}"
