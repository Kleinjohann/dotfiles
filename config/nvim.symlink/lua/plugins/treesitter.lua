return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  lazy = false,
  build = ":TSUpdate",
  config = function()
      require'nvim-treesitter.configs'.setup {
      indent = { enable = true },
      highlight = {
          enable = true,
          disable = function(lang, bufnr) -- Disable in large buffers
              return vim.api.nvim_buf_line_count(bufnr) > 50000
          end,},
      folds = { enable = true },
      ensure_installed = {
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
      },
      auto_install = true,
  }
  end
}
