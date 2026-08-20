local function find_root()
  return vim.fs.root(0, {
    "gradlew",
  })
end

local function discover_tasks(root, callback)
  local command = [[
    {
      ./gradlew tasks --all -q \
        | grep -E '^[a-zA-Z0-9_-]+ - ' \
        | cut -d' ' -f1

      ./gradlew projects -q \
        | grep "Project ':" \
        | sed -E "s/.*Project '(:[^']+)'.*/\1/" \
        | while read mod; do
          ./gradlew "${mod}:tasks" --all -q \
            | grep -E '^[a-zA-Z0-9_-]+ - ' \
            | cut -d' ' -f1 \
            | sed "s|^|${mod#:}:|"
        done
    }
  ]]

  vim.system({ "bash", "-c", command }, {
    cwd = root,
    text = true,
  }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        callback(nil, result.stderr or "Gradle task discovery failed")
        return
      end

      local tasks = {}

      for line in (result.stdout or ""):gmatch("[^\r\n]+") do
        line = vim.trim(line)

        if line ~= "" then
          table.insert(tasks, line)
        end
      end

      callback(tasks, nil)
    end)
  end)
end

return {
  name = "Gradle",

  condition = {
    callback = function()
      if vim.bo.filetype == "lazy" then
        return false
      end

      if vim.bo.buftype ~= "" then
        return false
      end

      return find_root() ~= nil
    end,
  },

  -- Cache the generated templates for this Gradle project.
  cache_key = function(opts)
    return find_root()
  end,

  generator = function(_, callback)
    local root = find_root()

    if not root then
      callback({})
      return
    end

    discover_tasks(root, function(tasks, err)
      if err then
        callback(err)
        return
      end

      local templates = {}

      for _, task in ipairs(tasks) do
        table.insert(templates, {
          name = "Gradle: " .. task,

          builder = function()
            return {
              cmd = { "./gradlew" },
              args = { task },
              cwd = root,
              components = {
                "default",
                "open_output",
              },
            }
          end,
        })
      end

      callback(templates)
    end)
  end,
}
