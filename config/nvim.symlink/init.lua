vim.opt.rtp:prepend("~/.vim")
vim.opt.rtp:append("~/.vim/after")

vim.opt.inccommand = "split"
vim.opt.undodir = "~/.vim/nvim-undo/"

vim.g.python3_host_prog = "/usr/bin/python3"

vim.cmd("source ~/.vimrc")

-- LSP activation (references lsp/<filename>
vim.lsp.enable({
    "pyright",
    "lua",
    "go",
    "ruff",
    "ltex",
    "clangd",
    "tailwindcss",
})

-- rounded borders for all floats
local _border = "single"

-- diagnostics
vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    float = { border = _border },
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        -- this will set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
    },
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
})

-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
-- Be aware that you also will need to properly configure your LSP server to
-- provide the inlay hints.
vim.lsp.inlay_hint.enable(true)

-- fix mismatched background for diagnostics signs
vim.o.termguicolors = false
vim.api.nvim_set_hl(0, "DiagnosticSignError", { ctermbg = 18, ctermfg = 1 })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { ctermbg = 18, ctermfg = 3 })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { ctermbg = 18, ctermfg = 14 })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { ctermbg = 18, ctermfg = 12 })
vim.api.nvim_set_hl(0, "DiagnosticSignOk", { ctermbg = 18, ctermfg = 2 })

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", function() vim.diagnostic.jump {count=-1, float=true} end, opts)
vim.keymap.set("n", "]d", function() vim.diagnostic.jump {count=1, float=true} end, opts)

vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "gR", vim.lsp.buf.references, opts)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

vim.keymap.set('n', 'K', function() vim.lsp.buf.hover { border = 'rounded' } end)
vim.keymap.set("n", "gK", function() vim.lsp.buf.signature_help { border = _border, focusable = false, close_events = { "CursorMoved", "BufHidden", "InsertCharPre" }, } end, opts)
vim.keymap.set("i", "<c-k>", function() vim.lsp.buf.signature_help { border = _border, focusable = false, close_events = { "CursorMoved", "BufHidden", "InsertCharPre" }, } end, opts)
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>cw", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, opts)
vim.keymap.set("v", "<leader>cc", vim.lsp.codelens.run, opts)

vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, opts)

vim.g.copilot_enabled = 0

-- -- code lens
-- if opts.codelens.enabled and vim.lsp.codelens then
--   vim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
--     vim.lsp.codelens.refresh()
--     vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
--       buffer = buffer,
--       callback = vim.lsp.codelens.refresh,
--     })
--   end)
-- end
-- end

require("config.lazy")
