return {
  "mason-org/mason.nvim",
  optional = true,
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
      "kotlin-lsp", -- required by kotlin
      "gopls", -- required by go
      "goimports", -- required by go and conform
      "gofumpt", -- required by  go and conform
      "delve", -- required by go
      "sqlfluff", -- required by conform
      "prettier", -- required by conform
      "golangci-lint", -- required by nvim-lint
      "detekt", -- required by nvim-lint
      "eslint_d", -- required by nvim-lint
    })
  end,
}
