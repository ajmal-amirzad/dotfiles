return {
  {
    "b0o/SchemaStore.nvim",
    enabled = false,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jsonls = {
          before_init = function() end,
          settings = {
            json = {
              schemas = {},
              validate = { enable = true },
            },
          },
        },

        yamlls = {
          before_init = function() end,
          settings = {
            yaml = {
              schemas = {},
              schemaStore = {
                enable = false,
                url = "",
              },
            },
          },
        },
      },
    },
  },
}
