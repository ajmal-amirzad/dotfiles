-- neovim tips
return {
  "saxon1964/neovim-tips",
  version = "*", -- Only update on tagged releases
  lazy = false, -- Load on startup for daily tip
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "MeanderingProgrammer/render-markdown.nvim", -- Clean rendering
    "OXY2DEV/markview.nvim", -- Rich rendering with advanced features
  },
  opts = {
    daily_tip = 1, -- 0 = off, 1 = once per day, 2 = every startup
    bookmark_symbol = "󱍻 ",
  },
  init = function()
    local map = vim.keymap.set
    map("n", "<leader>zo", ":NeovimTips<CR>", { desc = "Neovim tips", silent = true })
    map("n", "<leader>zb", ":NeovimTipsBookmarks<CR>", { desc = "Bookmarked tips", silent = true })
    map("n", "<leader>ze", ":NeovimTipsEdit<CR>", { desc = "Edit Neovim tips", silent = true })
    map("n", "<leader>za", ":NeovimTipsAdd<CR>", { desc = "Add Neovim tip", silent = true })
    map("n", "<leader>zh", ":help neovim-tips<CR>", { desc = "Neovim tips help", silent = true })
    map("n", "<leader>zr", ":NeovimTipsRandom<CR>", { desc = "Show random tip", silent = true })
    map("n", "<leader>zp", ":NeovimTipsPdf<CR>", { desc = "Open Neovim tips PDF", silent = true })
  end,
}
