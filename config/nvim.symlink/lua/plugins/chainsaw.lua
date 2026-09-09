return {
  "chrisgrieser/nvim-chainsaw",
  event = "VeryLazy",
  opts = {},
  config = function()
    require('chainsaw').setup({})
    vim.keymap.set('n', '<leader>p', require('chainsaw').variableLog)
  end,
}
