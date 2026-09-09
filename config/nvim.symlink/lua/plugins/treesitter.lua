return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'main',
  lazy = false,
  build = ":TSUpdate",
  config = function()
      require'nvim-treesitter.config'.setup {
      indent = { enable = true },
      highlight = {
          enable = true,
          disable = function(lang, bufnr) -- Disable in large buffers
                        if lang == "latex" then
                            return true
                        end
                        return vim.api.nvim_buf_line_count(bufnr) > 50000
                    end,},
              folds = { enable = true },
  }

  require('nvim-treesitter').install {
        "bash",
        "c",
        "diff",
        "go",
        "gomod",
        "gosum",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
    }

  -- Explicitly tell the main branch to hook highlighting into buffers
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if lang then
          pcall(vim.treesitter.start, args.buf, lang)
        end
      end,
    })
  end
}
