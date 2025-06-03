return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      -- Configure diagnostics display
      vim.diagnostic.config({
        virtual_text = true,      -- Show diagnostic message as virtual text
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

      -- Configure hover and other LSP UI elements
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)                 -- Show documentation
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)           -- Go to definition
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)       -- Go to implementation
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)           -- Show all references
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)  -- Open diagnostic messages in floating window
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)         -- Go to previous diagnostic message
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)         -- Go to next diagnostic message
      end

      -- Set up Mason first
      require("mason").setup()
      
      -- Set up Mason-LSPConfig with servers to install
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ruff",
          "rust_analyzer",
        },
      })
      
    end,
  },
}
