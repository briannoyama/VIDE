vim.api.nvim_set_option_value("clipboard", "unnamedplus", {})

vim.o.shell = "/usr/bin/bash"

---@type ChadrcConfig
 local M = {}
 M.ui = {theme = 'nightfox'}
 M.plugins = "custom.plugins"
 M.mappings = require "custom.mappings"
 return M
