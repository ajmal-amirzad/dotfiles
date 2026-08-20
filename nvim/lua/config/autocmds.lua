-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    if vim.bo.filetype == "snacks_dashboard" then
      return
    end

    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    if vim.bo.filetype == "snacks_dashboard" then
      return
    end

    vim.opt.relativenumber = true
  end,
})

-- left/right arrow keys result in error when in insert mode in sql files
vim.g.omni_sql_no_default_maps = true
