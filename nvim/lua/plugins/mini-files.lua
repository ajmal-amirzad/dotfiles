-- mini file explorer
return {
  "nvim-mini/mini.files",
  version = false,
  opts = {
    windows = {
      preview = true,
      width_focus = 40,
      width_nofocus = 20,
      width_preview = 50,
    },
  },
  keys = {
    {
      "<leader>fm",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files (cwd)",
    },
    {
      "<leader>fM",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (root dir)",
    },
  },
}
