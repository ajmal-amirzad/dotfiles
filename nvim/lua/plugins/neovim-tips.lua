-- neovim tips
return {
  "saxon1964/neovim-tips",
  version = "*", -- Only update on tagged releases
  lazy = false, -- Load on startup for daily tip
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "MeanderingProgrammer/render-markdown.nvim", -- Clean rendering
    "OXY2DEV/markview.nvim", -- Rich rendering with advanced features
  },
  opts = {
    daily_tip = 1, -- 0 = off, 1 = once per day, 2 = every startup
    bookmark_symbol = "󱍻 ",
  },
}
