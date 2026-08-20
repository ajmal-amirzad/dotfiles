local M = {}

function M.apply()
  M.patch_command()
  M.patch_output_parser()
end

-- Workaround: neotest-kotlin does not pass the selected spec
-- to Gradle's native --tests filter.
--
-- This ensures Gradle executes only the selected test class.
-- Remove this patch if upstream adds native Gradle filtering.
function M.patch_command()
  local ok, command = pcall(require, "neotest-kotlin.command")

  if not ok or command._gradle_filter_patched then
    return
  end

  command._gradle_filter_patched = true

  local original_build = command.build

  command.build = function(tests, specs, outfile)
    local cmd = original_build(tests, specs, outfile)

    local marker = " --console=plain"
    local position = cmd:find(marker, 1, true)

    if not position then
      vim.notify("neotest-kotlin: unable to inject Gradle --tests", vim.log.levels.WARN)
      return cmd
    end

    local filter = " --tests " .. vim.fn.shellescape(specs)

    return cmd:sub(1, position - 1) .. filter .. cmd:sub(position)
  end
end

-- Workaround: neotest-kotlin shows passing tests as failed (red cross)
-- Why: neotest-kotlin builds results by parsing Gradle's console output,
-- and it assumes two things that are no longer true for our setup
-- (Gradle 9.4.0):
--   1. Lines start with the fully qualified class name
--      ("com.x.MainTest > test() PASSED"), but Gradle now prints the
--      short name ("MainTest > test() PASSED"), so every line is ignored.
--   2. JUnit method names are kept as printed, "thirdTest()", while the
--      neotest tree IDs are "thirdTest". The IDs don't match, so results
--      never attach to the right test.
--
-- We patch the plugin's functions here instead of editing its files, so
-- the plugin can still be updated. Remove this block once upstream
-- (codymikol/neotest-kotlin) fixes it. If the red crosses come back after
-- a plugin update, check that these function names still exist.
function M.patch_output_parser()
  local ok, parser = pcall(require, "neotest-kotlin.output_parser")

  if not ok or parser._patched then
    return
  end

  parser._patched = true

  -- Register short class names.
  local original_classes = parser.determine_all_classes

  parser.determine_all_classes = function(path)
    local res = original_classes(path)
    local extra = {}

    for fq, file in pairs(res) do
      local short = fq:match("([^.]+)$")

      if short and res[short] == nil then
        extra[short] = file
      end
    end

    return vim.tbl_extend("keep", res, extra)
  end

  -- Normalize JUnit method names.
  local original_id = parser.parse_test_id

  parser.parse_test_id = function(line, class_to_path)
    local id = original_id(line, class_to_path)

    if id then
      local head, method = id:match("^(.*)::([^:]-)%(%)$")

      if method then
        id = head .. "::" .. (method:find(" ") and ("`" .. method .. "`") or method)
      end
    end

    return id
  end
end

return M
