-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local utils = require("config.utils")

utils.add_key_map("n", "<leader>bn", "<cmd>tabnew<CR>", "New Buffer")

utils.add_key_map("n", "<leader>cz", function()
  vim.cmd("lsp restart")
  vim.notify("LSP restarted", vim.log.levels.INFO)
end, "Restart LSP")

Snacks.util.lsp.on({ name = "gopls" }, function(bufnr, client)
  pcall(vim.keymap.del, "n", "<leader>rn", { buffer = bufnr })

  pcall(vim.keymap.del, "n", "<leader>wa", { buffer = bufnr })
  pcall(vim.keymap.del, "n", "<leader>wl", { buffer = bufnr })
  pcall(vim.keymap.del, "n", "<leader>wr", { buffer = bufnr })

  pcall(vim.keymap.del, "n", "<leader>e", { buffer = bufnr })
  pcall(vim.keymap.del, "n", "<leader>ff", { buffer = bufnr })
end)
