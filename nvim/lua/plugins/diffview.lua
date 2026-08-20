-- diff view for git merge conflicts

return {
  "sindrets/diffview.nvim",
  lazy = false,
  keys = {
    { "<leader>gvd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    { "<leader>gvD", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    { "<leader>gvh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview History (current file)" },
    { "<leader>gvH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview History (current branch)" },
    { "<leader>gvs", "<cmd>DiffviewFileHistory -g --range=stash<cr>", desc = "Diffview Stash" },
  },
  config = function()
    local actions = require("diffview.actions")

    local open_file_in_previous_tabpage = {
      "n",
      "gf",
      actions.goto_file_edit,
      { desc = "Open file in previous tabpage" },
    }

    local diff_hunk_choose_ours = {
      { "n", "x" },
      "<localleader>do",
      actions.diffget("ours"),
      { desc = "Diff Hunk - choose ours" },
    }

    local diff_hunk_choose_theirs = {
      { "n", "x" },
      "<localleader>dt",
      actions.diffget("theirs"),
      { desc = "Diff Hunk - choose theirs" },
    }

    local diff_hunk_choose_base = {
      { "n", "x" },
      "<localleader>db",
      actions.diffget("base"),
      { desc = "Diff Hunk - choose base" },
    }

    local restore_entry = {
      { "n", "x" },
      "<localleader>x",
      actions.restore_entry,
      { desc = "Restore Left Side" },
    }

    local conflict_prev_conflict = {
      { "n", "x" },
      "<localleader>pc",
      actions.prev_conflict,
      { desc = "Conflict - previous conflict" },
    }

    local conflict_next_conflict = {
      { "n", "x" },
      "<localleader>nc",
      actions.next_conflict,
      { desc = "Conflict - next conflict" },
    }

    local select_next_file = {
      { "n", "x" },
      "<localleader>nf",
      actions.select_next_entry,
      { desc = "Diff - next file" },
    }

    local select_prev_file = {
      { "n", "x" },
      "<localleader>pf",
      actions.select_prev_entry,
      { desc = "Diff - previous file" },
    }

    local select_first_file = {
      { "n", "x" },
      "<localleader>f",
      actions.select_first_entry,
      { desc = "Diff - first file" },
    }

    local select_last_file = {
      { "n", "x" },
      "<localleader>F",
      actions.select_last_entry,
      { desc = "Diff - last file" },
    }

    local focus_files_panel = {
      { "n", "x" },
      "<localleader>e",
      actions.focus_files,
      { desc = "File Panel" },
    }

    local toggle_files_panel = {
      { "n", "x" },
      "<localleader>b",
      actions.toggle_files,
      { desc = "Toggle File Panel" },
    }

    local conflict_choose_ours = {
      "n",
      "<localleader>co",
      actions.conflict_choose("ours"),
      { desc = "Conflict - choose ours (hunk)" },
    }

    local conflict_choose_theirs = {
      "n",
      "<localleader>ct",
      actions.conflict_choose("theirs"),
      { desc = "Conflict - choose theirs (hunk)" },
    }

    local conflict_choose_base = {
      "n",
      "<localleader>cb",
      actions.conflict_choose("base"),
      { desc = "Conflict - choose base (hunk)" },
    }

    local conflict_choose_all = {
      "n",
      "<localleader>ca",
      actions.conflict_choose("all"),
      { desc = "Conflict - choose both (hunk)" },
    }

    local conflict_choose_none = {
      "n",
      "<localleader>cn",
      actions.conflict_choose("none"),
      { desc = "Conflict - delete conflict (hunk)" },
    }

    local conflict_choose_all_ours = {
      "n",
      "<localleader>cO",
      actions.conflict_choose_all("ours"),
      { desc = "Conflict - choose ours (file)" },
    }

    local conflict_choose_all_theirs = {
      "n",
      "<localleader>cT",
      actions.conflict_choose_all("theirs"),
      { desc = "Conflict - choose theirs (file)" },
    }

    local conflict_choose_all_base = {
      "n",
      "<localleader>cB",
      actions.conflict_choose_all("base"),
      { desc = "Conflict - choose base (file)" },
    }

    local conflict_choose_all_all = {
      "n",
      "<localleader>cA",
      actions.conflict_choose_all("all"),
      { desc = "Conflict - choose both (file)" },
    }

    local conflict_choose_all_none = {
      "n",
      "<localleader>cN",
      actions.conflict_choose_all("none"),
      { desc = "Conflict - delete conflict (file)" },
    }

    local open_file_in_new_split = { "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Open file in new split" } }

    local open_file_in_new_tabpage = {
      "n",
      "<C-w>gf",
      actions.goto_file_tab,
      { desc = "Open the file in new tabpage" },
    }

    local scroll_view_up = { "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll view up" } }

    local scroll_view_down = { "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll view down" } }

    local cycle_available_layouts = { "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle available layouts" } }

    local open_commit_log = { "n", "L", actions.open_commit_log, { desc = "Open commit log panel" } }

    local expand_fold = { "n", "zo", actions.open_fold, { desc = "Expand fold" } }

    local toggle_fold = { "n", "za", actions.toggle_fold, { desc = "Toggle fold" } }

    local expand_all_folds = { "n", "zR", actions.open_all_folds, { desc = "Expand all folds" } }

    local collapse_all_folds = { "n", "zM", actions.close_all_folds, { desc = "Collapse all folds" } }

    local function close_diff_view(key)
      return { { "n", "x" }, key, actions.close, { desc = "Close Diffview" } }
    end

    local function open_help_panel(panel)
      return { "n", "g?", actions.help(panel), { desc = "Open help panel" } }
    end

    local function collapse_fold(key)
      return { "n", key, actions.close_fold, { desc = "Collapse fold" } }
    end

    local function toggle_stage_unstage_selected(key)
      return { "n", key, actions.toggle_stage_entry, { desc = "Stage / unstage selected" } }
    end

    local function cursor_to_next_file(key)
      return { "n", key, actions.next_entry, { desc = "Diff - next file" } }
    end

    local function cursor_to_prev_file(key)
      return { "n", key, actions.prev_entry, { desc = "Diff - previous file" } }
    end

    local function select_entry(key)
      return { "n", key, actions.select_entry, { desc = "Open diff for selected" } }
    end

    local function close_help_menu(key)
      return { "n", key, actions.close, { desc = "Close help menu" } }
    end

    local function key_bindings_for_diff(diff)
      if diff == "diff2" then
        return {
          open_help_panel({ "view", diff }),
          restore_entry,
          select_next_file,
          select_prev_file,
          select_first_file,
          select_last_file,
          focus_files_panel,
          toggle_files_panel,
          close_diff_view("q"),
          close_diff_view("<esc>"),

          { "n", "<localleader>dg", "<cmd>diffget<CR>", { desc = "diffget - from other buffer" } },
          { "x", "<localleader>dg", ":diffget<CR>", { desc = "diffget - from other buffer" } },
          { "n", "<localleader>dp", "<cmd>diffput<CR>", { desc = "diffput - to other buffer" } },
          { "x", "<localleader>dp", ":diffput<CR>", { desc = "diffput - to other buffer" } },
        }
      end

      return {
        open_help_panel({ "view", diff }),
        restore_entry,
        select_next_file,
        select_prev_file,
        select_first_file,
        select_last_file,
        open_file_in_previous_tabpage,
        open_file_in_new_split,
        open_file_in_new_tabpage,
        focus_files_panel,
        toggle_files_panel,
        cycle_available_layouts,
        conflict_prev_conflict,
        conflict_next_conflict,
        conflict_choose_ours,
        conflict_choose_theirs,
        conflict_choose_base,
        conflict_choose_all,
        conflict_choose_none,
        conflict_choose_all_ours,
        conflict_choose_all_theirs,
        conflict_choose_all_base,
        conflict_choose_all_all,
        conflict_choose_all_none,
        diff_hunk_choose_ours,
        diff_hunk_choose_theirs,
        diff_hunk_choose_base,
        close_diff_view("q"),
        close_diff_view("<esc>"),
      }
    end

    require("diffview").setup({
      view = {
        -- Configure the layout and behavior of different types of views.
        -- Available layouts: 'diff1_plain' |'diff2_horizontal' |'diff2_vertical' |'diff3_horizontal' |'diff3_vertical' |'diff3_mixed' |'diff4_mixed'
        -- For more info, see |diffview-config-view.x.layout|.
        default = {
          -- Config for changed files, and staged files in diff views.
          layout = "diff2_horizontal",
          disable_diagnostics = false, -- Temporarily disable diagnostics for diff buffers while in the view.
          winbar_info = true, -- See |diffview-config-view.x.winbar_info|
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
          -- "a" = OURS (left/top-left) | "b" = LOCAL (center/bottom) | "c" = THEIRS (right/top-right) | "d" = BASE (diff4 only)
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
        view = {},
        diff1 = key_bindings_for_diff("diff1"),
        diff2 = key_bindings_for_diff("diff2"),
        diff3 = key_bindings_for_diff("diff3"),
        diff4 = key_bindings_for_diff("diff4"),
        file_panel = {
          cursor_to_next_file("j"),
          cursor_to_next_file("<down>"),
          cursor_to_prev_file("k"),
          cursor_to_prev_file("<up>"),
          select_entry("<cr>"),
          select_entry("o"),
          select_entry("l"),
          select_entry("<2-LeftMouse"),
          toggle_stage_unstage_selected("-"),
          toggle_stage_unstage_selected("s"),
          { "n", "S", actions.stage_all, { desc = "Stage all entries" } },
          { "n", "U", actions.unstage_all, { desc = "Unstage all entries" } },
          restore_entry,
          open_commit_log,
          expand_fold,
          collapse_fold("zc"),
          collapse_fold("h"),
          toggle_fold,
          expand_all_folds,
          collapse_all_folds,
          scroll_view_up,
          scroll_view_down,
          select_next_file,
          select_prev_file,
          select_first_file,
          select_last_file,
          open_file_in_previous_tabpage,
          open_file_in_new_split,
          open_file_in_new_tabpage,
          { "n", "i", actions.listing_style, { desc = "Toggle between 'list' and 'tree' views" } },
          { "n", "f", actions.toggle_flatten_dirs, { desc = "Flatten empty subdirectories in tree listing style" } },
          { "n", "R", actions.refresh_files, { desc = "Update stats and entries in file list" } },
          focus_files_panel,
          toggle_files_panel,
          cycle_available_layouts,
          conflict_prev_conflict,
          conflict_next_conflict,
          open_help_panel("file_panel"),
          conflict_choose_all_ours,
          conflict_choose_all_theirs,
          conflict_choose_all_base,
          conflict_choose_all_all,
          conflict_choose_all_none,
          close_diff_view("q"),
          close_diff_view("<esc>"),
        },
        file_history_panel = {
          { "n", "g!", actions.options, { desc = "Open option panel" } },
          { "n", "<C-A-d>", actions.open_in_diffview, { desc = "Open entry under cursor in a diffview" } },
          { "n", "y", actions.copy_hash, { desc = "Copy commit hash of entry under cursor" } },
          open_commit_log,
          expand_fold,
          collapse_fold("zc"),
          toggle_fold,
          expand_all_folds,
          collapse_all_folds,
          cursor_to_next_file("j"),
          cursor_to_next_file("<down>"),
          cursor_to_prev_file("k"),
          cursor_to_prev_file("<up>"),
          select_entry("<cr>"),
          select_entry("o"),
          select_entry("l"),
          select_entry("<2-LeftMouse"),
          scroll_view_up,
          scroll_view_down,
          select_next_file,
          select_prev_file,
          select_first_file,
          select_last_file,
          open_file_in_previous_tabpage,
          open_file_in_new_split,
          open_file_in_new_tabpage,
          focus_files_panel,
          toggle_files_panel,
          cycle_available_layouts,
          open_help_panel("file_history_panel"),
          close_diff_view("q"),
          close_diff_view("<esc>"),
        },
        option_panel = {
          select_entry("<tab>"),
          open_help_panel("option_panel"),
          close_help_menu("q"),
        },
        help_panel = {
          close_help_menu("q"),
          close_help_menu("<esc>"),
        },
      },
    })
  end,
}
