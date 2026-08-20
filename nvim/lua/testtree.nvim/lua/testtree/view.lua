local state = require("testtree.state")
local config = require("testtree.config")
local tree = require("testtree.tree")

local M = {}

local function is_open()
  return state.win and vim.api.nvim_win_is_valid(state.win)
end

local function reset()
  state.buf = nil
  state.win = nil
  state.nodes = {}
  state.selected = 1
  state.scroll = 0
end

function M.is_open()
  return is_open()
end

----------------------------------------------------------------------
-- render
----------------------------------------------------------------------

function M.render()
  if not is_open() then
    return
  end

  local buf = state.buf
  local win = state.win

  local flat = tree.flatten(state.items, state.folded)
  state.nodes = flat

  if #flat == 0 then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
    return
  end

  state.selected = math.max(1, math.min(state.selected, #flat))

  local lines = {}

  for i, node in ipairs(flat) do
    local item = node.item
    local indent = string.rep("│ ", node.depth)

    local icon = "  "
    if item.children and #item.children > 0 then
      icon = tree.is_folded(item.path) and " " or " "
    end

    lines[i] = table.concat({
      indent,
      icon,
      item.icon or "",
      " ",
      item.display_name,
    })
  end

  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  vim.api.nvim_win_set_cursor(win, { state.selected, 0 })
end

----------------------------------------------------------------------
-- window
----------------------------------------------------------------------

function M.open()
  local cfg = config.get()

  local width = math.floor(vim.o.columns * cfg.width_ratio)

  -- commented out because the widow always shows on top of other windows
  -- local win = vim.api.nvim_open_win(buf, true, {
  --   relative = "editor",
  --   width = width,
  --   height = vim.o.lines - 1,
  --   row = 0,
  --   col = vim.o.columns - width,
  --   style = "minimal",
  --   border = cfg.border,
  -- })

  -- Open a vertical split on the right
  vim.cmd("botright " .. width .. "vsplit")
  local win = vim.api.nvim_get_current_win()

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(win, buf)

  state.buf = buf
  state.win = win

  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = false
  vim.bo[buf].filetype = "testtree"

  vim.wo[win].winfixwidth = true
  vim.wo[win].cursorline = true
  vim.wo[win].signcolumn = "no"
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].winfixbuf = true

  require("testtree.mappings").apply_nav_mappings(buf)

  vim.api.nvim_create_autocmd("WinClosed", {
    once = true,
    callback = function(args)
      if tonumber(args.match) == win then
        reset()
      end
    end,
  })

  M.render()
  vim.api.nvim_set_current_win(win)
end

function M.close()
  if not is_open() then
    return
  end
  vim.api.nvim_win_close(state.win, true)
end

function M.focus()
  if not is_open() then
    return
  end

  if vim.api.nvim_get_current_win() == state.win then
    -- doesn't want to move focus out of the test tree
    -- vim.cmd("wincmd p")
  else
    vim.api.nvim_set_current_win(state.win)
  end
end

return M
