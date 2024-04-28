return {
  { 'davidmh/cspell.nvim' },
  {
    'nvimtools/none-ls.nvim',
    config = function()
      local null_ls = require 'null-ls'
      local c_spell = require 'cspell'

      local spell_dir = vim.fn.stdpath 'config' .. '/spell'

      local config = {
        find_json = function()
          return spell_dir .. '/cspell.json'
        end,
      }

      null_ls.setup {
        sources = {
          c_spell.code_actions.with {
            config = config,
          },
          c_spell.diagnostics.with {
            config = config,
            -- Force the severity to be HINT
            diagnostic_config = {
              virtual_text = false,
              signs = false,
              virtual_lines = false,
            },
            diagnostics_postprocess = function(diagnostic)
              diagnostic.severity = vim.diagnostic.severity.HINT
              diagnostic.severity = vim.diagnostic.severity.HINT
            end,
          },
        },
      }
    end,
  },
}
