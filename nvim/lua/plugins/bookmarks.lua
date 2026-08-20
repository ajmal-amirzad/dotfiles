return {
  "LintaoAmons/bookmarks.nvim",
  branch = "main",
  lazy = false,
  dependencies = {
    { "kkharji/sqlite.lua" },
    { "folke/snacks.nvim" },
  },
  opts = {
    picker = {
      picker_backend = "snacks",
    },
  },
  config = function(_, opts)
    require("bookmarks").setup(opts)
  end,
  keys = {
    { "<leader>mm", "<cmd>BookmarksMark<cr>", mode = { "n", "v" }, desc = "Bookmark: mark/rename/delete" },
    { "<leader>mo", "<cmd>BookmarksGoto<cr>", mode = { "n", "v" }, desc = "Bookmark: goto" },
    { "<leader>ma", "<cmd>BookmarksCommands<cr>", mode = { "n", "v" }, desc = "Bookmark: commands" },
    { "<leader>md", "<cmd>BookmarksDesc<cr>", mode = { "n", "v" }, desc = "Bookmark: description" },
    { "<leader>ml", "<cmd>BookmarksLists<cr>", mode = { "n", "v" }, desc = "Bookmark: lists" },
    { "<leader>mg", "<cmd>BookmarksGrep<cr>", desc = "Bookmark: grep" },
    { "<leader>mp", "<cmd>BookmarksGotoPrev<cr>", desc = "Bookmark: previous" },
    { "<leader>mn", "<cmd>BookmarksGotoNext<cr>", desc = "Bookmark: next" },
  },
}
