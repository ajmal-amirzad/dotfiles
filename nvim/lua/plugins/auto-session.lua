return {
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~/", "~/Desktop/", "~/Documents/" },
      bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" },
    },
    keys = {
      -- Will use Telescope if installed or a vim.ui.select picker otherwise
      { "<leader>qs", "<cmd>AutoSession search<CR>", desc = "Search session" },
      { "<leader>qS", "<cmd>AutoSession save<CR>", desc = "Save session" },
      { "<leader>qt", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
      { "<leader>qd", "<cmd>AutoSession deletePicker<CR>", desc = "Delete session" },
    },
  },
  {
    "folke/persistence.nvim",
    enabled = false,
    -- event = "BufReadPre",
    -- opts = {
    --   should_save = function()
    --     -- Don't save dashboard buffers
    --     if
    --       vim.tbl_contains({
    --         "alpha",
    --         "dashboard",
    --         "snacks_dashboard",
    --       }, vim.bo.filetype)
    --     then
    --       return false
    --     end
    --
    --     -- Don't save in these directories
    --     local cwd = vim.fn.getcwd()
    --     local suppressed_dirs = {
    --       vim.fn.expand("~"),
    --       vim.fn.expand("~/Desktop"),
    --       vim.fn.expand("~/Documents"),
    --     }
    --
    --     for _, dir in ipairs(suppressed_dirs) do
    --       if cwd == dir or vim.startswith(cwd, dir .. "/") then
    --         return false
    --       end
    --     end
    --
    --     return true
    --   end,
    -- },
  },
}
