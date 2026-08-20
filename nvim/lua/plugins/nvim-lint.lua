return {
  "mfussenegger/nvim-lint",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
        ensure_installed = {
          "golangci-lint",
          "detekt",
          "eslint_d"
        },
      },
    },
  },
  event = {
    "BufReadPost",
    "BufNewFile",
    "BufWritePost",
    "InsertLeave",
  },
  opts = {
    linters_by_ft = {
      go = {
        "golangcilint",
      },
      kotlin = {
        "detekt",
      },
      javascript = {
        "eslint_d",
      },
      javascriptreact = {
        "eslint_d",
      },
      ["javascript.jsx"] = {
        "eslint_d",
      },
      typescript = {
        "eslint_d",
      },
      typescriptreact = {
        "eslint_d",
      },
      ["typescript.tsx"] = {
        "eslint_d",
      },
    },
  },
  config = function(_, opts)
    local lint = require("lint")

    lint.linters_by_ft = opts.linters_by_ft

    local group = vim.api.nvim_create_augroup("UserLinting", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = group,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
