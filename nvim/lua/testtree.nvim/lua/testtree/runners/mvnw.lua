local M = {}

function M.get(test_node)
  local name = test_node.path
  name = name:gsub("`", "") -- remove all ` within a string

  if test_node.type == "package" then
    return "./mvnw test -Dtest='" .. name .. ".**'"
  elseif test_node.type == "class" then
    return "./mvnw test -Dtest='" .. name .. "\'"
  else
    name = name:gsub("^(.*)%.(.*)$", "%1#%2") -- replace last dot (.) with 3
    return "./mvnw test -Dtest='" .. name .. "'"
  end
end

return M