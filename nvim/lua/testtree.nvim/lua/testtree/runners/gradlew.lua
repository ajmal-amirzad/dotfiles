local M = {}

function M.get(test_node)
  local name = test_node.path
  name = name:gsub("`", "") -- remove all ` within a string

  if test_node.type == "package" then
    return "./gradlew test --rerun-tasks --no-build-cache --tests '" .. name .. ".*'"
  elseif test_node.type == "class" then
    return "./gradlew test --rerun-tasks --no-build-cache --tests '" .. name .. "'"
  else
    return "./gradlew test --rerun-tasks --no-build-cache --tests '" .. name .. "'"
  end
end

return M