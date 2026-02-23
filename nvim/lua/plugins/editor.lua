return {
  -- Better surround (ys, ds, cs)
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  -- Auto close brackets
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,  -- treesitter aware
    },
  },

  -- Better increment/decrement
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true },
    },
  },
}
