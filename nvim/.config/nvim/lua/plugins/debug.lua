-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',

    'nvim-neotest/nvim-nio',

    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'theHamsta/nvim-dap-virtual-text',

    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dapui.setup()
    require('nvim-dap-virtual-text').setup {
      clear_on_continue = true,
      display_callback = function(variable, buf, stackframe, node, options)
        local too_long_postfix = '...'
        local max_line_size = vim.api.nvim_win_get_width(0)

        local display_value = variable.value:gmatch('[^\r\n]+')()

        if display_value:len() > max_line_size then
          display_value = display_value:sub(1, max_line_size - too_long_postfix:len()) .. too_long_postfix
        end

        if options.virt_text_pos == 'inline' then
          return ' = ' .. display_value
        else
          return variable.name .. ' = ' .. display_value
        end
      end,
    }

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

    vim.keymap.set('n', '<leader>bc', dap.run_to_cursor, { desc = 'Run to cursor' })

    vim.keymap.set('n', '<Leader>bt', function()
      dapui.toggle()
    end, { desc = 'toggle ui' })

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
