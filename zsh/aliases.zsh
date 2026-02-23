# ─── bat ──────────────────────────────────────────────────────────────────────
alias bat="batcat"
alias cat="batcat --paging=never"

# ─── eza ──────────────────────────────────────────────────────────────────────
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first --git"
alias lt="eza --tree --icons --level=2 --group-directories-first"
alias lta="eza --tree --icons --level=3 --group-directories-first -a"

# ─── fzf ──────────────────────────────────────────────────────────────────────
export FZF_DEFAULT_OPTS="
  --layout=reverse
  --border=rounded
  --height=50%
  --preview-window=right:60%:wrap
  --color=bg+:#1a1b26,bg:#1a1b26,spinner:#7dcfff,hl:#f7768e
  --color=fg:#c0caf5,header:#f7768e,info:#7aa2f7,pointer:#7dcfff
  --color=marker:#9ece6a,fg+:#c0caf5,prompt:#7aa2f7,hl+:#f7768e
  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-u:preview-page-up'
  --bind='ctrl-d:preview-page-down'
"
export FZF_DEFAULT_COMMAND="find . -type f -not -path '*/\.git/*'"
export FZF_CTRL_T_OPTS="
  --preview 'batcat --color=always --style=numbers --line-range=:100 {}'
  --bind='ctrl-/:toggle-preview'
"
export FZF_ALT_C_OPTS="
  --preview 'eza --tree --icons --level=2 --color=always {}'
"
source /usr/share/doc/fzf/examples/key-bindings.zsh 2>/dev/null
source /usr/share/doc/fzf/examples/completion.zsh 2>/dev/null
