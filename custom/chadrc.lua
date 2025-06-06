-- Copy paste to system clipboard
vim.api.nvim_set_option_value("clipboard", "unnamedplus", {})

-- Auto load last state
local auto_file = vim.fn.getcwd() .. "/.auto.vim"

vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    vim.cmd "helpclose"
    -- Focus if tree isn't open such that close command exists
    vim.cmd "NvimTreeFocus"
    vim.cmd "NvimTreeClose"
    vim.cmd("mksession! " .. auto_file)
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.filereadable(auto_file) == 1 then
      vim.cmd('echo "Loading ' .. auto_file .. '"')
      -- After VimEnter other NVChad stuff needs to load, so wait 1ms
      vim.defer_fn(function()
        vim.cmd("source " .. auto_file)
      end, 1)
    else
      vim.cmd 'echo "Auto resume session (.auto.vim) not found"'
    end
  end,
})

vim.o.shell = "/usr/bin/bash"

-- Custom key maps here
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "i" }, "<C-b>", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

---@type ChadrcConfig
local M = {}
M.ui = {
  theme = "nightfox",
  theme_toggle = { "nightfox", "penumbra_light" },
  statusline = {
    theme = "default",
    separator_style = "default",
    overriden_modules = require "custom.configs.hydra-status",
  },
}

M.plugins = "custom.plugins"
M.lazy_nvim = {
  defaults = { lazy = false },
}

return M
