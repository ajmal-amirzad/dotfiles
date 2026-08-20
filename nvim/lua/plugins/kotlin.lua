return {
  -- Main Kotlin Plugin (Official JetBrains LSP + extras)
  {
    "AlexandrosAlexiou/kotlin.nvim",
    ft = { "kotlin" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "stevearc/oil.nvim",
      "folke/trouble.nvim",
    },

    config = function()
      require("kotlin").setup({
        root_markers = {
          "gradlew",
          "build.gradle.kts",
          "build.gradle",
          "settings.gradle",
          "settings.gradle.kts",
          "mvnw",
          "pom.xml",
        },
        inlay_hints = { enabled = true },
        folding = {
          enabled = true,
        },
      })

      -- require("mason-lspconfig").setup({
      --   automatic_enable = {
      --     exclude = { "kotlin_lsp" },
      --   },
      -- })
    end,
  },
  -- IMPORTANT: Exclude kotlin_lsp from mason-lspconfig's automatic_enable
  -- so kotlin.nvim can start it with its custom handlers.
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = {
        exclude = { "kotlin_lsp" },
      },
    },
  },
}
