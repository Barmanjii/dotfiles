# barmanji/dotfiles

My personal terminal setup for Ubuntu/Debian. One script to rule them all.

## Stack

| Tool | Purpose |
|------|---------|
| [Kitty](https://sw.kovidgoyal.net/kitty/) | Terminal emulator |
| [Zellij](https://zellij.dev/) | Terminal multiplexer |
| [Neovim + LazyVim](https://lazyvim.org/) | Editor |
| [Zsh + Oh-My-Zsh + P10k](https://ohmyz.sh/) | Shell |
| [eza](https://github.com/eza-community/eza) | ls replacement |
| [bat](https://github.com/sharkdp/bat) | cat replacement |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder |
| [nvm](https://github.com/nvm-sh/nvm) | Node version manager |

## Theme
Tokyo Night — consistent across Kitty, Zellij, and Neovim.

## Install
```bash
cat > ~/dotfiles/README.md << 'EOF'
# barmanji/dotfiles

My personal terminal setup for Ubuntu/Debian. One script to rule them all.

## Stack

| Tool | Purpose |
|------|---------|
| [Kitty](https://sw.kovidgoyal.net/kitty/) | Terminal emulator |
| [Zellij](https://zellij.dev/) | Terminal multiplexer |
| [Neovim + LazyVim](https://lazyvim.org/) | Editor |
| [Zsh + Oh-My-Zsh + P10k](https://ohmyz.sh/) | Shell |
| [eza](https://github.com/eza-community/eza) | ls replacement |
| [bat](https://github.com/sharkdp/bat) | cat replacement |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder |
| [nvm](https://github.com/nvm-sh/nvm) | Node version manager |

## Theme
Tokyo Night — consistent across Kitty, Zellij, and Neovim.

## Install
```bash
git clone https://github.com/barmanji/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Structure
```
dotfiles/
├── kitty/
│   └── kitty.conf
├── zellij/
│   └── config.kdl
├── nvim/
│   └── lua/plugins/
│       ├── colorscheme.lua
│       ├── languages.lua
│       ├── copilot.lua
│       ├── lazygit.lua
│       ├── editor.lua
│       ├── markdown.lua
│       └── wakatime.lua
├── zsh/
│   └── aliases.zsh
├── install.sh
└── README.md
```

## Keybindings

### Zellij (leader: `ctrl+a`)
| Keys | Action |
|------|--------|
| `ctrl+a` → `\|` | Vertical split |
| `ctrl+a` → `-` | Horizontal split |
| `ctrl+a` → `z` | Zoom pane |
| `ctrl+a` → `h/j/k/l` | Navigate panes |
| `ctrl+a` → `d` | Detach session |

### Neovim (leader: `space`)
| Keys | Action |
|------|--------|
| `space ff` | Find files |
| `space fg` | Live grep |
| `space gg` | LazyGit |
| `space mp` | Markdown preview |
| `Tab` | Accept Copilot suggestion |
