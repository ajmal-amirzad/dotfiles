-- snacks.nvim
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      -- focus = "list",
      sources = {
        explorer = {
          hidden = true,
        },
        files = {
          exclude = { "bin", "build" },
        },
        grep = {
          exclude = { "bin", "build" },
        },
      },
    },
    terminal = {
      win = {
        position = "float",
        border = "rounded",
        width = 0.85,
        height = 0.75,
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
