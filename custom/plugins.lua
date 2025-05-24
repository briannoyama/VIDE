local plugins = {
  require "custom.configs.avante",
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
    "nvimtools/hydra.nvim",
    config = function()
      require "custom.configs.hydras"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "go",
        "gomod",
        "hcl",
        "python",
        "terraform",
        "typescript",
      },
    },
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    event = "BufWritePre",
    opts = require "custom.configs.conform",
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
      require("nvim-dap-virtual-text").setup {
        commented = true,
        virt_text_pos = "eol",
      }
    end,
  },
}

return plugins
