-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    'nvim-neotest/nvim-nio',
    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    -- 'theHamsta/nvim-dap-virtual-text',

    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    -- require("nvim-dap-virtual-text").setup()

    ---@diagnostic disable-next-line: missing-fields
    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
        'python',
        'codelldb',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_back, { desc = 'Debug: Step Back' })
    vim.keymap.set('n', '<F2>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F3>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F4>', dap.step_out, { desc = 'Debug: Step Out' })

    vim.keymap.set('n', '<leader>br', dap.repl.open, { desc = 'open repl' })

    vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>bB', function()
      dap.set_breakpoint(vim.fn.input 'breakpoint condition: ')
    end, { desc = 'Toggle Breakpoint' })

    vim.keymap.set('n', '<Leader>bl', function()
      require('dap').run_last()
    end, { desc = 'run last config' })

    vim.keymap.set('n', '<leader>be', dapui.eval, { desc = 'eval' })
    vim.keymap.set('n', '<leader>bE', function()
      dapui.eval(vim.fn.input '[DAP] Expression > ')
    end, { desc = 'Eval with expression' })

    vim.keymap.set({ 'n', 'v' }, '<Leader>bh', function()
      require('dap.ui.widgets').hover()
    end, { desc = 'Hover' })
    vim.keymap.set('n', '<Leader>br', function()
      dapui.close()
      dapui.open { reset = true }
    end, { desc = 'reset ui' })

    vim.keymap.set('n', '<Leader>bt', function()
      dapui.toggle()
    end, { desc = 'toggle ui' })
    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {}

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    dap.configurations.rust = {
      {
        name = 'Launch',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
    }

    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        -- CHANGE THIS to your path!
        command = vim.fn.glob(vim.fn.stdpath 'data' .. '/mason/') .. 'packages/codelldb/codelldb',
        args = { '--port', '${port}' },

        -- On windows you may have to uncomment this:
        -- detached = false,
      },
    }
    require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'c', 'cpp' } })

    require('dap-python').setup '~/.virtualenvs/debugpy/bin/python'
  end,
}
