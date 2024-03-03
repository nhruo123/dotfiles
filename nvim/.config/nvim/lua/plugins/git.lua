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

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
      'ibhagwan/fzf-lua', -- optional
    },
    config = true,
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
