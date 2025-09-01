local options = {
  formatters_by_ft = {
    css = { "prettier" },
		golang = { "gofumpt", "goimports-reviser", "golines" },
		graphql = { "prettier" },
    html = { "prettier" },
		lua = { "stylua" },
		markdown = { "prettier" },
		python = { "yapf" },
		terraform = { "terraform_fmt", "terragrunt_hclfmt" },
		typescript = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
