return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
  },

  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
        },
        require 'neotest-plenary',
        require 'neotest-vim-test' {
          ignore_file_types = { 'python', 'vim', 'lua' },
        },
      },
    }

    vim.keymap.set('n', '<leader>rt', require('neotest').run.run, { desc = 'Run nearest test' })
    vim.keymap.set('n', '<leader>rT', function()
      require('neotest').run.run(vim.fn.expand '%')
    end, { desc = 'Run all tests in current file' })

    vim.keymap.set('n', '<leader>rd', function()
      require('neotest').run.run { strategy = 'dap' }
    end, { desc = 'Debug the nearest test' })
  end,
}
