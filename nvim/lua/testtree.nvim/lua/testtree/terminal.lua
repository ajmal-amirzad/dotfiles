local M = {}

function M.run(cmd)
  local overseer = require("overseer")

  local task = overseer.new_task({
    cmd = cmd,
    name = cmd,
    components = {
      "default",
      "open_output",
    },
  })

  task:start()
end

return M
