local M = {}

local augroup = vim.api.nvim_create_augroup("TestPopupTerminal", { clear = true })

function M.run(cmd)
  ----------------------------------------------------------------------
  -- layout
  ----------------------------------------------------------------------
  local width = math.floor(vim.o.columns * 0.65)
  local height = math.floor(vim.o.lines * 0.55)

  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  ----------------------------------------------------------------------
  -- state
  ----------------------------------------------------------------------
  local prev_win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(false, true)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
    style = "minimal",
    title = " Test Output ",
    title_pos = "center",
  })

  ----------------------------------------------------------------------
  -- IMPORTANT: must be current window BEFORE termopen
  ----------------------------------------------------------------------
  vim.api.nvim_set_current_win(win)

  ----------------------------------------------------------------------
  -- start terminal FIRST (buffer must be "clean")
  ----------------------------------------------------------------------
  local closed = false

  local function close()
    if closed then
      return
    end
    closed = true

    if vim.api.nvim_win_is_valid(win) then
      pcall(vim.api.nvim_win_close, win, true)
    end

    if vim.api.nvim_win_is_valid(prev_win) then
      vim.api.nvim_set_current_win(prev_win)
    end

    pcall(vim.api.nvim_clear_autocmds, {
      group = augroup,
      buffer = buf,
    })
  end

  local job_id = vim.fn.termopen(cmd, {
    on_exit = function(_, code) end,
  })

  ----------------------------------------------------------------------
  -- NOW safe to configure buffer options
  ----------------------------------------------------------------------
  vim.bo[buf].buflisted = false
  vim.bo[buf].swapfile = false
  vim.bo[buf].bufhidden = "wipe"

  vim.cmd("startinsert")

  ----------------------------------------------------------------------
  -- keymaps (NORMAL mode)
  ----------------------------------------------------------------------
  vim.keymap.set("n", "q", close, {
    buffer = buf,
    nowait = true,
    silent = true,
  })

  vim.keymap.set("n", "<Esc>", close, {
    buffer = buf,
    nowait = true,
    silent = true,
  })

  vim.keymap.set("n", "<C-c>", close, {
    buffer = buf,
    nowait = true,
    silent = true,
  })

  ----------------------------------------------------------------------
  -- keymaps (TERMINAL mode)
  ----------------------------------------------------------------------
  vim.keymap.set("t", "<C-q>", close, {
    buffer = buf,
    nowait = true,
    silent = true,
  })

  vim.keymap.set("t", "<Esc><Esc>", close, {
    buffer = buf,
    nowait = true,
    silent = true,
  })

  vim.keymap.set("t", "<C-c>", close, {
    buffer = buf,
    nowait = true,
    silent = true,
  })

  ----------------------------------------------------------------------
  -- close on focus loss
  ----------------------------------------------------------------------
  vim.api.nvim_create_autocmd("WinLeave", {
    group = augroup,
    buffer = buf,
    callback = function()
      vim.schedule(function()
        if vim.api.nvim_get_current_win() ~= win then
          close()
        end
      end)
    end,
  })

  return buf, win, job_id
end

return M
