-- test tree
return {
  dir = "~/.config/nvim/lua/testtree.nvim",
  name = "testtree.nvim",
  dependencies = {
    "stevearc/overseer.nvim",
  },
  config = function()
    require("testtree").setup({
      width_ratio = 0.25,
      mappings = {
        toggle = "<leader>tvt",
        focus = "<leader>tvf",
        open = "<leader>tvo",
        close = "<leader>tvc",
      },
    })
  end,
}
