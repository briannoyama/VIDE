return {
	formatters_by_ft = {
		lua = { "stylua" },
		golang = { "gofumpt", "goimports-reviser", "golines" },
		graphql = { "prettier" },
		markdown = { "prettier" },
		odin = { "odinfmt" },
		python = { "yapf" },
		terraform = { "terraform_fmt", "terragrunt_hclfmt" },
		typescript = { "prettier" },
		yaml = { "yamlfix" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
}
