return {
  -- Treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "python", "javascript", "typescript", "tsx",
        "go", "rust", "lua", "bash",
        "json", "yaml", "toml", "dockerfile",
        "markdown", "markdown_inline", "regex",
      },
    },
  },

  -- LSP servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        ts_ls = {},
        gopls = {},
        rust_analyzer = {},
        lua_ls = {},
        bashls = {},
        dockerls = {},
        yamlls = {},
        jsonls = {},
      },
    },
  },

  -- Auto install LSPs via mason
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright", "typescript-language-server",
        "gopls", "rust-analyzer",
        "lua-language-server", "bash-language-server",
        "dockerfile-language-server", "yaml-language-server",
        "json-lsp", "prettier", "black", "gofumpt",
        "stylua", "shfmt",
      },
    },
  },
}
