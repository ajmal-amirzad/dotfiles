return {
  "isakbm/gitgraph.nvim",
  opts = {
    git_cmd = "git",
    symbols = {
      merge_commit = "",
      merge_commit_end = "",
      commit = "",
      commit_end = "",
    },
    format = {
      timestamp = "%H:%M:%S %d-%m-%Y",
      fields = { "hash", "timestamp", "author", "branch_name", "tag" },
    },
    hooks = {
      on_select_commit = function(commit)
        vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
      end,
    },
  },
  keys = {
    {
      "<leader>gvz",
      function()
        require("gitgraph").draw({}, { all = true, max_count = 5000 })
      end,
      desc = "GitGraph",
    },
  },
}
