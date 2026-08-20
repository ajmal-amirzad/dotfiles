local M = {}

local state = require("testtree.state")
local view = require("testtree.view")
local tree = require("testtree.tree")
local config = require("testtree.config")
local providers = require("testtree.providers")
local runners = require("testtree.runners")
local terminal = require("testtree.terminal")

----------------------------------------------------------------------
-- lifecycle
----------------------------------------------------------------------

function M.open()
  if view.is_open() then
    return
  end

  local current_buffer_supported = providers.supports_current_buffer()
  if not current_buffer_supported then
    return
  end

  local provider = providers.get()

  local ok, items_or_err = pcall(function()
    return provider.get_items()
  end)

  if not ok then
    vim.notify("Provider error: " .. tostring(items_or_err), vim.log.levels.ERROR)
    return
  end

  if items_or_err == nil then
    return
  end

  state.items = items_or_err or {}
  state.selected = 1

  config.set_active_language(providers.get_active_language())

  view.open()
end

function M.toggle()
  if view.is_open() then
    view.close()
  else
    M.open()
  end
end

function M.close()
  view.close()
end

function M.focus()
  view.focus()
end

----------------------------------------------------------------------
-- navigation
----------------------------------------------------------------------

function M.move(delta)
  local len = #state.nodes
  if len == 0 then
    return
  end

  state.selected = (state.selected - 1 + delta) % len + 1
  view.render()
end

function M.toggle_fold()
  local node = state.nodes[state.selected]
  if not node then
    return
  end

  if node.item.children then
    tree.toggle_fold(node.item.path)
    view.render()
  end
end

function M.run_test()
  local node = state.nodes[state.selected]
  if node and runners.has_test_runner() then
    local command = runners.get_test_command(node.item)
    terminal.run(command)
  end
end

return M
