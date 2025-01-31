return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = true,
  event = 'VeryLazy',
  opts = {
    default_file_explorer = true,
    keymaps = {
      ['<C-h>'] = false,
      ['<C-s>'] = 'actions.select_split',
      ['<C-v>'] = 'actions.select_vsplit',
    },
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
    {
      '<leader>e',
      function()
        require('oil').open()
      end,
      desc = 'Open file tree in current file directory',
    },
    {
      '<leader>E',
      function()
        require('oil').open(vim.fn.getcwd())
      end,
      desc = 'Open file tree in CWD',
    },
  },
}
