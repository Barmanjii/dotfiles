#!/usr/bin/env bash
set -e

# ─────────────────────────────────────────────────────────────────────────────
# barmanji/dotfiles — install script
# Sets up a full dev terminal environment on Ubuntu/Debian
# ─────────────────────────────────────────────────────────────────────────────

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[DONE]${NC} $1"; }
warn()    { echo -e "${YELLOW}[SKIP]${NC} $1"; }

echo ""
echo "  ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗"
echo "  ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝"
echo "  ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗"
echo "  ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║"
echo "  ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║"
echo "  ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝"
echo ""
echo "  barmanji/dotfiles — Terminal Setup"
echo ""

# ─── 1. System packages ───────────────────────────────────────────────────────
info "Installing system packages..."
sudo apt update -q
sudo apt install -y \
  zsh curl wget git unzip bat eza fzf \
  build-essential ripgrep fd-find \
  xclip wl-clipboard
success "System packages installed"

# ─── 2. Kitty ─────────────────────────────────────────────────────────────────
if ! command -v kitty &>/dev/null; then
  info "Installing Kitty..."
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty
  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator ~/.local/bin/kitty 50
  sudo update-alternatives --set x-terminal-emulator ~/.local/bin/kitty
  success "Kitty installed"
else
  warn "Kitty already installed — skipping"
fi

# ─── 3. Zellij ────────────────────────────────────────────────────────────────
if ! command -v zellij &>/dev/null; then
  info "Installing Zellij..."
  curl -L https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz \
    | tar -xz -C ~/.local/bin
  success "Zellij installed"
else
  warn "Zellij already installed — skipping"
fi

# ─── 4. Neovim ────────────────────────────────────────────────────────────────
NVIM_VERSION=$(nvim --version 2>/dev/null | head -1 | grep -oP '\d+\.\d+\.\d+' || echo "0.0.0")
NVIM_REQUIRED="0.11.2"
if [ "$(printf '%s\n' "$NVIM_REQUIRED" "$NVIM_VERSION" | sort -V | head -1)" != "$NVIM_REQUIRED" ]; then
  info "Installing latest Neovim..."
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
  chmod +x nvim-linux-x86_64.appimage
  sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
  success "Neovim installed"
else
  warn "Neovim $NVIM_VERSION already meets requirement — skipping"
fi

# ─── 5. JetBrainsMono Nerd Font ───────────────────────────────────────────────
if ! fc-list | grep -qi "JetBrainsMono"; then
  info "Installing JetBrainsMono Nerd Font..."
  mkdir -p ~/.local/share/fonts
  cd ~/.local/share/fonts
  wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip -q JetBrainsMono.zip -d JetBrainsMono
  fc-cache -fv &>/dev/null
  cd "$DOTFILES_DIR"
  success "JetBrainsMono Nerd Font installed"
else
  warn "JetBrainsMono already installed — skipping"
fi

# ─── 6. nvm + Node.js ─────────────────────────────────────────────────────────
if ! command -v nvm &>/dev/null && [ ! -d "$HOME/.nvm" ]; then
  info "Installing nvm + Node.js LTS..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  source "$NVM_DIR/nvm.sh"
  nvm install --lts
  nvm use --lts
  success "Node.js installed"
else
  warn "nvm already installed — skipping"
fi

# ─── 7. Symlink configs ───────────────────────────────────────────────────────
info "Symlinking configs..."

symlink() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.bak.$(date +%s)"
    warn "Backed up existing $(basename $dst)"
  fi
  ln -sf "$src" "$dst"
}

symlink "$DOTFILES_DIR/kitty/kitty.conf"        "$HOME/.config/kitty/kitty.conf"
symlink "$DOTFILES_DIR/zellij/config.kdl"        "$HOME/.config/zellij/config.kdl"
symlink "$DOTFILES_DIR/nvim/lua/plugins"         "$HOME/.config/nvim/lua/plugins"
symlink "$DOTFILES_DIR/zsh/aliases.zsh"          "$HOME/.config/zsh/aliases.zsh"

success "Configs symlinked"

# ─── 8. LazyVim ───────────────────────────────────────────────────────────────
if [ ! -d "$HOME/.config/nvim/lua/lazyvim" ]; then
  info "Installing LazyVim starter..."
  git clone https://github.com/LazyVim/starter ~/.config/nvim --quiet
  rm -rf ~/.config/nvim/.git
  success "LazyVim installed — run nvim to finish plugin installation"
else
  warn "LazyVim already set up — skipping"
fi

# ─── 9. Zellij as default Kitty shell ────────────────────────────────────────
if ! grep -q "shell zellij" ~/.config/kitty/kitty.conf 2>/dev/null; then
  echo "shell zellij" >> ~/.config/kitty/kitty.conf
  success "Zellij set as Kitty default shell"
fi

# ─── 10. Wire aliases into zshrc ─────────────────────────────────────────────
if ! grep -q "aliases.zsh" ~/.zshrc 2>/dev/null; then
  echo 'source "$HOME/.config/zsh/aliases.zsh"' >> ~/.zshrc
  success "Aliases sourced in .zshrc"
else
  warn "Aliases already in .zshrc — skipping"
fi

# ─── Done ─────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  All done! Restart Kitty to see everything in action${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "  Next steps:"
echo "  1. Open nvim and wait for plugins to install"
echo "  2. Run :Copilot auth to link GitHub Copilot"
echo "  3. Wakatime will prompt for your API key on first nvim launch"
echo ""
