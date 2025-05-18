return {
  formatters_by_ft = {
    lua = { "stylua" },
    golang = { "gofumpt", "goimports-reviser", "golines" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
