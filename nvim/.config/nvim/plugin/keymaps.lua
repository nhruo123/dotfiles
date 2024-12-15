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

-- Quick fix movement
vim.keymap.set('n', '<M-j>', '<cmd>cprev<CR>', { desc = 'Move down in quick fix list item' })
vim.keymap.set('n', '<M-k>', '<cmd>cnext<CR>', { desc = 'Move up in quick fix list item' })

-- center view after jump
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

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
-- window resize
vim.keymap.set('n', '<M-,>', '<c-w>5<')
vim.keymap.set('n', '<M-.>', '<c-w>5>')
vim.keymap.set('n', '<M-t>', '<C-W>+')
vim.keymap.set('n', '<M-s>', '<C-W>-')

vim.keymap.set('n', '<leader>f', vim.diagnostic.open_float, { desc = 'Diagnostic Open [F]loat' })
