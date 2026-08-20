--if true then return {} end
return {
  {
    "rcasia/neotest-java",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-dap", -- for debugging (optional)
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "codymikol/neotest-kotlin",
      "rcasia/neotest-java",
      {
        "fredrikaverpil/neotest-golang",
        version = "*",                                                            -- Optional, but recommended; track releases
        build = function()
          vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
        end,
      }
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      opts.consumers = opts.consumers or {}
      opts.overseer = opts.overseer or {}

      opts.consumers.overseer = require("neotest.consumers.overseer")

      opts.overseer.enabled = true
      opts.overseer.force_default = true

      -- Explicitly require the adapters inside the opts function
      vim.list_extend(opts.adapters, {
        -- Java
        require("neotest-java")({
          test_classname_patterns = {
            "^.*Tests?\\.java$",
            "^.*IT\\.java$",
            "^.*Spec\\.java$",
          },
        }),
        -- Kotlin
        require("neotest-kotlin"),
        -- Go
        require("neotest-golang")({
          runner = "gotestsum",
          go_test_args = { "-v", "-race", "-count=1" },
          dap_go_enabled = true,
        })
      })
    end,
  },
}
