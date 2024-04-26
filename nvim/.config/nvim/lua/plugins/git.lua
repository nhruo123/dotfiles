local close_map = { 'n', 'q', '<CMD>DiffviewClose<CR>', { desc = 'Close diffview' } }

return {
  {
    'sindrets/diffview.nvim',
    opts = {
      enhanced_diff_hl = true,
      keymaps = {
        view = {
          close_map,
        },
        file_panel = {
          close_map,
        },
      },
    },
    keys = {
      {
        '<leader>gd',
        function()
          require('diffview').open {}
        end,
        desc = 'Open diffview',
      },
    },
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      'nvim-telescope/telescope.nvim', -- optional
    },
    config = function()
      require('neogit').setup {
        integrations = {
          telescope = true,
          diffview = true,
        },
      }
    end,

    keys = {
      {
        '<leader>go',
        function()
          require('neogit').open {}
        end,
        desc = 'Open neogit',
      },
    },
  },
}
