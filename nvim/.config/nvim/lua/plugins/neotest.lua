return {
  'nvim-neotest/neotest',
  event = 'VeryLazy',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
    'mfussenegger/nvim-dap',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
        },
      },
    }
  end,
  keys = {
    {
      '<leader>rt',
      function()
        require('neotest').run.run()
      end,
      desc = 'Run nearest test',
    },
    {
      '<leader>rT',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'Run all tests in current file',
    },
    {
      '<leader>rd',
      function()
        require('neotest').run.run { strategy = 'dap' }
      end,
      desc = 'Debug the nearest test',
    },
  },
}
