require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "i" }, "<C-b>", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

map("n", "<Leader>lf", function()
  vim.diagnostic.open_float { border = "rounded" }
end, { desc = "Floating diagnostic" })
map("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "LSP signature help" })
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "<leader>gb", require("gitsigns").blame_line, { desc = "Blame line" })
map("n", "<leader>gc", "<cmd> Telescope git_commits <CR>", { desc = "Git commits" })
map("n", "<leader>gt", "<cmd> Telescope git_status <CR>", { desc = "Git status" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
