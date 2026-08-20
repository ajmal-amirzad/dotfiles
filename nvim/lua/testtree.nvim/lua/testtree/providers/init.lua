local M = {}

local utils = require("testtree.utils")

local supported_providers = {
  "java",
  "kt",
}

function M.supports_current_buffer()
  local extension = utils.get_file_extension()
  if extension == nil or extension == "" then
    return false
  end

  local provider_supported = utils.set_contains(supported_providers, extension)
  if not provider_supported then
    return false
  end

  -- check if active buffer contains @Test annotation for java and kt
  -- add support for other languages later on
  local containsTest = utils.buffer_contains("@Test")
  local containsParameterizedTest = utils.buffer_contains("@ParameterizedTest")
  local containsRepeatedTest = utils.buffer_contains("@RepeatedTest")
  local containsTestFactory = utils.buffer_contains("@TestFactory")

  if containsTest or containsParameterizedTest or containsRepeatedTest or containsTestFactory then
    return true
  end
  return false
end

function M.get()
  local extension = utils.get_file_extension()
  return require("testtree.providers." .. extension)
end

function M.get_active_language()
  local extension = utils.get_file_extension()
  if extension == "java" then
    return extension
  elseif extension == "kt" then
    return "kotlin"
  end
  return ""
end

return M
