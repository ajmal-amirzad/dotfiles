return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "gopls",
        "goimports",
        "gofumpt",
        "delve",
      })
    end,
  },
  -- gopls: code actions, codelenses, analyses, hints, formatting support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          init_options = {
            semanticTokens = true,
          },
          settings = {
            gopls = {
              gofumpt = true,
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,

              analyses = {
                nilness = true,
                unusedparams = true,
                unusedvariable = true,
                unusedwrite = true,
                useany = true,
                shadow = true,
              },

              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },

              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },

              directoryFilters = {
                "-.git",
                "-.vscode",
                "-.idea",
                "-.vscode-test",
                "-node_modules",
              },
            },
          },
        },
      },
    },
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
    },
    ft = { "go", "gomod", "gowork", "gotmpl", "gosum" },
    build = ':lua require("go.install").update_all_sync()',
    opts = {
      gofmt = "gofumpt",
      goimports = "goimports",
      max_line_len = 120,

      -- Let LazyVim/lspconfig own gopls to avoid duplicate clients.
      lsp_cfg = true,
      lsp_keymaps = true,
      lsp_codelens = true,

      icons = false,

      dap_debug = true,
      dap_debug_gui = true,
      dap_debug_vt = {
        enabled = true,
        enabled_commands = true,
        all_frames = true,
      },
      dap_port = -1,
      dap_timeout = 15,
      dap_retries = 20,
    },
    config = function(_, opts)
      require("go").setup(opts)

      local dap = require("dap")

      dap.adapters.go = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      dap.configurations.go = vim.tbl_extend("force", dap.configurations.go or {}, {
        {
          type = "go",
          name = "Debug Main Package",
          request = "launch",
          program = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          dlvToolPath = vim.fn.exepath("dlv"),
          outputMode = "remote",
          dlvFlags = {
            "--log",
          },
        },
      })

      -- Format on save
      local format_group = vim.api.nvim_create_augroup("GoFormat", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = format_group,
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
      })

      -- Refresh gopls codelenses automatically
      local codelens_group = vim.api.nvim_create_augroup("GoCodeLens", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        group = codelens_group,
        pattern = "*.go",
        callback = function()
          pcall(vim.lsp.codelens.refresh)
        end,
      })
    end,
  },
}
