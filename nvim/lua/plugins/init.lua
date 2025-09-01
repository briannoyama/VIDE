return {
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = "mfussenegger/nvim-dap",
		config = function(_, opts)
			require("dap-go").setup(opts)
		end,
	},
	{
		"mfussenegger/nvim-dap",
		init = function()
			vim.fn.sign_define("DapBreakpoint", { text = "🛑" })
		end,
	},
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
	{
		"nvimtools/hydra.nvim",
		config = function()
			require("configs.hydras")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"bash",
        "css",
				"go",
				"gomod",
				"hcl",
        "html",
  			"lua",
				"python",
				"terraform",
				"typescript",
        "vimdoc",
			},
		},
	},
	{
		"olexsmir/gopher.nvim",
		version = "v0.2.0",
		ft = "go",
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
		opts = {},
	},
  {
    "stevearc/conform.nvim",
		cmd = { "ConformInfo" },
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
  },
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
		init = function()
			require("nvim-dap-virtual-text").setup({
				commented = true,
				virt_text_pos = "eol",
			})
		end,
	},


  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },
}

