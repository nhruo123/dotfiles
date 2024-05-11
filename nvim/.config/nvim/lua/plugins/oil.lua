return {
  'stevearc/oil.nvim',
  config = function()
    local oil = require 'oil'
    oil.setup {
      default_file_explorer = true,
      keymaps = { 
        ["<C-h>"] = false,
        ['<C-s>'] = 'actions.select_split',
        ['<C-v>'] = 'actions.select_vsplit',
      },
      view_options = {
        show_hidden = true,
      },
    }

    vim.keymap.set('n', '<leader>E', oil.open_float, { desc = 'Open File Tree In cwd' })
    vim.keymap.set('n', '<leader>e', function()
      oil.open_float(oil.get_current_dir())
    end, { desc = 'Open File Tree In cwd' })
  end,
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
