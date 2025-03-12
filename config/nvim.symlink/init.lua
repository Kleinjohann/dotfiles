vim.opt.rtp:prepend("~/.vim")
vim.opt.rtp:append("~/.vim/after")

vim.opt.inccommand = "split"
vim.opt.undodir = "~/.vim/nvim-undo/"

vim.g.python3_host_prog = "/usr/bin/python3"

vim.cmd("source ~/.vimrc")

-- fix mismatched background for diagnostics signs
vim.o.termguicolors = false
vim.api.nvim_set_hl(0, "DiagnosticSignError", { ctermbg = 18, ctermfg = 1 })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { ctermbg = 18, ctermfg = 3 })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { ctermbg = 18, ctermfg = 14 })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { ctermbg = 18, ctermfg = 12 })
vim.api.nvim_set_hl(0, "DiagnosticSignOk", { ctermbg = 18, ctermfg = 2 })

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

vim.g.copilot_enabled = 0

require("config.lazy")
