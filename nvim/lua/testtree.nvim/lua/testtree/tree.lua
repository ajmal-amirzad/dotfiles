local state = require("testtree.state")

local M = {}

function M.is_folded(path)
  return state.folded[path] == true
end

function M.toggle_fold(path)
  state.folded[path] = not state.folded[path]
end

function M.flatten(items, folded, depth, out)
  depth = depth or 0
  out = out or {}

  for _, item in ipairs(items) do
    table.insert(out, {
      item = item,
      depth = depth,
    })

    if item.children and not folded[item.path] then
      M.flatten(item.children, folded, depth + 1, out)
    end
  end

  return out
end

return M