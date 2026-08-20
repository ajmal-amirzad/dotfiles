-- move lines and blocks
return {
  "nvim-mini/mini.move",
  event = "VeryLazy",
  opts = {
    mappings = {
      left = "mh",
      right = "ml",
      down = "mj",
      up = "mk",

      line_left = "mh",
      line_right = "ml",
      line_down = "mj",
      line_up = "mk",
    },
    options = {
      reindent_linewise = true,
    },
  },
}
