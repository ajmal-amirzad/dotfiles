-- snacks.nvim
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true,
        },
        files = {
          hidden = true,
          ignored = true,
          exclude = { "bin", "build", "*.class" },
        },
        grep = {
          exclude = { "bin", "build" },
        },
      },
      win = {
        input = {
          keys = {
            ["<a-w>"] = false,
            ["<c-l>"] = { "cycle_win", mode = { "n", "i" } },
            ["<c-h>"] = { "cycle_win", mode = { "n", "i" } },
          },
        },
        list = {
          keys = {
            ["<a-w>"] = false,
            ["<c-l>"] = { "cycle_win", mode = { "n", "i" } },
            ["<c-h>"] = { "cycle_win", mode = { "n", "i" } },
          },
        },
        preview = {
          keys = {
            ["<a-w>"] = false,
            ["<c-l>"] = { "cycle_win", mode = { "n", "i" } },
            ["<c-h>"] = { "cycle_win", mode = { "n", "i" } },
          },
        },
      },
    },
    terminal = {
      win = {
        position = "float",
        border = "rounded",
        width = 0.85,
        height = 0.85,
        backdrop = 60,
        zindex = 50,
      },
    },
    dashboard = {
      preset = {
        header = [[

███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

                               - YOUR IDE's IDE. -
]],
      },
    },
  },
}
