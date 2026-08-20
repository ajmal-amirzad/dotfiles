return {
  {
    "nvim-java/nvim-java",
    config = false,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        opts = {
          servers = {
            jdtls = {
              settings = {
                java = {
                  configuration = {
                    updateBuildConfiguration = "automatic", -- Automatically updates the Java project configuration when build files change.
                  },
                  contentProvider = {
                    preferred = "fernflower", -- Use fernflower to decompile library code
                  },
                  eclipse = {
                    downloadSources = true, -- Automatically download sources for Eclipse projects
                  },
                  format = {
                    enabled = true,
                    onType = {
                      enabled = false,
                    },
                    settings = {
                      url = vim.fn.stdpath("config") .. "/eclipse-java-sane-style.xml",
                      profile = "SaneJava",
                    },
                  },
                  maven = {
                    downloadSources = true, -- Automatically download sources for Maven projects
                  },
                  inlayHints = {
                    parameterNames = {
                      enabled = "none", -- Don't show inlay hints
                    },
                  },
                  -- referencesCodeLens = {
                  --   enabled = false,
                  -- },
                },
              },
            },
          },
          setup = {
            jdtls = function()
              require("java").setup({
                jdk = { auto_install = false },
                root_markers = {
                  "mvnw",
                  "pom.xml",
                  "gradlew",
                  "build.gradle",
                  "build.gradle.kts",
                  "settings.gradle",
                  "settings.gradle.kts",
                },
              })
            end,
          },
        },
      },
    },
  },
}
