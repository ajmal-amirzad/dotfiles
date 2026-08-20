local M = {}

function M.apply(adapter)
  -- Only allow Java files to be discovered.
  local original_is_test_file = adapter.is_test_file

  adapter.is_test_file = function(file_path)
    if not tostring(file_path):match("%.java$") then
      return false
    end

    return original_is_test_file(file_path)
  end

  return adapter
end

return M
