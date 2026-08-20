-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

local function resize_window(percent)
  local layout = vim.fn.winlayout()

  if layout[1] == "row" then
    vim.cmd("vertical resize " .. math.floor(vim.o.columns * percent))
  elseif layout[1] == "col" then
    vim.cmd("resize " .. math.floor(vim.o.lines * percent))
  end
end

wk.add({
  { "<leader>gw", group = "Worktree", icon = { icon = "󰙅", color = "azure" } },
  { "m", group = "Move line", icon = { icon = "", color = "green" }, mode = { "n", "x" } },
  { "<leader>gv", group = "Diffview", icon = { icon = "󱞊", color = "green" } },
  { "<leader>wy", group = "Resize Window", icon = { icon = "󰩨", color = "green" } },
  { "<C-w>y", group = "Resize Window", icon = { icon = "󰩨", color = "green" } },
  { "<leader>m", group = "bookmark", icon = { icon = "", color = "azure" }, mode = { "n", "x" } },
  { "<leader>tv", group = "TestTree", icon = { icon = "󰐆", color = "red" } },
  { "<localleader>c", group = "Conflict", icon = { icon = "󰽜", color = "azure" }, mode = { "n", "x" } },
  { "<localleader>d", group = "Diff Hunk", icon = { icon = "", color = "orange" }, mode = { "n", "x" } },
  { "<localleader>n", group = "Next", icon = { icon = "󰒭", color = "yellow" }, mode = { "n", "x" } },
  { "<localleader>p", group = "Previous", icon = { icon = "󰒮", color = "yellow" }, mode = { "n", "x" } },
  { "<localleader>x", group = "Restore Left Side", icon = { icon = "󰙰", color = "green" }, mode = { "n", "x" } },
})

vim.keymap.set("n", "<leader>ghP", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview" })

vim.keymap.set("n", "<leader>ba", "<cmd>%bd<CR>", { desc = "Close All Buffers" })
vim.keymap.set("n", "<leader>bn", "<cmd>tabnew<CR>", { desc = "New Buffer" })

vim.keymap.set("n", "[p", '<Cmd>exe "put! " . v:register<CR>', { desc = "Paste Above" })
vim.keymap.set("n", "]p", '<Cmd>exe "put " . v:register<CR>', { desc = "Paste Below" })

vim.keymap.set("n", "<leader>cz", function()
  vim.cmd("lsp restart")
  vim.notify("LSP restarted", vim.log.levels.INFO)
end, { desc = "Restart LSP" })

vim.keymap.set("n", "<leader>ghe", function()
  require("gitsigns").diff()
end, { desc = "Diff All Files" })

vim.keymap.set("n", "<leader>ghq", function()
  require("gitsigns").setloclist()
end, { desc = "Hunks List This" })

vim.keymap.set("n", "<leader>ghQ", function()
  require("gitsigns").setloclist(0, "all")
end, { desc = "Hunks List This" })

local sizes = {
  { size = 0.20, key = "2", desc = "Set size to 20%" },
  { size = 0.30, key = "3", desc = "Set size to 30%" },
  { size = 0.50, key = "5", desc = "Set size to 50%" },
  { size = 0.70, key = "7", desc = "Set size to 70%" },
  { size = 0.80, key = "8", desc = "Set size to 80%" },
  { size = 0.90, key = "9", desc = "Set size to 90%" },
}

for _, size in ipairs(sizes) do
  vim.keymap.set("n", "<leader>w" .. size.key, function()
    resize_window(size.size)
  end, { desc = size.desc })

  vim.keymap.set("n", "<C-w>" .. size.key, function()
    resize_window(size.size)
  end, { desc = size.desc })
end

vim.keymap.set("n", "<leader>gvb", function()
  local branches = vim.fn.systemlist({
    "git",
    "for-each-ref",
    "--sort=-committerdate",
    "--format=%(refname:short)%09%(objectname:short)%09%(committerdate:relative)%09%(authorname)%09%(subject)",
    "refs/heads",
    "refs/remotes",
  })

  if vim.v.shell_error ~= 0 or #branches == 0 then
    vim.notify("No local branches found", vim.log.levels.ERROR)
    return
  end

  local current = vim.fn.systemlist({
    "git",
    "branch",
    "--show-current",
  })[1]

  local items = {}

  for _, line in ipairs(branches) do
    local branch, hash, date, author, subject = line:match("^(.-)\t(.-)\t(.-)\t(.-)\t(.*)$")

    if branch then
      table.insert(items, {
        text = string.format("%-25s %s | %s | %s | %s", branch, hash, date, author, subject),
        branch = branch,
        hash = hash,
      })
    end
  end

  Snacks.picker.pick({
    source = "branches",
    title = "Select branch to compare",
    items = items,
    format = "text",
    layout = {
      preview = false,
      layout = {
        width = 0.85,
        height = 0.85,
        min_width = 85,
        max_width = 170,
        min_height = 30,
        max_height = 85,
        position = "float",
      },
    },
    confirm = function(picker, item)
      picker:close()

      if not item then
        return
      end

      if item.branch == current then
        vim.notify("Cannot compare a branch against itself", vim.log.levels.WARN)
        return
      end

      vim.cmd("DiffviewOpen " .. item.branch .. " ...HEAD")
    end,
  })
end, { desc = "Diffview Branch" })

vim.keymap.set("n", "<leader>gvc", function()
  local commits = vim.fn.systemlist({
    "git",
    "log",
    "--format=%H%x09%h %s (%cr) - %an",
    "HEAD",
  })

  if vim.v.shell_error ~= 0 or #commits == 0 then
    vim.notify("No commits found", vim.log.levels.ERROR)
    return
  end

  local items = {}

  for _, line in ipairs(commits) do
    local hash, label = line:match("^(%x+)\t(.+)$")

    if hash then
      table.insert(items, {
        text = label,
        commit = hash,
      })
    end
  end

  Snacks.picker.pick({
    source = "commits",
    title = "Select commit to compare",
    items = items,
    format = function(item)
      return {
        { item.text },
      }
    end,
    layout = {
      preview = false,
      layout = {
        width = 0.85,
        height = 0.85,
        min_width = 85,
        max_width = 170,
        min_height = 30,
        max_height = 85,
        position = "float",
      },
    },
    confirm = function(picker, item)
      picker:close()

      if item then
        vim.cmd("DiffviewOpen " .. item.commit)
      end
    end,
  })
end, { desc = "Diffview Commit" })

Snacks.util.lsp.on({ name = "gopls" }, function(bufnr, client)
  pcall(vim.keymap.del, "n", "<leader>rn", { buffer = bufnr })

  pcall(vim.keymap.del, "n", "<leader>wa", { buffer = bufnr })
  pcall(vim.keymap.del, "n", "<leader>wl", { buffer = bufnr })
  pcall(vim.keymap.del, "n", "<leader>wr", { buffer = bufnr })

  pcall(vim.keymap.del, "n", "<leader>e", { buffer = bufnr })
  pcall(vim.keymap.del, "n", "<leader>ff", { buffer = bufnr })
end)
