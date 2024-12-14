local Hydra = require('hydra')

Hydra.setup()

DapHydra = Hydra({
   name = "Debug  ",
   hint = "Debug Mode",
   config = {
      color = 'pink',
      desc = "Debug mode",
      invoke_on_body = true,
      hint = {
        hide_on_load = true,
      },
   },

   mode = 'n',
   body = '<Leader>d',
   heads = {
      { "b", function() require("dap").toggle_breakpoint() end, {desc = "Toggle breakpoint"}},
      { "c", function() if vim.bo.filetype ~= "dap-float" then require("dap").continue() end end, {desc = "Continue"}},
      { "k", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_back() end end, {desc = "Step Back"}},
      { "h", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_out() end end, {desc = "Step Out"}},
      { "j", function() if vim.bo.filetype ~= "dap-float" then print(vim.bo.filetype) require("dap").step_over() end end, {desc = "Step Over"}},
      { "l", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_into() end end, {desc = "Step Into"}},
      { "gl", function() require('dap-go').debug_last() end, {desc = "Debug Last"}},
      { "gt", function() require('dap-go').debug_test() end, {desc = "Debug Test"}},
      { "x", function() require("dap").terminate() end, {desc = "Debug Terminate"}},
      { "*", function() require("dap").run_to_cursor() end, {desc = "Run to Cursor"}},
      { "s", function() if vim.bo.filetype ~= "dap-float" then require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end end, {desc = "Debug UI"}},
      {"us", function() if vim.bo.filetype ~= "dap-float" then require('dap.ui.widgets').sidebar(require('dap.ui.widgets').scopes).open() end end, {desc = "Side Debug UI"}},
      {'<Esc>', nil, { exit = true, nowait = true , desc = "Exit Debug"}},
   }
})


