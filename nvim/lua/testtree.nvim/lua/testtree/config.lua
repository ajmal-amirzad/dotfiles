local M = {}

local defaults = {
  width_ratio = 0.20,
  border = "none",
  language = "",
  mappings = {
    toggle = "<leader>tvt",
    focus = "<leader>tvf",
    open = "<leader>tvo",
    close = "<leader>tvc",
  },
}

M.values = defaults

function M.set(opts)
  M.values = vim.tbl_deep_extend("force", defaults, opts or {})
end

function M.get()
  return M.values
end

function M.set_active_language(lang)
  M.values["language"] = lang
  M.set(M.values)
end

function M.get_active_language()
  return M.values["language"]
end

return M
