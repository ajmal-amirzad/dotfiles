-- snacks.nvim

local to_preview = {
  input = { keys = { ["<c-l>"] = { "focus_preview", mode = { "n", "i" } } } },
  list = { keys = { ["<c-l>"] = { "focus_preview", mode = { "n", "i" } } } },
  preview = { keys = { ["<c-h>"] = { "focus_input", mode = { "n", "i" } } } },
}

return {
  "folke/snacks.nvim",
  init = function()
    local function set_dashboard_color()
      local colors = {
        header = "#858585",
        title = "#A0A0A0",
        desc = "#808080",
        key = "#ffffff",
        icon = "#ffffff",
        footer = "#707070",
        dir = "#888888",
        file = "#A0A0A0",
      }

      local function set_dashboard_highlights()
        for name, color in pairs(colors) do
          vim.api.nvim_set_hl(0, "SnacksDashboard" .. name:sub(1, 1):upper() .. name:sub(2), {
            fg = color,
          })
        end
      end

      set_dashboard_highlights()

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_dashboard_highlights,
      })
      vim.api.nvim_set_hl(0, "SnacksDashboardSpecial", { fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#ffffff" })
    end

    -- Apply now and whenever the colorscheme changes.
    set_dashboard_color()

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = set_dashboard_color,
    })
  end,
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          exclude = {
            "__pycache__",
            "*.pyc",
          },
        },
        notifications = {
          win = to_preview,
        },
        files = {
          hidden = true,
          ignored = true,
          exclude = {
            "bin",
            "gradle",
            ".gradle",
            ".idea",
            "*.class",
            "gradlew.bat",
            "gradlew",
            ".DS_Store",
            "*.zip",
            "*.tar",
            "*.bat",
            "*.bin",
            "*.jar",
            "*.kotlin_module",
            "build/kotlin/compileKotlin",
          },
          win = to_preview,
        },
        grep = {
          hidden = true,
          ignored = true,
          exclude = {
            "bin",
            "gradle",
            ".gradle",
            ".idea",
            "gradlew.bat",
            "gradlew",
            "*.bin",
            "*.class",
            "*.kotlin_module",
            "*.jar",
            "*.war",
            "*.ear",
            "*.so",
            "*.dll",
            "*.dylib",
            "*.exe",
            "*.pyc",
            "*.pyo",
            "*.png",
            "*.jpg",
            "*.jpeg",
            "*.gif",
            "*.ico",
            "*.webp",
            "*.pdf",
            "*.docx",
            "*.xlsx",
            "*.zip",
            "*.tar",
            "*.gz",
            "*.7z",
            "*.db",
            "*.sqlite",
            "*.sqlite3",
            "*.tmp",
            "*.swp",
            "*.swo",
            "*.bak",
            ".DS_Store",
          },
          win = to_preview,
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
