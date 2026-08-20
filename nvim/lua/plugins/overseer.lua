return {
  {
    "stevearc/overseer.nvim",
    opts = {
      task_list = {
        direction = "bottom",
        min_height = math.floor(vim.o.lines * 0.40),
      },
      template = {
        "builtin",
      },
    },
  },
  -- just to change icon
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>o", group = "overseer", icon = "󰅬" },
      },
    },
  },
}
