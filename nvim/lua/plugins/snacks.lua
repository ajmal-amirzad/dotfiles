-- snacks.nvim
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      -- focus = "list",
      sources = {
        files = {
          exclude = { "bin", "build" },
        },
        grep = {
          exclude = { "bin", "build" },
        },
      },
    },
  },
}
