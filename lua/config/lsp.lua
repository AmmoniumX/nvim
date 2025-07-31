-- lsp
--------------------------------------------------------------------------------
-- See https://gpanders.com/blog/whats-new-in-neovim-0-11/ for a nice overview
-- of how the lsp setup works in neovim 0.11+.

-- This actually just enables the lsp servers.
-- The configuration is found in the lsp folder inside the nvim config folder,
-- so in ~.config/lsp/lua_ls.lua for lua_ls, for example.
vim.lsp.enable({'rust_analyzer', 'clangd', 'pyright', 'lua_ls'})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    vim.lsp.inlay_hint.enable(true)
    if client:supports_method('textDocument/completion') then
      vim.opt.completeopt = { 'menu', 'menuone','noinsert','fuzzy','popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end)
    end
  end,
})

-- Configure diagnostics display
vim.opt.winborder = 'rounded'
vim.diagnostic.config({
  virtual_text = true,      -- Show diagnostic message as virtual text
  virtual_lines = true,     -- Show diagnostic message as virtual lines
  signs = true,             -- Show diagnostic signs in the sign column
  underline = true,         -- Underline the text with an error
  update_in_insert = false, -- Don't update diagnostics in insert mode
  severity_sort = true,     -- Sort diagnostics by severity
  float = {
    border = "rounded",     -- Add border to floating diagnostic window
    source = "always",      -- Always show source of the diagnostic
    header = "",            -- No header in the floating diagnostic window
    prefix = "",            -- No prefix for each diagnostic item
  },
})

-- Mappings --
local bufopts = { noremap=true, silent=true }

vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show diagnostics in a floating window' })

-- Go to definition
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

-- Go to declaration
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)

-- Find implementations
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)

-- Find references
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

-- Find type definition
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)

-- Show hover documentation
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

-- Rename symbol
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)

-- Show code actions
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)

-- Show signature help
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

-- Navigate diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.jump, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump(1, { float = true }) end, { desc = 'Go to next diagnostic and show float' })
