return {
  {
    "afonsofrancof/worktrees.nvim",
    event = "VeryLazy",
    opts = {
      -- Specify where to create worktrees relative to git common dir
      -- The common dir is the .git dir in a normal repo or the root dir of a bare repo
      base_path = "../..", -- worktrees outside the repo

      -- Template for worktree folder names (string or function(branch) -> path)
      -- This is only used if you don't specify the folder name when creating the worktree
      -- path_template = "{branch}", -- Default: use branch name
      path_template = function(branch)
        -- Get the absolute path to the Git common directory.
        -- This points to the shared Git directory used by all worktrees.
        local main_dir = vim.fn.systemlist("git rev-parse --path-format=absolute --git-common-dir")[1]

        -- Get the parent directory of the Git common directory.
        -- This gives us the main/master repository's root directory.
        main_dir = vim.fn.fnamemodify(main_dir, ":h")

        -- Extract only the name of the main repository directory.
        local main_dir_name = vim.fn.fnamemodify(main_dir, ":t")

        -- Replace every forward slash in the branch name with a hyphen.
        -- For example: feature/auth -> feature-auth
        local branch_name = branch:gsub("/", "-")

        -- Combine the main repository directory name and sanitized branch name.
        -- For example: my-app + feature-auth -> my-app-feature-auth
        return main_dir_name .. "-" .. branch_name
      end,
      --
      -- Command names (optional)
      commands = {
        create = "WorktreeCreate",
        delete = "WorktreeDelete",
        switch = "WorktreeSwitch",
      },

      -- Key mappings for interactive UI (optional)
      mappings = {
        create = "<leader>gwc",
        delete = "<leader>gwd",
        switch = "<leader>gws",
      },

      -- Lifecycle hooks (optional)
      on_create = function(path) end,
      on_delete = function(path) end,
      on_switch = function(from_path, to_path) end,
    },
  },
}
