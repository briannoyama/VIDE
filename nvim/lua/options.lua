require "nvchad.options"

-- Copy paste to system clipboard
vim.api.nvim_set_option_value("clipboard", "unnamedplus", {})

-- Auto load last state
local auto_file = vim.fn.getcwd() .. "/.auto.vim"

local function close_nv_win(id)
  if vim.g and vim.g.nvchad_terms then
    for _, opts in pairs(vim.g.nvchad_terms) do
      if opts.id == id then
        vim.api.nvim_win_close(opts, true)
      end
    end
  end
end

vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    vim.cmd "helpclose"
    -- Focus if tree isn't open such that close command exists
    vim.cmd "NvimTreeFocus"
    vim.cmd "NvimTreeClose"
    -- Close Avante if it's open
    local avante = require "avante"
    if avante.is_sidebar_open() then
      avante.close_sidebar()
    end
    -- Close any open terminals
    close_nv_win "vtoggleTerm"
    close_nv_win "htoggleTerm"
    close_nv_win "floatTerm"
    -- Save state
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
