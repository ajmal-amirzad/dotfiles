local M = {}

local utils = require("testtree.utils")

local supported_providers = {
  "java",
  "kt",
}

function M.has_test_runner()
  return utils.root_contains_file("mvnw") or utils.root_contains_file("gradlew")
end

function M.get_test_command(test_node)
  if utils.root_contains_file("mvnw") then
    return require("testtree.runners.mvnw").get(test_node)
  elseif utils.root_contains_file("gradlew") then
    return require("testtree.runners.gradlew").get(test_node)
  end
end

return M
