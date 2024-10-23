vim.api.nvim_set_option_value("clipboard", "unnamedplus", {})

---@type ChadrcConfig
 local M = {}
 M.ui = {theme = 'nightfox'}
 M.plugins = "custom.plugins"
 M.mappings = require "custom.mappings"
 return M
