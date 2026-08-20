local M = {}

local wk = require("which-key")

function M.add_which_key(key, group, icon)
  wk.add({
    { key, group = group, icon = icon },
  })
end

function M.add_key_map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

return M
