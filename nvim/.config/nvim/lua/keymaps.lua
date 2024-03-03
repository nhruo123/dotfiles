-- search highlight
vim.keymap.set('i', '<C-c>', '<cmd>ehco "USE Ctrl+[ to leave insert mode!!!"<CR>', { desc = 'no serach highlight' })
-- search highlight
vim.keymap.set('n', '<C-c>', '<C-c><cmd>nohlsearch<CR>', { desc = 'no serach highlight' })
vim.keymap.set('n', '<C-[>', '<C-[><cmd>nohlsearch<CR>', { desc = 'no serach highlight' })
vim.keymap.set('n', '<leader>n', '<C-[><cmd>nohlsearch<CR>', { desc = 'no serach highlight' })

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- center view after jump
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- buffers
vim.keymap.set('n', '<leader>bp', '<c-6>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>new<cr>', { desc = 'New buffer' })
vim.keymap.set('n', '<leader>q', '<cmd>bd<cr>', { desc = 'quit buffer' })
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'write buffer' })

-- tabs
vim.keymap.set('n', '<leader>tl', '<cmd>tablast<cr>', { desc = 'Last Tab' })
vim.keymap.set('n', '<leader>tf', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<cr>', { desc = 'New Tab' })
vim.keymap.set('n', '<leader>tl', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
vim.keymap.set('n', '<leader>td', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
vim.keymap.set('n', '<leader>th', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- delete without overwriting clipboard
vim.keymap.set({ 'n', 'x' }, '<leader>d', '"_d', { desc = 'delete without overwriting clipboard' })
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'paste without overwriting clipboard' })

vim.keymap.set('n', '[d', function() end, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.goto_next { severity = { min = vim.diagnostic.severity.WARN } }
end, { desc = 'Go to next [D]iagnostic message' })

vim.keymap.set('n', '<leader>f', vim.diagnostic.open_float, { desc = 'Diagnostic Open [F]loat' })

vim.keymap.set('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'Next todo comment' })

vim.keymap.set('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'Previous todo comment' })

vim.keymap.set('n', '<leader>xx', function()
  require('trouble').toggle()
end, { desc = 'toggle trouble view' })
vim.keymap.set('n', '<leader>xw', function()
  require('trouble').toggle 'workspace_diagnostics'
end, { desc = '[W]orkspace' })
vim.keymap.set('n', '<leader>xb', function()
  require('trouble').toggle 'document_diagnostics'
end, { desc = '[B]uffer' })
vim.keymap.set('n', '<leader>xq', function()
  require('trouble').toggle 'quickfix'
end, { desc = '[Q]ickfix' })
