return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}

    opts.servers.basedpyright = {
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = "standard",
            autoImportCompletions = true,
            diagnosticMode = "workspace",
          },
        },
      },
    }
    -- nvim-lint owns Ruff diagnostics
    opts.servers.ruff = opts.servers.ruff or {}
    opts.servers.ruff.enabled = false
  end,
}
