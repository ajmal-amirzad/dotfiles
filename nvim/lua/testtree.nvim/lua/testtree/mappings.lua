local M = {}

local controller = require("testtree.controller")

function M.apply_mappings(mappings)
  vim.keymap.set("n", mappings.toggle, function()
    controller.toggle()
  end, { desc = "Toggle TestTree" })

  vim.keymap.set("n", mappings.focus, function()
    controller.focus()
  end, { desc = "Focus TestTree" })

  vim.keymap.set("n", mappings.open, function()
    controller.open()
  end, { desc = "Open TestTree" })

  vim.keymap.set("n", mappings.close, function()
    controller.close()
  end, { desc = "Close TestTree" })
end

function M.apply_nav_mappings(buf)
  vim.keymap.set("n", "j", function()
    controller.move(1)
  end, { buffer = buf })

  vim.keymap.set("n", "k", function()
    controller.move(-1)
  end, { buffer = buf })

  vim.keymap.set("n", "<Down>", function()
    controller.move(1)
  end, { buffer = buf })

  vim.keymap.set("n", "<Up>", function()
    controller.move(-1)
  end, { buffer = buf })

  vim.keymap.set("n", "<CR>", function()
    controller.toggle_fold()
  end, { buffer = buf })

  vim.keymap.set("n", "r", function()
    controller.run_test()
  end, { buffer = buf })

  vim.keymap.set("n", "q", function()
    require("testtree.view").close()
  end, { buffer = buf })

  vim.keymap.set("n", "<Escape>", function()
    require("testtree.view").close()
  end, { buffer = buf })
end

return M
