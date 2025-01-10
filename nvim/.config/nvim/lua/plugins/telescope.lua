return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-telescope/telescope-smart-history.nvim',
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      -- Useful for getting pretty icons, but requires special font.
      --  If you already have a Nerd Font, or terminal set up with fallback fonts
      --  you can enable this

      'kkharji/sqlite.lua',
      'nvim-telescope/telescope-fzy-native.nvim',
      'nvim-tree/nvim-web-devicons',
      {},
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of help_tags options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          path_display = {
            'filename_first',
          },
          history = {
            path = vim.fn.stdpath 'data' .. '/telescope_history.sqlite3',
            limit = 200,
          },
          mappings = {
            i = {
              ['<C-k>'] = require('telescope.actions').cycle_history_next,
              ['<C-j>'] = require('telescope.actions').cycle_history_prev,
              ['<C-s>'] = require('telescope.actions').select_horizontal,
              ['<C-space>'] = require('telescope.actions').to_fuzzy_refine,
            },
            n = {
              ['<C-s>'] = require('telescope.actions').select_horizontal,
              ['<C-k>'] = require('telescope.actions').cycle_history_next,
              ['<C-j>'] = require('telescope.actions').cycle_history_prev,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          history = {
            path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
            limit = 200,
          },
          fzf = {},
        },
        pickers = {
          oldfiles = {
            sort_lastused = true,
          },
          find_files = {
            file_ignore_patterns = {
              '.git/',
              '.node_modules/',
              '.venv/',
              '^.venv/*',
            },
            hidden = true,
          },
          grep_string = {
            additional_args = function(_)
              return { '--hidden' }
            end,
          },
        },
      }
      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'smart_history')

      local builtin = require 'telescope.builtin'

      vim.keymap.set('n', '<c-p>', builtin.find_files, { desc = 'Search files' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sF', function()
        builtin.find_files { hidden = true }
      end, { desc = '[S]earch ALL [F]iles' })
      vim.keymap.set({ 'n', 'x' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })
      vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>so', function()
        builtin.oldfiles { only_cwd = true, sort_lastused = true }
      end, { desc = '[S]earch cwd [O]ld Files' })
      vim.keymap.set('n', '<leader>sO', builtin.oldfiles, { desc = '[S]earch all [O]ld Files' })
      vim.keymap.set('n', '<leader>st', '<cmd>:TodoTelescope<cr>', { desc = '[S]earch Todo' })
      vim.keymap.set('n', '<leader>s/', function()
        require('custom.telescope.custom').glob_grep {
          glob_pattern = { '!.git/**', '!.node_modules', '!.venv' },
          additional_args = function(_)
            return { '--hidden' }
          end,
        }
      end, { desc = '[S]earch [/] in Open Files' })
      vim.keymap.set('n', '<leader>:', builtin.commands, { desc = '[:] commands' })
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
