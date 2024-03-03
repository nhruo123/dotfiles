-- TODO: add support to undo latest word added and support keybinds
-- also make wavey underline and less noisy error
-- make sure diagnostic isn't so bad
return {
  { 'davidmh/cspell.nvim' },
  {
    'nvimtools/none-ls.nvim',
    config = function()
      local null_ls = require 'null-ls'
      local c_spell = require 'cspell'
      null_ls.setup {
        sources = {
          c_spell.code_actions,
          c_spell.diagnostics.with {
            -- Force the severity to be HINT
            diagnostic_config = {
              virtual_text = false,
              signs = false,
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
