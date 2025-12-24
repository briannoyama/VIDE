require("nvchad.configs.lspconfig").defaults()

local servers = {
  bashls = {},
  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        completeUnimported = true,
        gofumpt = true,
        semanticTokens = true,
        staticcheck = true,
        usePlaceholders = true,
      },
    },
  },
  html = {},
  marksman = {},
  ols = {},
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          typeCheckingMode = "basic",
        },
      },
    },
  },
  ts_ls = {},
  terraformls = {},
  yamlls = {
    settings = {
      yaml = {
        format = {
          printWidth = 160,
        },
      },
    },
  },
}

for name, opts in pairs(servers) do
  vim.lsp.enable(name) -- nvim v0.11.0 or above required
  vim.lsp.config(name, opts) -- nvim v0.11.0 or above required
end

-- read :h vim.lsp.config for changing options of lsp servers
