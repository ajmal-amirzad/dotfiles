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
              init_options = {
                jdt_uri_timeout_ms = 120000,
              },
              settings = {
                java = {
                  completion = {
                    enable = true,
                    favoriteStaticMembers = {
                      "org.junit.Assert.*",
                      "org.junit.Assume.*",
                      "org.junit.jupiter.api.Assertions.*",
                      "org.junit.jupiter.api.Assumptions.*",
                      "org.junit.jupiter.api.DynamicContainer.*",
                      "org.junit.jupiter.api.DynamicTest.*",
                      "org.hamcrest.MatcherAssert.assertThat",
                      "org.hamcrest.Matchers.*",
                      "org.mockito.Mockito.*",
                    },
                    importOrder = {
                      "java",
                      "javax",
                      "com",
                      "org",
                    },
                  },
                  configuration = {
                    updateBuildConfiguration = "interactive", -- Prompt to update build files when new dependencies are added
                  },
                  contentProvider = {
                    preferred = "fernflower", -- Use fernflower to decompile library code
                  },
                  eclipse = {
                    downloadSources = true, -- Automatically download sources for Eclipse projects
                  },
                  errors = {
                    incompleteClasspath = {
                      severity = "warning", -- Show incomplete classpath issues as warnings
                    },
                  },
                  format = {
                    enabled = true,
                    settings = {
                      url = vim.fn.stdpath("config") .. "/eclipse-java-sane-style.xml",
                      profile = "SaneJava",
                    },
                  },
                  implementationsCodeLens = {
                    enabled = true, -- Inline implementation tracking counts
                  },
                  inlayHints = {
                    parameterNames = {
                      enabled = "none", -- Show parameter names for all functions
                    },
                  },
                  maven = {
                    downloadSources = true, -- Automatically download sources for Maven projects
                  },
                  referencesCodeLens = {
                    enabled = true, -- Inline reference tracking counts
                  },
                  references = {
                    includeDecompiledSources = true,
                  },
                  saveActions = {
                    organizeImports = true, -- Automatically organize imports on save
                    cleanup = true, -- Perform code cleanup on save, such as removing unused imports and formatting
                  },
                  signatureHelp = { -- Enhanced signature help with method overloads and parameter hints
                    enabled = true,
                    description = {
                      enabled = true, -- Show method descriptions in signature help
                    },
                  },
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
