local Hydra = require "hydra"

Hydra.setup()

local dap = require "dap"
local dap_widgets = require "dap.ui.widgets"
local scope = dap_widgets.sidebar(dap_widgets.scopes, {}, "10 split")
local threads = dap_widgets.sidebar(dap_widgets.threads, {}, "10 split")
local frames = dap_widgets.sidebar(dap_widgets.frames, {}, "10 split")
-- local sessions = dap_widgets.sidebar(dap_widgets.sessions, {}, "30 hsplit")

local if_dap_filetype = function(do_func)
  return function()
    if vim.bo.filetype ~= "dap-float" then
      do_func()
    end
  end
end

DapHydra = Hydra {
  name = "Debug  ",
  hint = "Debug Mode",
  config = {
    color = "pink",
    desc = "Debug mode",
    invoke_on_body = true,
    hint = {
      hide_on_load = true,
    },
    on_enter = function()
      require("dap").continue()
      vim.cmd.redrawstatus()
    end,
    on_exit = function()
      scope.close()
      threads.close()
      frames.close()
      require("dap").terminate()
      vim.defer_fn(function()
        vim.cmd.redrawstatus()
      end, 1)
    end,
  },

  mode = "n",
  body = "<Leader>d",
  heads = {
    { "c", if_dap_filetype(dap.continue), { desc = "Continue" } },
    { "k", if_dap_filetype(dap.step_back), { desc = "Step Back" } },
    { "h", if_dap_filetype(dap.step_out), { desc = "Step Out" } },
    { "j", if_dap_filetype(dap.step_over), { desc = "Step Over" } },
    { "l", if_dap_filetype(dap.step_into), { desc = "Step Into" } },
    { "gl", require("dap-go").debug_last, { desc = "Debug Go Last" } },
    { "gt", require("dap-go").debug_test, { desc = "Debug Go Test" } },
    { "<Esc>", nil, { desc = "Debug Terminate", exit = true, nowait = true } },
    { "*", if_dap_filetype(dap.run_to_cursor), { desc = "Run to Cursor" } },
    { "r", dap.restart, { desc = "Step Into" } },
    { "K", if_dap_filetype(dap_widgets.hover), { desc = "Step Back" } },
    { "s", if_dap_filetype(scope.toggle), { desc = "Debug Scope UI" } },
    { "t", if_dap_filetype(threads.toggle), { desc = "Debug Threads UI" } },
    { "f", if_dap_filetype(frames.toggle), { desc = "Debug Frames UI" } },
  },
}

-- Press escape key to exit Hydra if still in use. Note: DapHydra:exit() does not exit Hydra
dap.listeners.before.event_terminated["dap-view-config"] = function()
  vim.api.nvim_input "<Esc>"
end

dap.listeners.before.event_exited["dap-view-config"] = function()
  vim.api.nvim_input "<Esc>"
end
