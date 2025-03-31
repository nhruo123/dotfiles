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
      local function get_spell_namespace()
        local null = require 'null-ls'
        local d_null = require 'null-ls.diagnostics'
        return d_null.get_namespace((null.get_source { name = 'cspell' })[2].id)
      end

      local function get_all_namespaces_without(namespace_to_ignore)
        local good_namespaces = {}
        local index = 1
        for namespace, _ in pairs(vim.diagnostic.get_namespaces()) do
          if namespace ~= namespace_to_ignore then
            good_namespaces[index] = namespace
            index = index + 1
          end
        end

        return good_namespaces
      end

      vim.keymap.set('n', '[d', function()
        vim.diagnostic.jump { count = -1, float = true, namespace = get_all_namespaces_without(get_spell_namespace()) }
      end, { desc = 'Go to previous [D]iagnostic message' })

      vim.keymap.set('n', ']d', function()
        vim.diagnostic.jump { count = 1, float = true, namespace = get_all_namespaces_without(get_spell_namespace()) }
      end, { desc = 'Go to next [D]iagnostic message' })

      vim.keymap.set('n', '[z', function()
        vim.diagnostic.jump { count = -1, float = true, namespace = get_spell_namespace() }
      end, { desc = 'Go to previous [D]iagnostic message' })

      vim.keymap.set('n', ']z', function()
        vim.diagnostic.jump { count = 1, float = true, namespace = get_spell_namespace() }
      end, { desc = 'Go to next [D]iagnostic message' })
    end,
  },
}
