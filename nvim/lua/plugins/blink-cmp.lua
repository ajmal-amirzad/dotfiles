-- code completion - tab to navigate, shift+tab to navigate backwards
return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    },
    completion = {
      menu = {
        border = "rounded",
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = {
          border = "rounded",
        },
      },
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },
  },
}
