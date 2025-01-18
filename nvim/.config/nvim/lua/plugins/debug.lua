return {
  'mfussenegger/nvim-dap',
  lazy = true,
  event = 'VeryLazy',
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      opts = {},
      keys = {

        {
          '<leader>be',
          function()
            require('dapui').eval()
          end,
          mode = { 'n', 'v' },
          desc = 'eval',
        },
        {
          '<leader>bE',
          function()
            require('dapui').eval(vim.fn.input '[DAP] Expression > ')
          end,
          desc = 'Eval with expression',
        },
        {
          '<Leader>bh',
          function()
            require('dap.ui.widgets').hover()
          end,
          desc = 'Hover',
          mode = { 'n', 'v' },
        },
        {
          '<Leader>br',
          function()
            require('dapui').close()
            require('dapui').open { reset = true }
          end,
          desc = 'reset ui',
        },
        {
          '<Leader>bt',
          function()
            require('dapui').toggle()
          end,
          desc = 'toggle ui',
        },
      },
      config = function(_, opts)
        local dap = require 'dap'
        local dapui = require 'dapui'
        dapui.setup(opts)

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close
      end,
    },
    'nvim-neotest/nvim-nio',
    {
      'jay-babu/mason-nvim-dap.nvim',
      cmd = { 'DapInstall', 'DapUninstall' },
      dependencies = {
        'williamboman/mason.nvim',
      },
      opts = {
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
      },
    },
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {
        clear_on_continue = true,
        display_callback = function(variable, buf, stackframe, node, options)
          local too_long_postfix = '...'
          local max_line_size = vim.api.nvim_win_get_width(0)

          local display_value = variable.value:gmatch '[^\r\n]+'()

          if display_value:len() > max_line_size then
            display_value = display_value:sub(1, max_line_size - too_long_postfix:len()) .. too_long_postfix
          end

          if options.virt_text_pos == 'inline' then
            return ' = ' .. display_value
          else
            return variable.name .. ' = ' .. display_value
          end
        end,
      },
    },
    'mfussenegger/nvim-dap-python',
  },
  keys = {
    {
      '<F1>',
      function()
        require('dap').step_back()
      end,
      desc = 'Debug: Step Back',
    },
    {
      '<F2>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F3>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F4>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<leader>br',
      function()
        require('dap').repl.open()
      end,
      desc = 'open repl',
    },
    {
      '<leader>bb',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Toggle Breakpoint',
    },
    {
      '<leader>bB',
      function()
        require('dap').set_breakpoint(vim.fn.input 'breakpoint condition: ')
      end,
      desc = 'Toggle Breakpoint',
    },
    {
      '<Leader>bl',
      function()
        require('dap').run_last()
      end,
      desc = 'run last config',
    },
    {
      '<leader>bc',
      function()
        require('dap').run_to_cursor()
      end,
      desc = 'Run to cursor',
    },
  },
  config = function()
    local dap = require 'dap'

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

    require('dap-python').setup '~/.virtualenvs/debugpy/bin/python'
  end,
}
