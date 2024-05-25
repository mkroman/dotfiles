local keymap = vim.keymap

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local function desc(description)
      return { noremap = true, silent = true, buffer = bufnr, desc = description }
    end

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    keymap.set('n', 'gD', vim.lsp.buf.declaration, desc('[lsp] go to declaration'))
    keymap.set('n', 'gd', vim.lsp.buf.definition, desc('[lsp] go to definition'))
    keymap.set('n', 'K', vim.lsp.buf.hover, desc('[lsp] hover'))
    keymap.set('n', 'gi', vim.lsp.buf.implementation, desc('[lsp] go to implementation'))
    keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, desc('[lsp] add workspace folder'))
    keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, desc('[lsp] remove workspace folder'))
    keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, desc('[lsp] code action'))
    keymap.set({ 'n' }, '<M-CR>', vim.lsp.buf.code_action, desc('[lsp] code action'))
    keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    if client.server_capabilities.inlayHintProvider then
      keymap.set('n', '<space>h', function()
        local current_setting = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
        vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
      end, desc('[lsp] toggle inlay hints'))
    end
  end,
})
