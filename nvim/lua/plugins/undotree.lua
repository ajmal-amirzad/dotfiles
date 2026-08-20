-- undo history visualizer
return {
  "mbbill/undotree",
  keys = {
    { "<leader>fu", vim.cmd.UndotreeToggle, desc = "UndoTree" },
  },
  config = function()
    vim.opt.undofile = true
    vim.g.undotree_SplitWidth = 40
  end,
}
