-- search highligh
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

local function get_spell_namespace()
  local null = require 'null-ls'
  local d_null = require 'null-ls.diagnostics'
  local namespace = nil

  for _, k in pairs(null.get_sources()) do
    if k.name == 'cspell' then
      namespace = d_null.get_namespace(k.id)
    end
  end

  return namespace
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
  vim.diagnostic.goto_prev { namespace = get_all_namespaces_without(get_spell_namespace()) }
end, { desc = 'Go to previous [D]iagnostic message' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.goto_next { namespace = get_all_namespaces_without(get_spell_namespace()) }
end, { desc = 'Go to next [D]iagnostic message' })

vim.keymap.set('n', '[z', function()
  vim.diagnostic.goto_prev { namespace = get_spell_namespace() }
end, { desc = 'Go to previous [D]iagnostic message' })

vim.keymap.set('n', ']z', function()
  vim.diagnostic.goto_next { namespace = get_spell_namespace() }
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
