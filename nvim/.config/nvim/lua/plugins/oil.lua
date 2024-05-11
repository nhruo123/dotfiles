return {
  'stevearc/oil.nvim',
  config = function()
    local oil = require 'oil'
    oil.setup {
      default_file_explorer = true,
      keymaps = {
        ['C-s'] = 'actions.select_split',
        ['C-v'] = 'actions.select_vslit',
      },
      view_options = {
        show_hidden = true,
      },
    }

    vim.keymap.set('n', '<leader>E', oil.open, { desc = 'Open File Tree In cwd' })
    vim.keymap.set('n', '<leader>e', function()
      oil.open(oil.get_current_dir())
    end, { desc = 'Open File Tree In cwd' })
  end,
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
