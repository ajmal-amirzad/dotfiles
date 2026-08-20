local M = {}

local config = require("testtree.config")
local controller = require("testtree.controller")
local mappings = require("testtree.mappings")

function M.setup(opts)
  config.set(opts)

  vim.api.nvim_create_user_command("TestTree", function()
    M.toggle()
  end, {})

  mappings.apply_mappings(config.get().mappings)
end

function M.open()
  controller.open()
end

function M.toggle()
  controller.toggle()
end

function M.focus()
  controller.focus()
end

function M.close()
  controller.close()
end

return M
