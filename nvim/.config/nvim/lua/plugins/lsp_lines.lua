return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  config = function()
    require('lsp_lines').setup()
    require('lsp_lines').toggle()

    vim.keymap.set('', '<Leader>l', function()
      vim.diagnostic.config {
        virtual_text = not require('lsp_lines').toggle(),
      }
    end, { desc = 'Toggle lsp [L]ines' })
  end,
}
