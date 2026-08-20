-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local utils = require("config.utils")

utils.add_which_key("<leader>z", "Neovim Tips", "")

utils.add_which_key("<leader>gv", "Diffview", "󰦦")

utils.add_which_key("<leader>tv", "TestTree", "󰴅")

utils.add_which_key("<leader>a", "session", "󰥨")

Snacks.util.lsp.on({ name = "gopls" }, function(bufnr, client)
  pcall(vim.keymap.del, "n", "<leader>rn", { buffer = bufnr })

  pcall(vim.keymap.del, "n", "<leader>wa", { buffer = bufnr })
  pcall(vim.keymap.del, "n", "<leader>wl", { buffer = bufnr })
  pcall(vim.keymap.del, "n", "<leader>wr", { buffer = bufnr })

  pcall(vim.keymap.del, "n", "<leader>e", { buffer = bufnr })
  pcall(vim.keymap.del, "n", "<leader>ff", { buffer = bufnr })
end)
