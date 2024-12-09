return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      desc = 'Format buffer',
    },
  },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = function(bufnr)
        if require('conform').get_formatter_info('ruff_format', bufnr).available then
          return { 'ruff_format' }
        else
          return { 'isort', 'black' }
        end
      end,
      rust = { 'rustfmt' },
      typescript = { 'prettierd', 'prettier', 'eslint_d' },
      typescriptreact = { 'prettierd', 'prettier', 'eslint_d' },
      javascript = { 'prettierd', 'prettier', 'eslint_d' },
      javascriptreact = { 'prettierd', 'prettier', 'eslint_d' },
      terraform = { 'terraform_fmt' },
      sql = { 'sql_formatter' },
      json = { 'jq' },
    },
    format_on_save = function(bufnr)
      local disable_format_on_save_ft = { json = true }

      if disable_format_on_save_ft[vim.bo[bufnr].filetype] then
        return
      end

      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
    formatters = {
      sql_formatter = {
        prepend_args = { '-c', vim.fn.stdpath 'config' .. '/external_config/sql-formatter.json' },
      },
    },
  },
  init = function()
    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })
    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })
  end,
}
