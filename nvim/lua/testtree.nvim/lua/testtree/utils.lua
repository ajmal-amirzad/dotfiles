local M = {}

function M.get_file_extension()
  local buf_name = vim.api.nvim_buf_get_name(0)

  if buf_name == "" then
    return nil
  end

  local ext = vim.fn.fnamemodify(buf_name, ":e")

  if ext == "" then
    return nil
  else
    return ext
  end
end

function M.root_contains_file(file)
  return vim.fn.filereadable(file) == 1
end

function M.buffer_contains(text)
  local content = table.concat(
    vim.api.nvim_buf_get_lines(0, 0, -1, false),
    "\n"
  )
  if string.find(content, text, 1, true) then
    return true
  end
  return false
end

function M.set_contains(tbl, value)
  for _, v in ipairs(tbl) do
    if v == value then
      return true
    end
  end
  return false
end

return M