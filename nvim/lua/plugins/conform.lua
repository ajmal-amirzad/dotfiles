return {
  "stevearc/conform.nvim",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
        ensure_installed = {
          "sqlfluff",
          "goimports",
          "gofumpt",
          "prettier"
        },
      },
    },
  },
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters = opts.formatters or {}

    opts.formatters.sqlfluff = {
      command = "sqlfluff",
      args = {
        "format",
        "--dialect",
        "ansi",
        "-",
      },
      stdin = true,
      require_cwd = false,
    }

    opts.formatters.goimports = {
      command = "goimports"
    }

    opts.formatters.gofumpt = {
      command = "gofumpt"
    }

    opts.formatters_by_ft.sql = {
      "sqlfluff"
    }
    opts.formatters_by_ft.go = {
      "goimports",
      "gofumpt"
    }
    opts.formatters_by_ft.javascript = {
      "prettier"
    }
    opts.formatters_by_ft.javascriptreact = {
      "prettier"
    }
    opts.formatters_by_ft["javascript.jsx"] = {
      "prettier"
    }
    opts.formatters_by_ft.typescript = {
      "prettier"
    }
    opts.formatters_by_ft.typescriptreact = {
      "prettier"
    }
    opts.formatters_by_ft["typescript.jsx"] = {
      "prettier"
    }
    opts.formatters_by_ft.json = {
      "prettier"
    }
    opts.formatters_by_ft.jsonc = {
      "prettier"
    }
    opts.formatters_by_ft.yaml = {
      "prettier"
    }
    opts.formatters_by_ft.markdown = {
      "prettier"
    }
  end,
}
