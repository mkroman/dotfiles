-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Split windows.
vim.keymap.set('n', '<leader>-', "<Cmd>new<CR>")
vim.keymap.set('n', '<leader>\\', "<Cmd>vnew<CR>")

-- Quick save.
vim.keymap.set('n', '<leader>w', '<Cmd>w!<CR>')
