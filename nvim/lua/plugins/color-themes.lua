return {
  {
    "Aejkatappaja/cendre",
    lazy = false,
    priority = 1000,
    config = function()
      require("cendre").setup({
        background = "hard", -- "hard" | "medium" | "soft"
        italic_virtual_text = true,
      })

      -- vim.cmd([[colorscheme cendre]])
    end,
  },
  {
    "Mofiqul/vscode.nvim",
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      -- vim.cmd([[colorscheme terafox]])
    end,
  },
  {
    "nickkadutskyi/jb.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("jb").setup({
        snacks = {
          explorer = {
            -- Enable folke/snacks.nvim styling for explorer
            enabled = false,
          },
        },
        telescope = {
          -- Enable telescope.nvim styling
          enabled = false,
        },
      })
      vim.cmd([[colorscheme jb]])
    end,
  },
}
