return {
  "rmagatti/auto-session",
  lazy = false,
  opts = {
    suppressed_dirs = { "~/", "~/Desktop/", "~/Documents/" },
    bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" },
  },
  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { "<leader>as", "<cmd>AutoSession search<CR>", desc = "Search session" },
    { "<leader>aS", "<cmd>AutoSession save<CR>", desc = "Save session" },
    { "<leader>at", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
    { "<leader>ad", "<cmd>AutoSession deletePicker<CR>", desc = "Delete session" },
  },
}
