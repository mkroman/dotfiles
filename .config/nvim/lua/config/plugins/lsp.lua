local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Diagnostics config
-- vim.diagnostic.config({
--   underline = true,
--   virtual_text = true,
--   signs = true,
--   update_in_insert = false,
--   float = {
--     scope = "cursor",
--     border = "single",
--     header = "",
--     prefix = "",
--     focusable = false
--   }
-- })

-- Language server setups
-- require('lspconfig').rust_analyzer.setup {
--   capabilities = capabilities,
--   commands = {
--     RustOpenDocs = {
--       function()
--         vim.lsp.buf_request(vim.api.nvim_get_current_buf(), 'experimental/externalDocs', vim.lsp.util.make_position_params(), function(err, url)
--           if err then
--             error(tostring(err))
--           else
--             vim.fn['netrw#BrowseX'](url, 0)
--           end
--         end)
--       end,
--       description = 'Open documentation for the symbol under the cursor in default browser',
--     },
--   },
-- }

lspconfig.lua_ls.setup {
  capabilities = capabilities,
  filetypes = { "lua" },
  rootPatterns = { ".git" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        globals = { "vim", "Config" }
      },
      workspace = {
        library = { [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true },
        maxPreload = 10000
      },
      telemetry = {
        enable = false
      }
    }
  }
}

lspconfig.solargraph.setup {}
lspconfig.gopls.setup {}
lspconfig.tsserver.setup {}
lspconfig.bashls.setup {}
