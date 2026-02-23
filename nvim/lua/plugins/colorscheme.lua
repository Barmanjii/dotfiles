return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,  -- matches our kitty transparency
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "dark",
        floats = "dark",
      },
    },
  },
  -- set as default colorscheme
  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight-night" } },
}
