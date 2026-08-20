-- hightlight word under cursor
return {
  "nvim-mini/mini.cursorword",
  config = function()
    require("mini.cursorword").setup()
  end,
}
