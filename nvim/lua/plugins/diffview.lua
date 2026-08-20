-- diff view for git merge conflicts

local function key_bindings_for_diff(diff)
  return {
    { "n", "g?", require("diffview.actions").help({ "view", diff }), { desc = "Open help panel" } },
    {
      { "n", "x" },
      "<localleader>do",
      require("diffview.actions").diffget("ours"),
      { desc = "Diff Hunk - choose ours" },
    },
    {
      { "n", "x" },
      "<localleader>dt",
      require("diffview.actions").diffget("theirs"),
      { desc = "Diff Hunk - choose theirs" },
    },
    {
      { "n", "x" },
      "<localleader>db",
      require("diffview.actions").diffget("base"),
      { desc = "Diff Hunk - choose base" },
    },
    {
      "n",
      "<localleader>pc",
      require("diffview.actions").prev_conflict,
      { desc = "Conflict - previous conflict" },
    },
    { "n", "<localleader>nc", require("diffview.actions").next_conflict, { desc = "Conflict - next conflict" } },
    {
      "n",
      "<localleader>nf",
      require("diffview.actions").select_next_entry,
      { desc = "Diff - next file" },
    },
    {
      "n",
      "<localleader>pf",
      require("diffview.actions").select_prev_entry,
      { desc = "Diff - previous file" },
    },
    { "n", "<localleader>f", require("diffview.actions").select_first_entry, { desc = "Diff - first file" } },
    { "n", "<localleader>F", require("diffview.actions").select_last_entry, { desc = "Diff - last file" } },
  }
end

return {
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>gvd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    { "<leader>gvD", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    { "<leader>gvh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current file)" },
    { "<leader>gvH", "<cmd>DiffviewFileHistory<cr>", desc = "File History (current branch)" },
  },

  config = function()
    require("diffview").setup({
      view = {
        -- Configure the layout and behavior of different types of views.
        -- Available layouts:
        --  'diff1_plain'
        --    |'diff2_horizontal'
        --    |'diff2_vertical'
        --    |'diff3_horizontal'
        --    |'diff3_vertical'
        --    |'diff3_mixed'
        --    |'diff4_mixed'
        -- For more info, see |diffview-config-view.x.layout|.
        default = {
          -- Config for changed files, and staged files in diff views.
          layout = "diff2_horizontal",
          disable_diagnostics = false, -- Temporarily disable diagnostics for diff buffers while in the view.
          winbar_info = false, -- See |diffview-config-view.x.winbar_info|
        },
        merge_tool = {
          layout = "diff3_horizontal",
          winbar_info = true, -- Keep true so Diffview initializes the winbar
        },
        file_history = {
          -- Config for changed files in file history views.
          layout = "diff2_horizontal",
          disable_diagnostics = false, -- Temporarily disable diagnostics for diff buffers while in the view.
          winbar_info = true, -- See |diffview-config-view.x.winbar_info|
        },
      },
      hooks = {
        diff_buf_win_enter = function(bufnr, winid, ctx)
          -- refresh which-key's cache for this buffer once diffview has set its keymaps
          vim.schedule(function()
            pcall(function()
              require("which-key.buf").clear({ buf = bufnr })
            end)
          end)

          if not (ctx.layout_name:match("^diff3_") or ctx.layout_name:match("^diff4_")) then
            return
          end

          -- In diff3/diff4 layouts, ctx.symbol identifies the pane:
          -- "a" = OURS (left/top-left)
          -- "b" = LOCAL (center/bottom)
          -- "c" = THEIRS (right/top-right)
          -- "d" = BASE (diff4 only)
          local labels = {
            a = "OURS (Current)",
            b = "LOCAL (Working Tree)",
            c = "THEIRS (Incoming)",
            d = "BASE (Common Ancestor)",
          }

          local title = labels[ctx.symbol]
          if not title then
            return
          end

          vim.schedule(function()
            if vim.api.nvim_win_is_valid(winid) then
              vim.wo[winid].winbar = "%#DiffviewWinbar# " .. title .. " %*"
            end
          end)
        end,
      },
      keymaps = {
        disable_defaults = true, -- Disable the default keymaps
        view = {
          {
            "n",
            "<localleader>nf",
            require("diffview.actions").select_next_entry,
            { desc = "Diff - next file" },
          },
          {
            "n",
            "<localleader>pf",
            require("diffview.actions").select_prev_entry,
            { desc = "Diff - previous file" },
          },
          { "n", " <localleader>f", require("diffview.actions").select_first_entry, { desc = "Diff - first file" } },
          { "n", "<localleader>F", require("diffview.actions").select_last_entry, { desc = "Diff - last file" } },
          { "n", "gf", require("diffview.actions").goto_file_edit, { desc = "Open file in previous tabpage" } },
          { "n", "<C-w><C-f>", require("diffview.actions").goto_file_split, { desc = "Open file in new split" } },
          { "n", "<C-w>gf", require("diffview.actions").goto_file_tab, { desc = "Open the file in new tabpage" } },
          { "n", "<localleader>e", require("diffview.actions").focus_files, { desc = "File Panel" } },
          { "n", "<localleader>b", require("diffview.actions").toggle_files, { desc = "Toggle File Panel" } },
          { "n", "g<C-x>", require("diffview.actions").cycle_layout, { desc = "Cycle through available layouts" } },
          {
            "n",
            "<localleader>pc",
            require("diffview.actions").prev_conflict,
            { desc = "Conflict - previous conflict" },
          },
          { "n", "<localleader>nc", require("diffview.actions").next_conflict, { desc = "Conflict - next conflict" } },
          {
            "n",
            "<localleader>co",
            require("diffview.actions").conflict_choose("ours"),
            { desc = "Conflict - choose ours (hunk)" },
          },
          {
            "n",
            "<localleader>ct",
            require("diffview.actions").conflict_choose("theirs"),
            { desc = "Conflict - choose theirs (hunk)" },
          },
          {
            "n",
            "<localleader>cb",
            require("diffview.actions").conflict_choose("base"),
            { desc = "Conflict - choose base (hunk)" },
          },
          {
            "n",
            "<localleader>ca",
            require("diffview.actions").conflict_choose("all"),
            { desc = "Conflict - choose both (hunk)" },
          },
          {
            "n",
            "<localleader>cn",
            require("diffview.actions").conflict_choose("none"),
            { desc = "Conflict - delete conflict (hunk)" },
          },
          {
            "n",
            "<localleader>cO",
            require("diffview.actions").conflict_choose_all("ours"),
            { desc = "Conflict - choose ours (file)" },
          },
          {
            "n",
            "<localleader>cT",
            require("diffview.actions").conflict_choose_all("theirs"),
            { desc = "Conflict - choose theirs (file)" },
          },
          {
            "n",
            "<localleader>cB",
            require("diffview.actions").conflict_choose_all("base"),
            { desc = "Conflict - choose base (file)" },
          },
          {
            "n",
            "<localleader>cA",
            require("diffview.actions").conflict_choose_all("all"),
            { desc = "Conflict - choose both (file)" },
          },
          {
            "n",
            "<localleader>cN",
            require("diffview.actions").conflict_choose_all("none"),
            { desc = "Conflict - delete conflict (file)" },
          },
          {
            { "n", "x" },
            "<localleader>do",
            require("diffview.actions").diffget("ours"),
            { desc = "Diff Hunk - choose ours" },
          },
          {
            { "n", "x" },
            "<localleader>dt",
            require("diffview.actions").diffget("theirs"),
            { desc = "Diff Hunk - choose theirs" },
          },
          {
            { "n", "x" },
            "<localleader>db",
            require("diffview.actions").diffget("base"),
            { desc = "Diff Hunk - choose base" },
          },
        },
        diff1 = key_bindings_for_diff("diff1"),
        diff2 = key_bindings_for_diff("diff2"),
        diff3 = key_bindings_for_diff("diff3"),
        diff4 = key_bindings_for_diff("diff4"),
        file_panel = {
          { "n", "j", require("diffview.actions").next_entry, { desc = "next file entry" } },
          { "n", "<down>", require("diffview.actions").next_entry, { desc = "next file entry" } },
          { "n", "k", require("diffview.actions").prev_entry, { desc = "previous file entry" } },
          { "n", "<up>", require("diffview.actions").prev_entry, { desc = "previous file entry" } },
          { "n", "<cr>", require("diffview.actions").select_entry, { desc = "Open diff for selected" } },
          { "n", "o", require("diffview.actions").select_entry, { desc = "Open diff for selected" } },
          { "n", "l", require("diffview.actions").select_entry, { desc = "Open diff for selected" } },
          { "n", "<2-LeftMouse>", require("diffview.actions").select_entry, { desc = "Open diff for selected" } },
          { "n", "-", require("diffview.actions").toggle_stage_entry, { desc = "Stage / unstage selected" } },
          { "n", "s", require("diffview.actions").toggle_stage_entry, { desc = "Stage / unstage selected" } },
          { "n", "S", require("diffview.actions").stage_all, { desc = "Stage all entries" } },
          { "n", "U", require("diffview.actions").unstage_all, { desc = "Unstage all entries" } },
          { "n", "X", require("diffview.actions").restore_entry, { desc = "Restore entry to state on left side" } },
          { "n", "L", require("diffview.actions").open_commit_log, { desc = "Open commit log panel" } },
          { "n", "zo", require("diffview.actions").open_fold, { desc = "Expand fold" } },
          { "n", "h", require("diffview.actions").close_fold, { desc = "Collapse fold" } },
          { "n", "zc", require("diffview.actions").close_fold, { desc = "Collapse fold" } },
          { "n", "za", require("diffview.actions").toggle_fold, { desc = "Toggle fold" } },
          { "n", "zR", require("diffview.actions").open_all_folds, { desc = "Expand all folds" } },
          { "n", "zM", require("diffview.actions").close_all_folds, { desc = "Collapse all folds" } },
          { "n", "<c-b>", require("diffview.actions").scroll_view(-0.25), { desc = "Scroll view up" } },
          { "n", "<c-f>", require("diffview.actions").scroll_view(0.25), { desc = "Scroll view down" } },
          {
            "n",
            "<localleader>nf",
            require("diffview.actions").select_next_entry,
            { desc = "Diff - next file" },
          },
          {
            "n",
            "<localleader>pf",
            require("diffview.actions").select_prev_entry,
            { desc = "Diff - previous file" },
          },
          { "n", "<localleader>f", require("diffview.actions").select_first_entry, { desc = "Diff - first file" } },
          { "n", "<localleader>F", require("diffview.actions").select_last_entry, { desc = "Diff - last file" } },
          { "n", "gf", require("diffview.actions").goto_file_edit, { desc = "Open file in previous tabpage" } },
          { "n", "<C-w><C-f>", require("diffview.actions").goto_file_split, { desc = "Open file in new split" } },
          { "n", "<C-w>gf", require("diffview.actions").goto_file_tab, { desc = "Open file in new tabpage" } },
          {
            "n",
            "i",
            require("diffview.actions").listing_style,
            { desc = "Toggle between 'list' and 'tree' views" },
          },
          {
            "n",
            "f",
            require("diffview.actions").toggle_flatten_dirs,
            { desc = "Flatten empty subdirectories in tree listing style" },
          },
          {
            "n",
            "R",
            require("diffview.actions").refresh_files,
            { desc = "Update stats and entries in file list" },
          },
          { "n", "<localleader>e", require("diffview.actions").focus_files, { desc = "File panel" } },
          { "n", "<localleader>b", require("diffview.actions").toggle_files, { desc = "Toggle File Panel" } },
          { "n", "g<C-x>", require("diffview.actions").cycle_layout, { desc = "Cycle available layouts" } },
          {
            "n",
            "<localleader>pc",
            require("diffview.actions").prev_conflict,
            { desc = "Conflict - previous conflict" },
          },
          { "n", "<localleader>nc", require("diffview.actions").next_conflict, { desc = "Conflict - next conflict" } },
          { "n", "g?", require("diffview.actions").help("file_panel"), { desc = "Open help panel" } },
          {
            "n",
            "<localleader>cO",
            require("diffview.actions").conflict_choose_all("ours"),
            { desc = "Conflict - choose ours (file)" },
          },
          {
            "n",
            "<localleader>cT",
            require("diffview.actions").conflict_choose_all("theirs"),
            { desc = "Conflict - choose theirs (file)" },
          },
          {
            "n",
            "<localleader>cB",
            require("diffview.actions").conflict_choose_all("base"),
            { desc = "Conflict - choose base (file)" },
          },
          {
            "n",
            "<localleader>cA",
            require("diffview.actions").conflict_choose_all("all"),
            { desc = "Conflict - choose both (file)" },
          },
          {
            "n",
            "<localleader>cN",
            require("diffview.actions").conflict_choose_all("none"),
            { desc = "Conflict - delete conflict (file)" },
          },
        },
        file_history_panel = {
          { "n", "g!", require("diffview.actions").options, { desc = "Open option panel" } },
          {
            "n",
            "<C-A-d>",
            require("diffview.actions").open_in_diffview,
            { desc = "Open entry under cursor in a diffview" },
          },
          { "n", "y", require("diffview.actions").copy_hash, { desc = "Copy commit hash of entry under cursor" } },
          { "n", "L", require("diffview.actions").open_commit_log, { desc = "Show commit details" } },
          {
            "n",
            "X",
            require("diffview.actions").restore_entry,
            { desc = "Restore file to state from selected entry" },
          },
          { "n", "zo", require("diffview.actions").open_fold, { desc = "Expand fold" } },
          { "n", "zc", require("diffview.actions").close_fold, { desc = "Collapse fold" } },
          { "n", "h", require("diffview.actions").close_fold, { desc = "Collapse fold" } },
          { "n", "za", require("diffview.actions").toggle_fold, { desc = "Toggle fold" } },
          { "n", "zR", require("diffview.actions").open_all_folds, { desc = "Expand all folds" } },
          { "n", "zM", require("diffview.actions").close_all_folds, { desc = "Collapse all folds" } },
          { "n", "j", require("diffview.actions").next_entry, { desc = "Bring cursor to next file entry" } },
          { "n", "<down>", require("diffview.actions").next_entry, { desc = "Bring cursor to next file entry" } },
          { "n", "k", require("diffview.actions").prev_entry, { desc = "Bring cursor to previous file entry" } },
          { "n", "<up>", require("diffview.actions").prev_entry, { desc = "Bring cursor to previous file entry" } },
          { "n", "<cr>", require("diffview.actions").select_entry, { desc = "Open diff for selected entry" } },
          { "n", "o", require("diffview.actions").select_entry, { desc = "Open diff for selected entry" } },
          { "n", "l", require("diffview.actions").select_entry, { desc = "Open diff for selected entry" } },
          {
            "n",
            "<2-LeftMouse>",
            require("diffview.actions").select_entry,
            { desc = "Open diff for selected entry" },
          },
          { "n", "<c-b>", require("diffview.actions").scroll_view(-0.25), { desc = "Scroll view up" } },
          { "n", "<c-f>", require("diffview.actions").scroll_view(0.25), { desc = "Scroll view down" } },
          {
            "n",
            "<localleader>nf",
            require("diffview.actions").select_next_entry,
            { desc = "Diff - next file" },
          },
          {
            "n",
            "<localleader>pf",
            require("diffview.actions").select_prev_entry,
            { desc = "Diff - previous file" },
          },
          { "n", "<localleader>f", require("diffview.actions").select_first_entry, { desc = "Diff - first file" } },
          { "n", "<localleader>F", require("diffview.actions").select_last_entry, { desc = "Diff - last file" } },
          { "n", "gf", require("diffview.actions").goto_file_edit, { desc = "Open file in previous tabpage" } },
          { "n", "<C-w><C-f>", require("diffview.actions").goto_file_split, { desc = "Open file in new split" } },
          { "n", "<C-w>gf", require("diffview.actions").goto_file_tab, { desc = "Open file in new tabpage" } },
          { "n", "<localleader>e", require("diffview.actions").focus_files, { desc = "File Panel" } },
          { "n", "<localleader>b", require("diffview.actions").toggle_files, { desc = "Toggle File Panel" } },
          { "n", "g<C-x>", require("diffview.actions").cycle_layout, { desc = "Cycle available layouts" } },
          { "n", "g?", require("diffview.actions").help("file_history_panel"), { desc = "Open help panel" } },
        },
        option_panel = {
          { "n", "<tab>", require("diffview.actions").select_entry, { desc = "Change current option" } },
          { "n", "q", require("diffview.actions").close, { desc = "Close panel" } },
          { "n", "g?", require("diffview.actions").help("option_panel"), { desc = "Open help panel" } },
        },
        help_panel = {
          { "n", "q", require("diffview.actions").close, { desc = "Close help menu" } },
          { "n", "<esc>", require("diffview.actions").close, { desc = "Close help menu" } },
        },
      },
    })
  end,
}
