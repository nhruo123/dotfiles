return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        integrations = {
          gitsigns = true,
          treesitter = true,
          telescope = { enabled = true },
          mini = {
            enabled = true,
          },
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
            inlay_hints = {
              background = true,
            },
          },
        },
      }
      -- setup must be called before loading
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
